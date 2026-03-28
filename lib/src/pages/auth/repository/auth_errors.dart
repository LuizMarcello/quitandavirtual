String authErrorsString(String? code) {
  switch (code) {
    case 'INVALID_CREDENTIALS':
      return 'Email e/ou senha inválidos';
    default:
      return 'Um êrro indefinido ocorreu';
  }
}
