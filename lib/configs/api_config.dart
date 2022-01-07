class ApiConfig {
  static const _rootUrl = 'http://drug-store.atwebpages.com/';
  static const _api_v1 = 'api/v1/';

  static const _admin = 'admin/';
  static const _salesman = 'salesman/';
  static const _drugs = 'drugs/';

  static const adminLogin = _rootUrl + _api_v1 + _admin + "login.php";
  static const salesmanLogin = _rootUrl + _api_v1 + _salesman + "login.php";
  static const salesmanRegister =
      _rootUrl + _api_v1 + _salesman + "register.php";

  static const adminGetDrugs =
      _rootUrl + _api_v1 + _admin + _drugs + "index.php";
  static const adminDeleteDrug =
      _rootUrl + _api_v1 + _admin + _drugs + "delete.php";
  static const adminUpsertDrug =
      _rootUrl + _api_v1 + _admin + _drugs + "upsert.php";
}
