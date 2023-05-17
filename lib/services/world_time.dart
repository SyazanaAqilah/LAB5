import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  String time = ''; // the time in that location
  String flag; //url to an asset flag icon
  String latitude;
  String longitude; //location url for api endpoint
  final apiKey = 'L4LY552VT8BM';
  bool isDayTime = true; //true or false if daytime or not

  WorldTime({
    required this.location,
    required this.flag,
    required this.latitude,
    required this.longitude,
  });

  Future<void> getTime() async {
    try {
      //make request
      Response response = await get(Uri.parse(
          'https://api.timezonedb.com/v2.1/get-time-zone?key=$apiKey&format=json&by=position&lat=$latitude&lng=$longitude'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String formatted = data['formatted'];
      String dst = data['dst'].toString();
      //print(dateTime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(formatted);
      now = now.add(Duration(hours: int.parse(dst)));
      //set the time properties
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      //return time;
    } catch (e) {
      print('caught error: $e');
      time = 'could not get the time data';
    }
  }
}
