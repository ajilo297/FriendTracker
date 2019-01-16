abstract class ISignUpandSigninPagePresenter {
  void onLogin(String email,String password);
  void onSignUp(String email,String password,String name);
}

abstract class ISignUpandSigninPage  {
  void onLoginSuccess();
  void onSignUpSuccess();
}
