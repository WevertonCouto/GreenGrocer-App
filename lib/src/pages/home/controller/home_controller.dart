import 'package:get/get.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/home/repository/home_repository.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

import '../../../models/category_model.dart';

const int itemsPerPage = 6;

class HomeController extends GetxController {
  final homeRepository = HomeRepository();

  bool isCategoryloading = false;
  bool isProductLoading = true;
  List<CategoryModel> allCategories = [];
  CategoryModel? currentCategory;
  List<ItemModel> get allProducts => currentCategory?.items ?? [];
  bool get isLastPage {
    if (currentCategory!.items.length < itemsPerPage) return true;
    return (currentCategory!.pagination * itemsPerPage) > allProducts.length;
  }

  RxString searchTitle = ''.obs;

  void setLoading(bool value, {bool isProduct = false}) {
    if (isProduct) {
      isProductLoading = value;
    } else {
      isCategoryloading = value;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    debounce(
      searchTitle,
      (_) {
        filterByTitle();
      },
      time: const Duration(milliseconds: 600),
    );

    getAllCategories();
  }

  void filterByTitle() {
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    if (searchTitle.value.isEmpty) {
      allCategories.removeAt(0);
    } else {
      if (allCategories.first.title != 'Todos') {
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

        allCategories.insert(0, allProductsCategory);
      } else {
        allCategories.first.items.clear();
      }
    }

    currentCategory = allCategories.first;
    update();
    getAllProducts();
  }

  void selectCategory(CategoryModel categoryModel) {
    currentCategory = categoryModel;
    update();
    if (categoryModel.items.isEmpty) getAllProducts();
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    final HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

    homeResult.when(
      success: (data) {
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) setLoading(true, isProduct: true);

    final body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemPerPage': itemsPerPage,
      //'title': searchTitle.value
    };

    if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);
    setLoading(false, isProduct: true);

    result.when(success: (data) {
      currentCategory!.items.addAll(data);
      update();
    }, error: (message) {
      UtilsServices.showToast(message: message, isError: true);
    });
  }
}
