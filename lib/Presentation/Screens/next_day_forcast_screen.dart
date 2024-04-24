import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_constants.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_size.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_weight.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_strings.dart';
import 'package:flutter_weather_app_clone/Presentation/Widgets/next_day_item_widget.dart';

import 'package:weather/weather.dart';
import 'package:intl/intl.dart';

/*
Title: NextDayForeCastScreen
Purpose:To Show NextFive Days Whether
Created On: 24/04/2024
Edited On:24/04/2024
Author: Kalpesh Khandla
*/

class NextDayForeCastScreen extends StatefulWidget {
  final String cityName;
  const NextDayForeCastScreen({
    super.key,
    required this.cityName,
  });

  @override
  State<NextDayForeCastScreen> createState() => _NextDayForeCastScreenState();
}

class _NextDayForeCastScreenState extends State<NextDayForeCastScreen> {
  final WeatherFactory _wf = WeatherFactory(AppConstants.openWhetherKey);

  List<Weather>? forecastsList = [];
  @override
  void initState() {
    getWhetherOfNextFiveDays(widget.cityName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // All Function & Methods will go above Build()

  getWhetherOfNextFiveDays(String cityName) {
    _wf.fiveDayForecastByCityName(cityName).then((w) {
      setState(() {
        forecastsList = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            AppStrings.nextFiveDayscast,
            style: TextStyle(
              color: AppColors.deepPurple,
              fontSize: AppFontSize.fontSize24,
              fontWeight: AppFontWeight.fontWeight600,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: forecastsList!.length ?? 1,
              itemBuilder: (context, index) {
                DateTime? now = forecastsList![index].date;
                final DateFormat formatter = DateFormat('dd/MM/yyyy');
                final String formatted = formatter.format(now!);
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: NextDayitemWidget(
                    datetxt: formatted,
                    maxTemp: forecastsList![index].tempMax.toString(),
                    minTemp: forecastsList![index].tempMin.toString(),
                    wind: forecastsList![index].windSpeed.toString(),
                    humidity: forecastsList![index].humidity.toString(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  // All design widgets will go below Build()
}
