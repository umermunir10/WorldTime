import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String? time; //the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for API endpoint
  bool isDayTime; // true or false if daytime or not

  WorldTime(
      {required this.location,
      required this.flag,
      required this.url,
      this.time,
      this.isDayTime = false});

  Future<void> getTime() async {
    // make the request
    Uri uri = Uri.parse('https://worldtimeapi.org/api/timezone/$url');
    Response response = await get(uri);
    Map data = jsonDecode(response.body);
    //print(data);

    // get properties from data
    final String? dateTime = data['datetime'];
    final String offSet = data['utc_offset'].substring(1, 3);
    // print(dateTime);
    // print(offSet);

    //create datetime object
    DateTime now = DateTime.parse(dateTime!);
    now = now.add(Duration(hours: int.parse(offSet)));

    // set the time property

    isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
  }
}
