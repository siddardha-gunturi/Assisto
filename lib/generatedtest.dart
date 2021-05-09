import 'dart:core';
import 'package:intl/intl.dart';
import 'package:system_info/system_info.dart';
import 'dart:math';
import 'main.dart';
import 'dart:html' as html;
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';

var s;

class Assistant {
  Assistant() {}
  String Queries(String query) {
    //time query
    query.toLowerCase();
    if (query.contains('time')) {
      return time_();
    } else if (query.contains('date')) {
      return day_();
    } else if (query.contains('hello')) {
      return "Hello";
    } else if (query.contains('os details')) {
      return cpu_();
    } else if (query.contains('joke')) {
      return joke_();
    } else if (query.contains("yourself")) {
      return introduction_();
    } else if (query.contains("creator")) {
      return creator_();
    } else if (query.contains("wish me")) {
      return wishme_();
    } else if (query.contains("i love you")) {
      return proposal_();
    } else if (query.contains("will you be my girl friend")) {
      return propose_();
    } else if (query.contains("wikipedia")) {
      query = query.replaceAll('wikipedia', '');
      wiki(query);
      return "opening";
    } else if (query.contains("youtube")) {
      const url = "https://www.youtube.com/";
      html.window.open(url, "youtube");
      return "opening";
    } else if (query.contains("how are you")) {
      return "I am fine Thank you";
    } else if (query.contains("google")) {
      var a = query.replaceAll("google", "");
      return search_(a);
    } else if (query.contains("currency")) {
      const url = "https://www.calculator.net/currency-calculator.html";
      html.window.open(url, "currencyconvertor");
      return "opening";
    } else if (query.contains("calculations")) {
      const url = "https://www.calculator.net/";
      html.window.open(url, "calculator");
      return "opening";
    } else if (query.contains("health")) {
      const url = "https://www.calculator.net/bmi-calculator.html";
      html.window.open(url, "https://www.calculator.net/bmi-calculator.html");
      return "opening";
    } else if (query.contains("music")) {
      Music_();
      return "Opening";
    } else if (query.contains("currency")) {
      currencyConvertor_();
      return "Opening";
    } else if (query.contains("alarm")) {
      html.window.open("https://kukuklok.com/", "alarm");
      return "Opening";
    } else if (query.contains("translate")) {
      html.window.open("https://translate.google.co.in/", "translation");
      return "Opening";
    } else if (query.contains("climate") || query.contains("temperature")) {
      const url = "https://weather.com/en-IN/";
      html.window.open(url, "weather report");
      return "Opening";
    } else {
      return "Sorry I couldn't reach you could you please try again";
    }
  }

  String time_() {
    var now = DateTime.now();
    s = "The current time is " + DateFormat('jm').format(now);
    return s;
  }

  String day_() {
    var now = DateTime.now();
    s = "today's date is " + DateFormat('yMMMMd').format(now);
    return s;
  }

  String cpu_() {
    try {
      s = "Current Operating System is" +
          SysInfo.operatingSystemName +
          "with version" +
          SysInfo.operatingSystemVersion;
      return s;
    } catch (e) {
      s = "Sorry that information can't be retrieved";
      return s;
    }
  }

  void Music_() {
    const url = "https://gaana.com/";
    html.window.open(url, "Music");
  }

  void currencyConvertor_() {
    const url = "https://www.google.com/search?q=currency+convertor";
    html.window.open(url, "Currency");
  }

  String joke_() {
    List l = [
      "Why don't some couples go to the gym ?\n Because some relationships don't work out",
      "most shocking city in the world ?\n Eectricity",
      "what did the cow say when it wanted to watch a movie? \n Let's go to the movie",
      "why shouldn't you write with a broken pencil? \n Because its point less"
    ];
    Random random = new Random();
    var n = random.nextInt(l.length);
    s = l[n];
    return s;
  }

  String introduction_() {
    s = "Hello everyone! I am an artificially programmed assistant and my name is PARGS";
    return s;
  }

  String creator_() {
    s = "I am creaed by group 15 members as software project and so named as PARGS";
    return s;
  }

  String wishme_() {
    s = "Hello folks";
    return s;
  }

  String proposal_() {
    s = "Its hard to understand and I am still trying to figure it out...";
    return s;
  }

  String propose_() {
    s = "Sorry I am not sure about that . Please give me some time";
    return s;
  }

  void wiki(String query) async {
    const url = "https://en.wikipedia.org/wiki/Mahesh_Babu";
    try {
      html.window.open(url, "mahesh");
    } catch (e) {
      print("sorry could you please try again");
    }
  }

  String search_(String a) {
    const url = "https://www.google.com/search?q={a}";
    return "Opening";
  }
}
