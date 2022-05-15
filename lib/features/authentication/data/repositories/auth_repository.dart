import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  Future destroyPasscode() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.remove('passCode');
  }
}
