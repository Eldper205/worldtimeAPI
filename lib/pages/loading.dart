
// Initial loading screen
// -> little spinner or data first loads (redirects to the home screen, etc)
// Loading data initially on the loading screen

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';  // Loader & Spinner

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String timeUI = 'loading';

  // Inside non-return type function, we create a new instance of World Time class
  void setupWorldTime() async {
    // Create an instance of this class & it set all of these three properties.
    WorldTime instance = WorldTime(location: 'Kuala Lumpur', flag: 'assets/malaysia.png', url: 'Asia/Kuching');
    /* If we want to use 'await' keyword' in front of our custom asynchronous function.
     *** But we have to put type of "Future" in front of our asynchronous function. ***
    */
    await instance.getTime();  // run the function inside that class

    /* Send data from this widget -> 3rd parameter: arguments (a 'Map')
       -> map: gonna be a set of key value pairs to pass through into the screen that we route to.
    */
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
      // Now Home widget can access these.
    });
    /* Passing route data to 'Home' screen, actually gonna replace the routes
       underneath this loading.dart.
       -> Navigator.pushNamed(context, '/home'); -> loading.dart is underneath Home screen
    */

    // print(instance.time);
    /*
    -> we can't print the time like this coz in Asynchronous Function Code,
       it'll print the time b4 we even get it back or set that 'time' property.

       So the best solution is to put 'await' keyword in front of the getTime(),
       it will wait for the request finished b4 it carries on and print the time.
    */
    /*
    setState(() {
      timeUI = instance.time;
    });
    */
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      body: const Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }

}



