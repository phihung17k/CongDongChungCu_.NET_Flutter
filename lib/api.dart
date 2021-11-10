
class Api{
  static String get uri => "http://18.136.195.171:8080";

  static String get buildings => "/api/v1/buildings";
  static String get authentication => "/api/v1/firebases";

  static String get apartments => "/api/v1/apartments";
  static String get poi => "/api/v1/pois";
  static String get poiType => '/api/v1/poitypes';
  static String get news => "/api/v1/news";
  static String get residents => "/api/v1/residents";
  static String get posts => "/api/v1/posts";
  static String get comments => "/api/v1/comments";
  static String get users => "/api/v1/users";


  //anhntse
  static String get productByStoreId => "/api/v1/products";
  static String get store => "/api/v1/stores";
  static String get category => "/api/v1/categories";

  static String get googleAPIKey => "AIzaSyDAv356PfZe9nteafUsRvwiBCOyC9LI5Q4";




  static String getURL({String apiPath}){
    return uri + apiPath;
  }
}