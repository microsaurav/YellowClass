import 'package:assignment/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: {
    '/': (context) => const HomePage(),
  }));
}
