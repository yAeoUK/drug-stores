class ApiConfig {
  static const _rootUrl = 'http://drug-store.atwebpages.com/';
  static const _api_v1 = 'api/v1/';

  static const _admin = 'admin/';
  static const _salesman = 'salesman/';

  static const adminLogin = _rootUrl + _api_v1 + _admin + "login.php";
  static const salesmanLogin = _rootUrl + _api_v1 + _salesman + "login.php";
  static const salesmanRegister = _rootUrl + _api_v1 + _salesman + "register.php";
}
