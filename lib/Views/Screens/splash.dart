import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/weather_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    getdata(context).then(
      (value) => Timer(
        Duration(seconds: 3),
        () {
          Navigator.of(context).pushReplacementNamed('homepage');
        },
      ),
    );
  }

  Future<void> getdata(BuildContext context) async {
    await Provider.of<WeatherProvider>(context, listen: false).fetchimage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        child: Image.asset(
          "assets/logo.gif",
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
