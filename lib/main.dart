import 'package:exchange_rates/DATA/background.dart';
import 'package:exchange_rates/DATA/classes.dart';
import 'package:exchange_rates/DATA/listener.dart';
import 'package:exchange_rates/GUI/home.dart';
import 'package:exchange_rates/GUI/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';
void callBacDispatcher() {
   Workmanager.executeTask((taskName, inputData) async {
     await PriceListener.listenForPrices();
       PriceNotification().load();
       await PriceNotification.showNotification();

     return Future.value(true);
   });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callBacDispatcher);
  await Workmanager.registerPeriodicTask("1", "Notify When Price Changed after 1 hours",frequency: Duration(hours: 1));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new MaterialApp(
    initialRoute: "/home",
    routes: {
      "/home" : (context) => Home(),
      "/menu" : (context) => Menu(),
    },
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

