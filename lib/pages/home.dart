
// place that actually shows the time

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // Passing a map of data (arguments)
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {

    // Arguments received from loading.dart.
    // Convert ModalRoute object data into Map format.

    // Ternary operator
    // if data isNotEmpty = gonna return 'true'
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};

    // Set Background
    // Ternary operator-> isDaytime = condition ? true: false;
    String bgImage = data['isDaytime'] ?? true ? 'assets/day.png' : 'assets/night.png';
    Color? bgColor = data['isDaytime'] ?? true ? Colors.orange[900] : Colors.blue[900];

    return Scaffold(
      backgroundColor: bgColor,
      // it moves the child of that widget down into a safe area on the screen where we can’t actually see it.
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('$bgImage'),
              fit: BoxFit.cover,  // cover entire screen
            )
          ), // decoration property
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 70.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {  // navigating to a different screen
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    // use 'result' to update the state of this widget.
                    setState(() {
                      data = {  // update the data as a whole
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });

                    // It push another screen on top of this screen.
                    // The original screen is still gonna exist underneath.
                    // Function: take two arguments. (context, routeName)
                   },
                   style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                   ),
                  icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                  ),
                  label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'] ?? '',
                      style: TextStyle(
                        fontSize: 17.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      )
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'] ?? '',
                  style: TextStyle(
                    fontSize: 55.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



