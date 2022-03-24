import 'package:exchange_rates/DATA/classes.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
class PriceListener {
  static Future<dynamic> listenForPrices() async {
    final http.Response rep = await http.get("https://www.sp-today.com/currencies");
    Map<String,List<String>> data = new Map();
    var doc = parse(rep.body);
    var moneyName = doc.getElementsByClassName("table table-hover local-cur").single.getElementsByTagName("strong");

    for(int i=0;i<90;i++){
      data.putIfAbsent(moneyName[i].text, () => [moneyName[i+1].text,moneyName[i+2].text]);
      i=i+2;
    }

    Data d = new Data(cur: data);
    d.insertData();
    return data;
  }
  static List names = [
    "(USD)",
    "(EUR)",
    "(TRY)",
    "(SAR)",
    "(AED)",
    "(EGP)",
    "(LYD)",
    "(JOD)",
    "(KWD)",
    "(GBP)",
    "(QAR)",
    "(BHD)",
    "(SEK)",
    "(CAD)",
    "(OMR)",
    "(NOK)",
    "(DKK)",
    "(DZD)",
    "(MAD)",
    "(TND)",
    "(RUB)",
    "(MYR)",
    "(BRL)",
    "(NZD)",
    "(CHF)",
    "(AUD)",
    "(ZAR)",
    "(IQD)",
    "(IRR)",
    "(SGD)"
  ];
}