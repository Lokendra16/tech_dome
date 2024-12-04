import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkConnection {
  static bool connected = false;


  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isConnect = false;
    for (var element in connectivityResult) {
      if (element == ConnectivityResult.mobile) {
        isConnect = true;
        return isConnect;
      } else if(element == ConnectivityResult.wifi){
        isConnect = true;
        return isConnect;
      }
      else{
        isConnect = false;
        return false;
      }
    }
    return isConnect;
  }
}
