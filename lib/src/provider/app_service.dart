// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:package_info_plus/package_info_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:speedkub/configs/config_model.dart';
// import 'package:speedkub/src/services/auth_service.dart';

// // ignore: non_constant_identifier_names
// String LOGIN_KEY = "5FD6G46SDF4GD64F1VG9SD68";

// class AppService with ChangeNotifier {
//   late final SharedPreferences sharedPreferences;
//   final StreamController<bool> _loginStateChange = StreamController<bool>.broadcast();
//   bool _loginState = false;
//   bool _initialized = false;
//   Value _valueAppSetting = Value();
//   bool _isForceUpdate = false;
//   bool _isForceLoaded = false;
//   late final PackageInfo? packageInfo;

//   AppService(this.sharedPreferences);

//   bool get loginState => _loginState;
//   bool get initialized => _initialized;
//   Value get valueAppSetting => _valueAppSetting;
//   bool get isForceUpdate => _isForceUpdate;
//   bool get isForceLoaded => _isForceLoaded;

//   Stream<bool> get loginStateChange => _loginStateChange.stream;

//   set valueAppSetting(Value val){
//     if(val != null){
//       _valueAppSetting = val;
//       notifyListeners();
//     }
//   }

//   set isForceUpdate(bool val){
//       _isForceUpdate = val;
//       notifyListeners();
//   }

//   set isForceLoaded(bool val){
//       _isForceLoaded = val;
//       // notifyListeners();
//   }

//   initAppSetting(Value val,bool isForceUpdateValue,{bool isForceLoaded = false}){
//     if(val != null){
//       _valueAppSetting = val;
//       _isForceUpdate = isForceUpdateValue;
//       _isForceLoaded = isForceLoaded;
//       notifyListeners();
//     }
//   }

//   set loginState(bool state) {
//     sharedPreferences.setBool(LOGIN_KEY, state);
//     _loginState = state;
//     _loginStateChange.add(state);
//     notifyListeners();
//   }

//   set initialized(bool value) {
//     _initialized = value;
//     notifyListeners();
//   }


//   Future<void> onAppStart() async {

//     // _valueAppSetting = FlavorConfig.instance.variables["valueAppSetting"];
//     print('valueAppSetting:${_valueAppSetting.maintenance?.is_maintenance}');
//     print('valueAppSetting:${_valueAppSetting.version}');

//     //check is login from localstoreate
//     // _loginState = sharedPreferences.getBool(LOGIN_KEY) ?? false;
//     // final testIslogin = sharedPreferences.getBool(LOGIN_KEY) ?? false;

//     final checkLogin = sharedPreferences.getString('token_app') != null ? true : false;

//       print('onAppStart ===> checkLogin =:${checkLogin}');
//       _loginState = checkLogin;
//       _isLogin = checkLogin;

//       _phoneNumber = sharedPreferences.getString('phone_number') ?? '';

//       // This is just to demonstrate the splash screen is working.
//       // In real-life applications, it is not recommended to interrupt the user experience by doing such things.
//       await Future.delayed(const Duration(seconds: 2));

//       _initialized = true;
//       notifyListeners();

//   }

//   AuthToken _authTokenData = AuthToken();
//   AuthToken get authTokenData => _authTokenData;

//   bool _isLogin = false;
//   bool get isLogin => _isLogin;

//   String _tokenApp = '';
//   String get tokenApp => _tokenApp;

//   String _errorMsg = '';
//   String get errorMsg => _errorMsg;

//   String _phoneNumber = '';
//   String get phoneNumber => _phoneNumber;

//   void setLogin(bool status){
//     _isLogin = status;

//     _loginState = status;
//     _loginStateChange.add(status);

//     notifyListeners();
//   }


//   Future<void> loadData(String phone, String pass)  async {
//     try{
//       final data =  await AuthService.userLogin(phone, pass);
//       await initData(data);
//       await initPhoneNumber(phone);
//       _errorMsg = '';
//       setLogin(true);

//     } catch (e) {
//       if(e is FormatException) {
//         _errorMsg = e.message;
//       }
//       FormatException(errorMsg); rethrow;
//     }
//   }

//   Future<void> initData(AuthToken responeData) async{
//     _authTokenData = responeData;
//     await saveAuthToLocal(responeData);
//   }

//   Future<void> initPhoneNumber(String phone) async{
//     _phoneNumber = phone;
//     await sharedPreferences.setString('phone_number', phone);
//   }

//   Future<void> saveAuthToLocal(AuthToken data)  async {

//     if(data.token!.isNotEmpty){
//       await sharedPreferences.setString('token_app', data.token!);
//     }

//     if(data.refresh_token!.isNotEmpty){
//       await sharedPreferences.setString('refresh_token_app', data.refresh_token!);
//     }
//   }

//   Future<void> resetData()  async {
//     _isLogin = false;
//     _tokenApp = '';
//     _errorMsg = '';
//     _authTokenData = AuthToken();
//     _loginState = false;
//     _loginStateChange.add(false);
//     _initialized = false;
//     _phoneNumber = '';
//     notifyListeners();
//   }

//   Future<bool> logout()  async {
//     bool isLogout = false;
//     try{
//       // isLogout =  await AuthService.logout();
//       // if(isLogout){
//         await sharedPreferences.clear();
//         await resetData();
//         isLogout = true;
//       // }
//     } catch(e) {
//       if(e is FormatException){
//         isLogout = true;
//         await sharedPreferences.clear();
//         await resetData();
//       }
//     }
//     return isLogout;
//   }
// }