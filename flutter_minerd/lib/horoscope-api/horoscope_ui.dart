import 'package:flutter/material.dart';
import 'horoscope_service.dart';

class HoroscopeUi extends StatelessWidget {
  final Map<String, dynamic> data;

  HoroscopeUi({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network("${data.containsKey("icon") ? data["icon"] : "https://static.vecteezy.com/system/resources/thumbnails/004/141/669/small/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg"}", width: 50, height: 50),
        Text("${data.containsKey("horoscope") ? data["horoscope"] : ""}")
      ],
    );
  }
}