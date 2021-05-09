class Chatmessage {
  String? messagecontent;
  String? messagetype;

  Chatmessage({required this.messagecontent, required this.messagetype});

  factory Chatmessage.fromJson(Map<String, dynamic> json) {
    return Chatmessage(
        messagecontent: json['messagecontent'],
        messagetype: json["messagetype"]);
  }
}
