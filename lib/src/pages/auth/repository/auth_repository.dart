import 'package:green_grocer/src/constants/endpoints.dart';
import 'package:green_grocer/src/models/user_model.dart';
import 'package:green_grocer/src/pages/auth/result/auth_result.dart';
import 'package:green_grocer/src/services/http_manager.dart';

import 'auth_errors.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result['result'] != null) {
      return AuthResult.success(
        UserModel.fromJson(
          result['result'],
        ),
      );
    } else {
      return AuthResult.error(
        authErrorsString(
          result['error'],
        ),
      );
    }
  }

  Future<AuthResult> validateToken({required String token}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {'X-Parse-Session-Token': token});

    if (result['result'] != null) {
      return AuthResult.success(
        UserModel.fromJson(
          result['result'],
        ),
      );
    } else {
      return AuthResult.error(
        authErrorsString(
          result['error'],
        ),
      );
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    await _httpManager.restRequest(
        url: Endpoints.resetPassword,
        method: HttpMethods.post,
        body: {
          'email': email,
        });
  }
}
