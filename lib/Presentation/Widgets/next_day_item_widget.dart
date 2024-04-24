import 'package:flutter/material.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_colors.dart';
import 'package:flutter_weather_app_clone/AppUtils/app_font_weight.dart';

/*
Title: NextDayitemWidget
Purpose:To return a widgt in a Listview
Created On: 24/04/2024
Edited On:24/04/2024
Author: Kalpesh Khandla
*/

class NextDayitemWidget extends StatefulWidget {
  final String datetxt;
  final String maxTemp;
  final String minTemp;
  final String wind;
  final String humidity;
  const NextDayitemWidget({
    super.key,
    required this.datetxt,
    required this.maxTemp,
    required this.minTemp,
    required this.wind,
    required this.humidity,
  });

  @override
  State<NextDayitemWidget> createState() => _NextDayitemWidgetState();
}

class _NextDayitemWidgetState extends State<NextDayitemWidget> {
  @override
  Widget build(BuildContext context) {
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
          Text(
            'Date : ${widget.datetxt}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: AppFontWeight.fontWeight600,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Max : ${widget.maxTemp}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                'Min : ${widget.minTemp}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
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
                'Wind : ${widget.wind} m/s',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                'Humidity : ${widget.humidity} %',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
