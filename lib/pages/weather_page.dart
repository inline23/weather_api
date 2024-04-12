import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:api_weatherappwithmich/models/weather_model.dart';
import 'package:api_weatherappwithmich/services/weather_services.dart';
// ignore_for_file: avoid_print


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  // api key 
  final _weatherService = WeatherServices('c6b3a56a6211a213f573d51931657b5f');
  Weather? _weather ;
  // fetch weather 
  _fetchWeather () async {
    // get the current city 
    String cityName = await _weatherService.getCurrentCity();
    // get weather for city 
    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather ;
      });
    }
    // any errors 
    catch(e){
      print(e);
    }
  }

  // weather animations
  String getWeatherAnimation (String? mainCoundition){
    if(mainCoundition == null) return 'assets/sunny.json';  // defult to sunny 

    switch(mainCoundition.toLowerCase()){
      case'clouds':
      case'mist':
      case'smoke':
      case'haze':
      case'dust':
      case'fog':
        return 'assets/cloud.json';
      case'rain':
      case'drizzle':
      case'shower rain':
        return 'assets/rain.json';
      case'thunderstorm':
        return 'assets/thunder.json';
      case'clear':
        return 'assets/clear.json' ;
      default:
        return  'assets/sunny.json';
    }
  }
  // init state 
  @override
  void initState() {
    super.initState();
    // fetch weather on startup 
    _fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name 
            Text(_weather?.cityName ?? "Loading city...." , style: const TextStyle(
              fontWeight: FontWeight.bold ,
              color: Colors.white,
            ),),

            // animation 
            Lottie.asset(getWeatherAnimation(_weather?.mainCoundition)),
            // temprature 
            Text('${_weather?.temperature.round()}C' , style: const TextStyle(color: Colors.white),),
            // weather condition  
            Text(_weather?.mainCoundition ?? "" , style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}