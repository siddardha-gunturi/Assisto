import 'dart:core';
import 'package:intl/intl.dart';
import 'package:system_info/system_info.dart';
import 'dart:math';
import 'dart:html' as html;

class Assistant {
  Assistant() {}
  void Queries(String query) {
    //time query
    if (query.contains('time')) {
      time_();
    } else if (query.contains('date')) {
      day_();
    } else if (query.contains('os details')) {
      cpu_();
    } else if (query.contains('joke')) {
      joke_();
    } else if (query.contains("introduce")) {
      introduction_();
    } else if (query.contains("creator")) {
      creator_();
    } else if (query.contains("wish me")) {
      wishme_();
    } else if (query.contains("i love you")) {
      proposal_();
    } else if (query.contains("will you be my girl friend")) {
      propose_();
    } else if (query.contains("wikipedia")) {
      query = query.replaceAll('wikipedia', ' ');
      wiki(query);
    } else if (query.contains("youtube")) {
      const url = "https://www.youtube.com/";
      html.window.open(url, "youtube");
    } else {
      print("Sorry I couldn't reach you could you please try again");
    }
  }

  void time_() {
    var now = DateTime.now();
    print("The current time is " + DateFormat('jm').format(now));
  }

  void day_() {
    var now = DateTime.now();
    print("The today's date is " + DateFormat('yMMMMd').format(now));
  }

  void cpu_() {
    try {
      print("Current Operating System is" +
          SysInfo.operatingSystemName +
          "with version" +
          SysInfo.operatingSystemVersion);
    } catch (e) {
      print("Sorry that information can't be retrieved");
    }
  }

  void joke_() {
    List l = [
      "Why don't some couples go to the gym ?: Because some relationships don't work out",
      "most shocking city in the world : Eectricity",
      "what did the cow say when it wanted to watch a movie? : Let's go to the movie",
      "why shouldn't you write with a broken pencil? : Because its point less"
    ];
    Random random = new Random();
    var n = random.nextInt(l.length);
    print(l[n]);
  }

  void introduction_() {
    var s =
        "Hello everyone! I am an artificially programmed assistant and my name is PARGS";
    print(s);
  }

  void creator_() {
    var s =
        "I am creaed by group 15 members as software project and so named as PARGS";
    print(s);
  }

  void wishme_() {
    var s = "Hello folks";
    print(s);
  }

  void proposal_() {
    var s = "Its hard to understand and I am still trying to figure it out...";
    print(s);
  }

  void propose_() {
    var s = "Sorry I am not sure about that . Please give me some time";
    print(s);
  }

  void wiki(String query) async {
    const url = "https://en.wikipedia.org/wiki/Mahesh_Babu";
    try {
      html.window.open(url, "mahesh");
    } catch (e) {
      print("sorry could you please try again");
    }
  }
}
