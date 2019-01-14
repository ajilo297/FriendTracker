abstract class ISignUpandSigninPagePresenter {
  void onLogin(String email,String password);
  void onSignUp(String email,String password);
}

abstract class ISignUpandSigninPage  {
  void onLoginSuccess();
  void onSignUpSuccess();
}
