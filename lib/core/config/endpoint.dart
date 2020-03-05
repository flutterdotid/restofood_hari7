class Endpoint {
  //static String _baseURL = "https://leeyurani.com/restofood/public/api";
  static String _baseURL = "http://192.168.1.11/restofood/public/api"; //bisa

  static String baseFoods = "${_baseURL}/foods";
  static String baseCity = "${_baseURL}/city";

  //Auth routes
  static String register = "${_baseURL}/auth/register";
  static String login = "${_baseURL}/auth/login";
}