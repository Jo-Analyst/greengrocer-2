String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return "Email e/ou Senha inválidos";
    case 'Invalid session token':
      return "Token inválido";
    default:
      return "Ocorreu um erro indefinido";
  }
}
