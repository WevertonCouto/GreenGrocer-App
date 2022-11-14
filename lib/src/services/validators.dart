import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Type your email.';
  }
  if (!email.isEmail) return 'Invalid email.';
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Type your password.';
  }
  if (password.length < 7) return 'Invalid password.';
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Type your name.';
  }

  if (name.split(' ').length < 2) {
    return 'Type your fullname.';
  }

  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Type your phone.';
  }

  if (!phone.isPhoneNumber || phone.length < 14) return 'Invalid phone.';

  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Type your CPF.';
  }

  if (!cpf.isCpf) return 'Invalid CPF.';

  return null;
}
