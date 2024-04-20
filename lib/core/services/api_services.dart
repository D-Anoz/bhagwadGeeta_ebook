import 'package:connectivity/connectivity.dart';

class ApiService {
  static Future<ConnectivityResult> checkInternetConnection() async {
    return await Connectivity().checkConnectivity();
  }
}
