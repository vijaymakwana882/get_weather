import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/theme_provider.dart';
import 'Provider/weather_provider.dart';
import 'Views/Screens/city_page.dart';
import 'Views/Screens/home_page.dart';
import 'Views/Screens/search_page.dart';
import 'Views/Screens/splash.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        darkTheme: ThemeData.dark(),
        themeMode:
            (Provider.of<ThemeProvider>(context).themeModel.isDark == false)
                ? ThemeMode.dark
                : ThemeMode.light,
        initialRoute: 'splash',
        routes: {
          'homepage': (context) => HomePage(),
          'splash': (context) => Splash(),
          'search': (context) => Search_page(),
          'city': (context) => managecity()
        },
      ),
    );
  }
}
