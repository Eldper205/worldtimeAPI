
// user can update the location and choose different place to find out the time

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {  // State object


  List<WorldTime> locations = [
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'assets/greece.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'assets/germany.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'assets/egypt.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'assets/indonesia.png'),
    WorldTime(url: 'Asia/Kuching', location: 'Kuala Lumpur', flag: 'assets/malaysia.png'),
    WorldTime(url: 'Europe/London', location: 'London', flag: 'assets/uk.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'assets/kenya.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'assets/usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'assets/south_korea.png'),
  ];

  // index: represents whichever instance of the List class we want to call the getTime method on
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // ned to pass whatever time data to the Home screen
    // navigate to home screen
    // -> we're popping something back off, we're not rebuilding the Home widget.
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
      // Now Home widget can access these.
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // center the widgets horizontally
          children: [
            Text('Choose a Location'),
            SizedBox(width: 10.0), // add some space between the icon and text
            Icon(
              Icons.edit_location,
              size: 20.0,
            ),
          ],
        ),
        elevation: 0,  // remove drop shadow

      ),
      // When click the button (use setState()), it trigger the build function
      // to rerun and print the statement again.

      // List View Builder 列表视图生成器
      // -> to cycle through the list.
      body: ListView.builder(
        // item count (how many item are inside the list we want to cycle through
        itemCount: locations.length, // locations ->variable of the List
        itemBuilder: (context, index) {  // takes two parameter
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('${locations[index].flag}'),
                ),  // leading property
              ),
            ),
          );
        }
      ),

    );
  }
}


