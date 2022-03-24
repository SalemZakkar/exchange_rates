import 'package:exchange_rates/DATA/classes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

import 'listener.dart';

class PriceNotification {

  static FlutterLocalNotificationsPlugin notify = new FlutterLocalNotificationsPlugin();
  BuildContext context;

  PriceNotification({@required this.context});

  void load() {
    var settings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    notify.initialize(settings, onSelectNotification: onSelect);
  }

  Future onSelect(String payload) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        "/home", (route) => false);
  }

  static showNotification() async {
   var t = await Data().getData();
   if(t["notification"] == "on"){
     PriceNotification().load();
     var temp = await Data().getData();
     await notify.show(1, "Prices Notify", "US Dollar \n Buy "+"fuck"+" Sell " +"you", NotificationDetails(
         android: AndroidNotificationDetails(
           'id', 'channel', 'description', priority: Priority.max,
           importance: Importance.max,)));
   }
    //TODO LANG
  }

}
void callBacDispatcher() {
  Workmanager.executeTask((taskName, inputData) async {
    await PriceListener.listenForPrices();
    PriceNotification().load();
    await PriceNotification.showNotification();

    return Future.value(true);
  });
}