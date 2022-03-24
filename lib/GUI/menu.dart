import 'package:exchange_rates/DATA/classes.dart';
import 'package:flutter/material.dart';
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var red = Colors.red;
  var green = Colors.green;
  bool isChecked = true;
  var direction = TextDirection.ltr;
  void setD(){
    if(lanKey == "en"){
      direction = TextDirection.ltr;
    }
    else{
      direction = TextDirection.rtl;
    }
  }
  @override
  void initState(){
    super.initState();
    setState(() {
      setD();
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    void setN() async {
      var data = await Data().getData();
      if(data["notification"] == "on"){
        setState(() {
          isChecked = true;
        });
      }
      else{
        setState(() {
          isChecked = false;
        });
      }
    }
    setN();
    return Directionality(
      textDirection: direction,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(44,13,130,1),
      appBar: new AppBar(
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: new Text(lang[lanKey]["menuTitle"]),
        backgroundColor: Color.fromRGBO(67,25,187,1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
          },
        ),
      ),
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Text("\n",textScaleFactor: 1,),
              new Container(
                width: width*0.95,
                height: 90,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(74, 34, 197, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: new Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                  children: [
                    new Text(lang[lanKey]["setting1"] ,textScaleFactor: 1, style: new TextStyle(color: Colors.white,fontSize: 18),),
                    new Switch(value: isChecked, onChanged: (bol) async{
                      setState(() {
                        isChecked = bol;
                      });
                      if(isChecked){
                         Data(notification: "on").insertData();
                      }
                      else{
                         Data(notification: "off").insertData();
                      }
                    },
                    thumbColor: MaterialStateProperty.all((isChecked ? green : red)),
                      activeColor: (isChecked ? green : red),
                    )
                  ],

                ),
              ),
              new Text("\n",textScaleFactor: 1,),
              new Container(
                width: width*0.95,
                height: 90,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(74, 34, 197, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return new Container(
                          width: width,
                          height: 80,
                          alignment: Alignment.center,
                          color: Color.fromRGBO(44,13,130,1),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              new TextButton(onPressed: () async {
                              setState(() {
                                lanKey = "en";
                                monKey = "moneyEN";
                                setD();
                              });
                              Data(language: "en").insertData();
                              Navigator.pop(context);
                              }, child: new Text("English")),
                              new TextButton(onPressed: (){
                                setState(() {
                                  lanKey = "ar";
                                  monKey
                                  = "moneyAR";
                                  setD();
                                });
                                Data(language: "ar").insertData();
                                Navigator.pop(context);
                              }, child: new Text("العربية"))
                            ],
                          ),
                        );
                      }
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(74, 34, 197, 1)),
                  ),
                  child: new Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                    children: [
                      new Text(lang[lanKey]["setting2"] ,textScaleFactor: 1, style: new TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400),),
                    ],

                  ),
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
