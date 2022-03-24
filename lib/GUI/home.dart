import 'dart:convert';
import 'package:exchange_rates/DATA/background.dart';
import 'package:exchange_rates/DATA/classes.dart';
import 'package:exchange_rates/DATA/listener.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'custom.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var controller = ScrollController();
  Future<bool> loadLang(BuildContext context) async {
    lang = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("assets/language.json")
    );
    monLang = jsonDecode(
        await DefaultAssetBundle.of(context).loadString("assets/moneyNames.json")
    );
    var keys = await Data().getData();
    lanKey = keys["language"];
    if(lanKey == "en"){
      monKey = "moneyEN";
    }else{
      monKey = "moneyAR";
    }
    return true;
  }
  void setBack() async {
    await Workmanager.initialize(callBacDispatcher);
    await Workmanager.registerPeriodicTask("3", "Notify When Price Changed after 1 hours",frequency: Duration(hours: 1),constraints: Constraints(
      networkType: NetworkType.connected,
    ));
  }
  @override
  void initState(){
    super.initState();

    setState(() {
      loadLang(context);
    });
    setBack();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return new FutureBuilder(
      future: loadLang(context),
      builder: (context,snapshot){
        if(snapshot.hasData){
          if(lanKey == "en"){
            return Directionality(
              textDirection: TextDirection.ltr,
              child: new Scaffold(
                backgroundColor: Color.fromRGBO(44,13,130,1),
                appBar: new AppBar(
                  //toolbarHeight: height*0.25,
                  elevation: 0,
                  centerTitle: true,
                  toolbarHeight: 80,
                  title: new Text(lang[lanKey]["homeTitle"],textScaleFactor: 1,style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.white),),
                  backgroundColor: Color.fromRGBO(67,25,187,1),
                  leading: IconButton(
                    icon: new Icon(Icons.home,color: Colors.white,),
                    onPressed: ()  async{
                      PriceNotification.showNotification();
                    },
                  ),
                  actions: [
                    new IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
                    }),
                  ],
                ),
                body: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: FutureBuilder(
                          future: Data().getData(),
                          builder: (context,snaphot){
                            if(snaphot.connectionState == ConnectionState.waiting){
                              return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator());
                            }
                            else if(snaphot.data["cur"].length > 0){
                              print(snaphot.data["cur"]);
                              return ListView.builder(
                                controller: controller,
                                itemBuilder: (c,i) {
                                  return moneyHolder(width,height,Currency(monLang[monKey][i], snaphot.data["cur"][PriceListener.names[i]][0], snaphot.data["cur"][PriceListener.names[i]][1]));
                                },
                                itemCount: 30,
                              );
                            }
                            else{
                              return new Container(
                                alignment: Alignment.center,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Icon(Icons.wifi_off,size: 60,color: Colors.white,),
                                    new Text(lang[lanKey]["internet"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 18),)
                                  ],
                                ),
                              );
                            }
                          },
                        )
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: new Icon(Icons.refresh,color: Colors.white,),
                  backgroundColor: Color.fromRGBO(74, 34, 197, 1),
                  onPressed: (){
                    setState(() {
                      PriceListener.listenForPrices();
                    });
                  },
                ),
              ),
            );
          }
          else{
            return Directionality(
              textDirection: TextDirection.rtl,
              child: new Scaffold(
                backgroundColor: Color.fromRGBO(44,13,130,1),
                appBar: new AppBar(
                  //toolbarHeight: height*0.25,
                  elevation: 0,
                  centerTitle: true,
                  toolbarHeight: 80,
                  title: new Text(lang[lanKey]["homeTitle"],textScaleFactor: 1,style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 20,color: Colors.white),),
                  backgroundColor: Color.fromRGBO(67,25,187,1),
                  leading: IconButton(
                    icon: new Icon(Icons.home,color: Colors.white,),
                    onPressed: () {

                    },
                  ),
                  actions: [
                    new IconButton(icon: Icon(Icons.menu,color: Colors.white,), onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, "/menu", (route) => false);
                    }),
                  ],
                ),
                body: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: FutureBuilder(
                          future: PriceListener.listenForPrices(),
                          builder: (context,snaphot){
                            if(snaphot.connectionState == ConnectionState.waiting){
                              return Container(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator());
                            }
                            else if(snaphot.hasData){
                              return ListView.builder(
                                controller: controller,
                                itemBuilder: (c,i) {
                                  return moneyHolder(width,height,Currency(monLang[monKey][i], snaphot.data[PriceListener.names[i]][0], snaphot.data[PriceListener.names[i]][1]));
                                },
                                itemCount: 30,
                              );
                            }
                            else{
                              return new Container(
                                alignment: Alignment.center,
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Icon(Icons.wifi_off,size: 60,color: Colors.white,),
                                    new Text(lang[lanKey]["internet"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 18),)
                                  ],
                                ),
                              );
                            }
                          },
                        )
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: new Icon(Icons.refresh,color: Colors.white,),
                  backgroundColor: Color.fromRGBO(74, 34, 197, 1),
                  onPressed: (){
                    setState(() {
                      PriceListener.listenForPrices();
                    });
                  },
                ),
              ),
            );
          }
        }
        else{
          return new Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            color: Color.fromRGBO(44,13,130,1),
            child: new CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
