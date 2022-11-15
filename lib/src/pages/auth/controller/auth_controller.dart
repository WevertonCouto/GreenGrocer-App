import 'package:get/get.dart';
import 'package:green_grocer/src/constants/storage_keys.dart';
import 'package:green_grocer/src/pages/auth/repository/auth_repository.dart';
import 'package:green_grocer/src/pages_route/app_pages.dart';

import '../../../models/user_model.dart';
import '../../../services/utils_services.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();

  UserModel userModel = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await UtilsServices.getLocalData(key: StorageKeys.token);
    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token: token);
    result.when(success: (user) {
      userModel = user;
      saveTokenAndProceedToBase();
    }, error: (message) {
      signOut();
    });
  }

  Future<void> signOut() async {
    userModel = UserModel();
    await UtilsServices.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(
      success: (userModel) {
        this.userModel = userModel;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await authRepository.signUp(userModel);
    isLoading.value = false;

    result.when(
      success: (userModel) {
        this.userModel = userModel;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  void saveTokenAndProceedToBase() async {
    await UtilsServices.saveLocalData(
        key: StorageKeys.token, data: userModel.token!);
    Get.offAllNamed(PagesRoutes.baseRoute);
  }
}
