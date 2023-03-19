const baseURL = 'https://www.property051.com/api/';
const noInternetMsg = 'Oops No Internet';

const msg = 'message';
const status = 'status';
const int timeoutDuration = 60;

class ApiURLS {
  static const String login = 'login';
  static const String socialLogin = 'login/socialRestLogin';
  static const String signup = 'register';
  static String propertySubTypes = "property_subtypes";
  static String getAllProperties = "get_all_properties";
  static String getAllUserProperties = "user/myproperties";
  static String getPropertyFeatures = "get_property_amenities";
  static String markAsFavorite = "fav_property";
  static String cities = "cities";
  static String locations = "locations";
  static String subLocations = "sub_locations";
  static String places = "places";
  static String addProperty = "property/add";
  static String getAllFavProperties = "favourite_property";
  static String getAllAgents = "agents";
  static String getAllAgencies = "agencies";
  static String getAllProjects = "projects";
  static String getTodayTrades = "get_all_trading_chats";
  static String getYesterdayTrades = "get_all_trading_chats";
  // static String getTodayTrades = "search_today_trading";
  // static String getYesterdayTrades = "search_yesterday_trading";
  static String getMyTrades = "search_my_trading";
  static String getSocietyTrades = "search_trending_files_societyid";
  static String getPersonTrades = "search_trending_files_customerid";
  static String getTradingSocieties = "get_all_file_trending_societies";
  static String addTrade = "post_feed";
  static String soldTrade = "change_file_status";
  static String getComments = "get_comments";
  static String addComment = "add_comment";
  static String propertySizeUnits = "property_size_units";

  // User
  static String userProfile = "user/me";
  static String updateUser = "user/update";
}
