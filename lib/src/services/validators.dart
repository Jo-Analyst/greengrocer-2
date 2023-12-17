import 'package:get/get_utils/get_utils.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return "Digite seu email";
  }

  if (!email.isEmail) return "Digite um email válido";

  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return "Digite sua senha";
  }

  if (password.length < 8) {
    return "Crie uma senha com pelo menos oito caracteres";
  }

  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return "Digite seu nome";
  }

  final names = name.trim().split(" ");
  if (names.length == 1) return "Digite seu nome completo";

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return "Digite o número de seu celular";
  }

  if (phone.length < 16 || !phone.isPhoneNumber)
    return "Digite um número válido";

  return null;
}

String? cpfValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return "Digite o número de seu CPF";
  }

  if (!phone.isCpf) return "Digite um cpf válido";

  return null;
}
