
// This is gonna be World Time Class

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// convert JSON string that we get back from the request into data format that we can work with

class WorldTime {

  String location; // location name for the UI
  String time = '';     // the time in that location
  String flag;     // url to an asset flag icon
  String url;      // location url for API endpoint
  bool isDaytime = false; // true or false if daytime or no
  // Show either night image or the day image
  // 'late' keyword: declare variable that'll be initialzied later
  // Named Parameter
  WorldTime({ required this.location, required this.flag, required this.url });
  /* Expecting constructor to receive all of the different values
     when we create a new instance of this WorldTime class */

  // Future<void>: it's a temporary placeholder value until the function is complete
  Future<void> getTime() async {  // use a combination of an asynchronous function

    try {

      // make the request
      // Instead of hardcoding it -> we pass the $url
      Response response = await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));  // endpoint: return us some JSON data.
      Map data = jsonDecode(response.body);  // decode this <JSON string> with 'jsonDecode()' method.
      // print(data);  // get the data in our format that we can use
      // 3) jsonDecode(response.body); -> return data that we can use. It's gonna be a 'map'.
      // -> so now can to print one of the properties.

      // 2) 'body' of response: the actual data that we get back
      // 1) Response object of type response here is given by HTTP module
      // -> response: contain information about this response that we get from the request

      // get properties from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(1, 3); // still in 'String'
      // String timezone = data['timezone'];

      // print(datetime);
      // print(offset);
      // print(timezone);

      // create DateTime object....parse(解析)
      DateTime now = DateTime.parse(datetime); // instantiate the class object
      // what the statement actually do here is: convert 'datetime' into a date/time object
      now = now.add(Duration(hours: int.parse(offset)));  // add(): to add a specified amount of time/duration to a date object
      // now -> it's non-destructive 非破坏性的, it doesn't directly update it.
      // int.parse(offset) -> convert value of type 'String' into 'int'.


      // set the time property
      // Ternary operator-> isDaytime = condition ? true: false;
      isDaytime = now.hour >= 6 && now.hour <= 18 ? true : false;

      time = DateFormat.jm().format(now);  // convert into String
      //DateFormat <- provided by Intl package.

    }
    catch (e) {
      print('Error Prompt: $e');
      time = 'Request Failed';
    }

  }
}

