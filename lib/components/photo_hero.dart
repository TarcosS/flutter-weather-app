import 'package:flutter/material.dart';

class WeatherDetailHeader extends StatelessWidget {
  const WeatherDetailHeader({
    super.key,
    this.onTap,
    required this.child
  });

  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'weather_detail',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child
        ),
      ),
    );
  }
}