import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute property: which is gonna be the first route to load up
    // (override the => default base routes - '/')
    initialRoute: '/',

    // route property: this is gonan be a 'Map' (expect Key & Value Pairs)
    routes: {
      // First widget: when we first open the app (default base routes)
      '/': (context) => Loading(),  // Loading widget: load the data when first open the app
      '/home': (context) => Home(),  // load up the home screen
      '/location': (context) => ChooseLocation(),
    },
  ));
}


