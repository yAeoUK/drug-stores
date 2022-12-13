abstract class UserBase {
  bool isLoggedIn();

  Future login(Map object);

  Future logout();

  int? getId();
}
