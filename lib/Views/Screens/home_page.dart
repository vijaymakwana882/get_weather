import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/theme_provider.dart';
import '../../Provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double val = 6;

  get Ts => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      );

  get Lts => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.overline,
      );

  get Cts => TextStyle(
        fontSize: 20,
      );

  @override
  Widget build(BuildContext context) {
    var weather = Provider.of<WeatherProvider>(context);
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage((theme.themeModel.isDark == false)
                  ? "assets/l12.jpg"
                  : "assets/wd.jpg"),
              fit: BoxFit.fitHeight),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${weather.location['country']}",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Icon(Icons.location_on_outlined)
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            theme.changetheme();
                          },
                          icon: (theme.themeModel.isDark == false)
                              ? Icon(Icons.dark_mode_outlined)
                              : Icon(
                                  Icons.light_mode,
                                ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (weather.cities.isEmpty) {
                              weather.setcity();
                            }
                            Navigator.of(context).pushNamed('city');
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Center(
                child: Text("${weather.location["name"]}", style: Ts),
              ),
              Center(
                child: Text(
                  "${weather.current['temp_c']}° ",
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "${weather.current['condition']['text']} ${weather.day['mintemp_c']}° / ${weather.day['maxtemp_c']}°",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27.0, right: 27.0, top: 15.0),
                child: Container(
                  height: 135,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weather.hour.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text("${weather.hour[0][index]['time']}"),
                          Image.network(
                              "http:${weather.hour[index][index]['condition']['icon']}"),
                          Text("${weather.hour[0][index]['temp_c']}°",
                              style: Lts),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27, right: 27, top: 15),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    itemCount: weather.forecastday.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${weather.forecastday[index]['date']}",
                          style: Cts,
                        ),
                        Image.network(
                            "http:${weather.forecastday[index]['day']['condition']['icon']}"),
                        Text(
                          "${weather.forecastday[index]['day']['mintemp_c']}°/${weather.forecastday[index]['day']['maxtemp_c']}°",
                          style: Cts,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 105,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.sunny,
                            size: 30,
                          ),
                          Text(
                            "UV",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${weather.current['uv']}",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.device_thermostat,
                            size: 30,
                          ),
                          Text(
                            "Feels like",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${weather.current['feelslike_c']} ° ",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.water_drop_outlined,
                            size: 30,
                          ),
                          Text(
                            "Humidity",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${weather.current['humidity']} %",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 105,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.air,
                            size: 30,
                          ),
                          Text(
                            "NNW Wind",
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            "${weather.current['wind_mph']} mi/h",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.airline_stops_sharp,
                            size: 30,
                          ),
                          Text(
                            "Air Pressure",
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            "${weather.current['pressure_mb']} hPa",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 30,
                          ),
                          Text(
                            "Visibility",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            "${weather.current['vis_km']} mi",
                            style: TextStyle(fontSize: 17),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 27, right: 27, top: 15),
                child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black38),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.arrow_upward),
                                  Icon(Icons.sunny),
                                  Text("Sunrise")
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.arrow_downward_rounded),
                                  Icon(Icons.sunny),
                                  Text("Sunset")
                                ],
                              )
                            ],
                          ),
                          Slider(
                              divisions: 100,
                              max: 17,
                              min: 6,
                              inactiveColor: Colors.white,
                              activeColor: Colors.black,
                              value: val,
                              onChanged: (value) {
                                val = value;
                                setState(() {});
                              }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${weather.forecastday[0]['astro']['sunrise']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                  "${weather.forecastday[0]['astro']['sunset']}",
                                  style: TextStyle(fontSize: 20))
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
