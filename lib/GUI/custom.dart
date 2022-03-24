import 'package:exchange_rates/DATA/classes.dart';
import 'package:flutter/material.dart';
Widget moneyHolder(var width,var height,Currency currency){
  return Container(
    height: 230,
    alignment: Alignment.center,
    child: new Container(
      width: width*0.95,
      height: 200,
      decoration: BoxDecoration(
        color: Color.fromRGBO(44,13,130,1),
        border: Border.all(color: Colors.white,width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(22.0))

      ),
     alignment: Alignment.center,
     child: new Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         new Container(
           width: width*0.8,
           height: 40,
           alignment: Alignment.centerLeft,
           color: Colors.transparent,
           child: new Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               new Text(currency.name,textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 17),),
             ],
           )
         ),
         new Container(
           width: width*0.9,
           height: 50,
           decoration: BoxDecoration(
             color: Color.fromRGBO(74, 34, 197, 1)
                 ,borderRadius: BorderRadius.all(Radius.circular(8))
           ),
           child: new Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               new Text(lang[lanKey]["sell"],textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 15),),
               new Text(currency.sellPrice + " " + lang[lanKey]["price"],textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 15),),
             ],
           ),
         ),
         new SizedBox(
           height: 20,
         ),
         new Container(
           width: width*0.9,
           height: 50,
           decoration: BoxDecoration(
               color: Color.fromRGBO(74, 34, 197, 1)
               ,borderRadius: BorderRadius.all(Radius.circular(8))
           ),
           child: new Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               new Text(lang[lanKey]["buy"],textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 15),),
               new Text(currency.buyPrice + " " + lang[lanKey]["price"],textScaleFactor: 1,style: new TextStyle(color: Colors.white,fontSize: 15),),
             ],
           ),
         )
       ],
     ),
    ),
  );
}









