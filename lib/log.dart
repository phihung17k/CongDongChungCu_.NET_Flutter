import 'dart:developer';

class Log{

  static void d(String message){
    log("DEBUG" + " "*5 + message);
  }

  static void i(String message){
    log("INFO" + " "*5 + message);
  }

  static void e(String message){
    log("ERROR" + " "*5 + message);
  }
}