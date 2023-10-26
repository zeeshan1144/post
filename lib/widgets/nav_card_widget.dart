import 'package:flutter/material.dart';

navCardWidget(int index, int selectedIndex, String img) {
  return Container(
    height: 70,
    width: 70,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color:
          index == selectedIndex ? Colors.white : Colors.black.withOpacity(0.5),
      border: Border(
        left: BorderSide(width: 2, color: Colors.white),
      ),
    ),
    child: Center(
      child: Image(
        image: AssetImage(
          "assets/images/$img.png",
        ),
        height: 50,
        color: index == selectedIndex ? Colors.black : Colors.white,
      ),
    ),
  );
}
