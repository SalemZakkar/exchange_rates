import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Currency {
  String _name;

  String _buyPrice;

  String _sellPrice;

  Currency(this._name, this._buyPrice, this._sellPrice);

  String get sellPrice => _sellPrice;

  String get buyPrice => _buyPrice;

  String get name => _name;
}
String language = "en";

class Data {
  String language;
  String ringtone;
  String notification;
  Map<String,List<String>> cur;
  Data({@optionalTypeArgs this.language,
        @optionalTypeArgs this.ringtone,
        @optionalTypeArgs this.notification,
        @optionalTypeArgs this.cur,
      });
  dynamic getData() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    if(s.containsKey("notification")){

      return {
        "language":s.get("language"),
        "ringtone":s.get("ringtone"),
        "notification": s.get("notification"),
        "cur" : jsonDecode(s.get("cur"))
      };
    }else{
       Data(language: "en",notification: "on",ringtone: "on",cur: {}).insertData();
      return await getData();
    }
  }
  void insertData() async {
    SharedPreferences s = await SharedPreferences.getInstance();
     if(language!=null){
       s.setString("language", language);
     }
    if(ringtone!=null){
      s.setString("ringtone", ringtone);
    }
    if(notification!=null){
      s.setString("notification", notification);
    }
    if(cur != null){
      s.setString("cur", jsonEncode(cur));
    }
  }
  void clear() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }
}
var lang;
var monLang;
var lanKey = "en";
var monKey = "moneyAR";


