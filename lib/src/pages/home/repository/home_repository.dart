import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/category_model.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/home/result/home_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map((v) => CategoryModel.fromJson(v))
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult<CategoryModel>.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map((v) => ItemModel.fromJson(v))
          .toList();
      return HomeResult.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar os produtos');
    }
  }
}