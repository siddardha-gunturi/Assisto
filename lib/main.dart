import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'Chatmodel.dart';
import 'generatedtest.dart';
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'Apiscreen.dart';
import 'dart:async';
import 'sttext.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:weather_icons/weather_icons.dart';

var s, m;
Assistant a = new Assistant();
StreamController<Chatmessage> streamController =
    StreamController<Chatmessage>();

void main() {
  runApp(MyApp());
}

List<Chatmessage> messages = [
  Chatmessage(messagecontent: "Hello I am siddu", messagetype: "sender"),
  Chatmessage(
      messagecontent: "Hey there, I am your assistant",
      messagetype: 'reciever'),
  Chatmessage(messagecontent: "are you there", messagetype: "sender"),
  Chatmessage(messagecontent: "Yes i am here", messagetype: "reciever"),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Software project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Assistant',
        stream: streamController.stream,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, required this.stream});

  final String title;
  final Stream<Chatmessage> stream;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void toAdd(String message) {
    setState(() {
      messages.add(Chatmessage(messagecontent: message, messagetype: "sender"));
    });
  }

  late stt.SpeechToText _speech;
  var onStatus = "not Listening";
  bool _isListening = false;
  String _textspeech = "speech";
  String spee = "speech";

  Future<void> onListen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
          onStatus: (val) => print("onStatus :$val"),
          onError: (val) => print("onError :$val"));
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _textspeech = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  void toAdd1(String message) {
    setState(() {
      messages
          .add(Chatmessage(messagecontent: message, messagetype: 'reciever'));
    });
  }

  late Chatmessage msg;

  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    widget.stream.listen((chatmessage) {
      mysetState(chatmessage);
    });
  }

  void mysetState(Chatmessage chatmessage) {
    setState(() {
      messages.add(chatmessage);
      Hello h = new Hello();
      if (messages.last.messagetype == "reciever") {
        print(messages.last.messagecontent);
        h.hello(messages.last.messagecontent);
      }
    });
  }

  final myController = TextEditingController();

  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navigationDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Stack(
          children: <Widget>[
            ListView.builder(
                controller: scrollController,
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return buildItem(messages[index], index);
                })
          ],
        ),
        _buildMessageComposer(),
      ])),
      bottomNavigationBar: IconButton(
          alignment: Alignment.bottomCenter,
          icon: const Icon(Icons.mic),
          onPressed: () async {
            print("button pressed");
            await onListen();
            if (_textspeech != spee) {
              spee = _textspeech;
              toAdd(_textspeech);
              s = a.Queries(_textspeech);
              mysetState(
                  Chatmessage(messagecontent: s, messagetype: "reciever"));
            }
            print("button released");
          }),
    );
  }

  _buildMessageComposer() {
    return Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
        height: 290.0,
        width: 590,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: myController,
                cursorColor: Colors.blue,
                cursorHeight: 30,
                style: TextStyle(fontSize: 15),
                onChanged: (value) => {},
                decoration: InputDecoration(
                    fillColor: Colors.black,
                    hintText: "Enter Query",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    )),
              ),
            ),
            IconButton(
                splashRadius: 30,
                icon: Icon(Icons.send),
                onPressed: () {
                  m = myController.text;
                  print("button Pressed");
                  //After knowing the button was pressed then we should next
                  //think about adding it to the chatmessages list
                  toAdd(m);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Textscreen()),
                  );
                  //So by now we are done with adding it to the existing chat
                  //message and then next we should think about writing an API
                  //call and retrieving the content sent by this frontend at the

                  //server and making it work at the server side and send data
                  //server and make the request satisfied
                  //Later we should send the data to api
                  /*so here is how we are going to change code*/
                  s = a.Queries(m);
                  // so this is to make sure that our front end is working or not
                  //so if this message replies and then if we get our text back
                  //then we would be able to understand that we have madesomething
                  //
                  mysetState(
                      Chatmessage(messagecontent: s, messagetype: "reciever"));
                  print(s);
                }),
          ],
        ));
  }

  Widget buildItem(Chatmessage item, int index) {
    return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: Align(
              alignment: (messages[index].messagetype == 'reciever'
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: (messages[index].messagetype == 'reciever'
                      ? Colors.grey.shade200
                      : Colors.blue),
                ),
                padding: EdgeInsets.all(16),
                child: Text(
                  messages[index].messagecontent!,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )));
  }

  Widget navigationDrawer() {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("Hello Group 15"),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
          ),
        ),
        ListTile(
          leading: BoxedIcon(WeatherIcons.day_cloudy),
          title: Text("Weather"),
          onTap: () {
            const url = "https://weather.com/en-IN/";
            html.window.open(url, "weather report");
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Calendar'),
          onTap: () {
            const url = "https://calendar.google.com/calendar/u/0/r?pli=1";
            html.window.open(url, "calendar");
          },
        ),
        ListTile(
          leading: Icon(Icons.calculate_outlined),
          title: Text("Calculator"),
          onTap: () {
            const url = "https://www.google.com/search?q=calculator";
            html.window.open(url, "basic calculator");
          },
        ),
        ListTile(
          leading: Icon(Icons.alarm),
          title: Text("Alarm"),
          onTap: () {
            html.window.open("https://kukuklok.com/", "alarm");
          },
        ),
        ListTile(
          leading: Icon(Icons.music_note_sharp),
          title: Text("Music"),
          onTap: () {
            const url = "https://gaana.com/";
            html.window.open(url, "Music");
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Google search'),
          onTap: () {
            const url = "https://google.com";
            html.window.open(url, "Gmail");
          },
        ),
        ListTile(
          leading: Icon(Icons.medical_services),
          title: Text("BMI"),
          onTap: () {
            const url = "https://www.calculator.net/bmi-calculator.html";
            html.window.open(url, "basic calculator");
          },
        ),
        ListTile(
          leading: Icon(Icons.money),
          title: Text('Currency convertor'),
          onTap: () {
            const url = "https://www.google.com/search?q=currency+convertor";
            html.window.open(url, "currency convertor");
          },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Google Maps'),
          onTap: () {
            const url =
                "https://www.google.com/maps/@17.0186342,81.8770663,15z";
            html.window.open(url, "Google Maps");
          },
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Whatsapp'),
          onTap: () {
            const url = "https://web.whatsapp.com/";
            html.window.open(url, "Whatsapp");
          },
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text('Gmail'),
          onTap: () {
            const url = "https://mail.google.com/mail/u/0/?tab=wm#inbox";
            html.window.open(url, "Gmail");
          },
        ),
        ListTile(
          leading: Icon(Icons.play_circle_fill_outlined),
          title: Text('Youtube'),
          onTap: () {
            const url = "https://www.youtube.com/";
            html.window.open(url, "youtube");
          },
        ),
        ListTile(
          leading: Icon(Icons.notes_outlined),
          title: Text('Notes'),
          onTap: () {
            const url = "https://keep.google.com/#home";
            html.window.open(url, "keep notes");
          },
        ),
      ],
    ));
  }
}
