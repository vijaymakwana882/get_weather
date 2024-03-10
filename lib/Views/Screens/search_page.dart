import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/theme_provider.dart';
import '../../Provider/weather_provider.dart';

class Search_page extends StatefulWidget {
  const Search_page({super.key});

  @override
  State<Search_page> createState() => _Search_pageState();
}

class _Search_pageState extends State<Search_page> {
  @override
  Widget build(BuildContext context) {
    var weather = Provider.of<WeatherProvider>(context);
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search City"),
        actions: [
          IconButton(
              onPressed: () {
                theme.changetheme();
              },
              icon: (theme.themeModel.isDark == false)
                  ? Icon(Icons.dark_mode_outlined)
                  : Icon(Icons.light_mode)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            weather.addcitie();
            weather.fetchimage();
            Navigator.of(context).popAndPushNamed('homepage');
          },
          child: Icon(Icons.done)),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (val) {
                weather.fetchcity(val);
              },
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
