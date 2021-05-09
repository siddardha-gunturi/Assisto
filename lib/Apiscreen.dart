import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'Chatmodel.dart';
import 'package:http/http.dart' as http;

List<Chatmessage> list = [];

Future<List<Chatmessage>> fetchChatmessage() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:5000/mainpage'));

  if (response.statusCode == 200) {
    return compute(parseMessage, response.body);
  } else {
    throw Exception("Failed to handle the request");
  }
}

List<Chatmessage> parseMessage(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Chatmessage>((json) => Chatmessage.fromJson(json)).toList();
}

String? msgcontent = "a", msgwho = "b", msgcontent1 = "a", msgwho1 = "b";

//late Future<Chatmessage> futuremessage;

class Textscreen extends StatefulWidget {
  @override
  _Textscreenpage createState() => _Textscreenpage();
}

class _Textscreenpage extends State<Textscreen> {
  late Future<List<Chatmessage>> myfuture;
  @override
  void initState() {
    myfuture = fetchChatmessage();
    super.initState();
    Future.delayed(
      Duration(microseconds: 1),
      () {
        Navigator.pop(context);
      },
    );
    //futuremessage = fetchChatmessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Api screen"),
        ),
        body: Center(
          child: FutureBuilder<List<Chatmessage>>(
            future: myfuture,
            builder: (context, snapshot) {
              AsyncSnapshot s = snapshot;
              print("executing...");
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      msgcontent = snapshot.data?[index].messagecontent;
                      msgwho = snapshot.data?[index].messagetype;
                      print(index);
                      print(msgwho);

                      list = [];
                      list.add(Chatmessage(
                          messagecontent: msgcontent, messagetype: msgwho));
                      list.removeLast();
                      try {
                        addThem();
                      } catch (e) {
                        //Do nothing
                      }
                      return ListTile(
                        title: Text('${snapshot.data?[index].messagecontent}'),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  void addThem() {
    setState(() {
      print("in set state");
      for (Chatmessage i in list) {
        print(i);
        streamController.add(i);
      }
    });
  }
}
