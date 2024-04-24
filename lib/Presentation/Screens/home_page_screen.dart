import 'package:flutter/material.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_constants.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_size.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_weight.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_weather_app_clone/Presentation/Screens/next_day_forcast_screen.dart';
import 'package:flutter_weather_app_clone/Presentation/Widgets/text_button_widget.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

/*
Title: HomePageScreen
Purpose:HomePageScreen
Created On: 24/04/2024
Edited On:24/04/2024
Author: Kalpesh Khandla
*/

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final WeatherFactory _wf = WeatherFactory(AppConstants.openWhetherKey);
  String? city;
  String? locality;

  Weather? _weather;
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // All Function & Methods will go above Build()
  // To Current Location
  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    // getting the Current Location
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      getCityName(value);
    });
  }

  // To get City Name From Lat & Long
  getCityName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark placeMark = placemarks[4];
      String? name = placeMark.name;
      String? subLocality = placeMark.subLocality;
      locality = placeMark.locality;
      String? administrativeArea = placeMark.administrativeArea;
      String? postalCode = placeMark.postalCode;
      String? country = placeMark.country;

      getWhether(locality!);
    } catch (err) {}
  }

  // To get Whether from City Name
  getWhether(String cityName) {
    _wf.currentWeatherByCityName(cityName).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  // To get next Five days Whether
  onNextBtnTap(String? cityNm) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return NextDayForeCastScreen(
          cityName: cityNm!,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  // All design widgets will go below Build()

  Widget _buildUI() {
    if (_weather == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _locationHeader(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _dateTimeInfo(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.03,
              ),
              _weatherIcon(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _currentTemp(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.02,
              ),
              _extraInfo(),
              SizedBox(
                height: 20,
              ),
              _nextDayForeCast(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: AppFontSize.fontSize20,
        fontWeight: AppFontWeight.fontWeight500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(now);
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: AppFontSize.fontSize35,
            fontWeight: AppFontWeight.fontWeight600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: TextStyle(
                fontWeight: AppFontWeight.fontWeight700,
              ),
            ),
            Text(
              ' ${formatted.toString()}',
              style: const TextStyle(
                fontWeight: AppFontWeight.fontWeight400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: AppColors.blackColor,
            fontSize: AppFontSize.fontSize20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: AppColors.blackColor,
        fontSize: AppFontSize.fontSize90,
        fontWeight: AppFontWeight.fontWeight500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: AppColors.deepPurple,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: AppFontSize.fontSize15,
                ),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: AppFontSize.fontSize15,
                ),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: AppFontSize.fontSize15,
                ),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: AppFontSize.fontSize15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _nextDayForeCast() {
    return TextButtonWidget(
      onButtonTap: () {
        setState(() {
          city = locality;
        });
        onNextBtnTap(city);
      },
      btnTxt: AppStrings.nextForecast,
      btnBackColor: AppColors.deepPurple,
      txtColor: AppColors.whiteColor,
    );
  }
}
