import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/page_routes/app_pages.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  UserModel user = UserModel();

  Future<void> validateToken() async {
    String? token = await UtilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PageRoutes.signinRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);
    result.when(
      success: (user) {
        this.user = user;
        saveTokenProcedToBase();
      },
      error: (message) {
        signinOut();
      },
    );
  }

  void signinOut() async {
    // zera o user
    user = UserModel();

    // Remover o token localmente
    await UtilsServices.removeLocalData(key: StorageKeys.token);

    // Ir para o login
    Get.offAllNamed(PageRoutes.signinRoute);
  }

  void saveTokenProcedToBase() {
    UtilsServices.saveLocalData(
      key: StorageKeys.token,
      data: user.token!,
    );
    Get.offAllNamed(PageRoutes.baseRoute);
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;
    result.when(
      success: (user) {
        this.user = user;

        saveTokenProcedToBase();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
