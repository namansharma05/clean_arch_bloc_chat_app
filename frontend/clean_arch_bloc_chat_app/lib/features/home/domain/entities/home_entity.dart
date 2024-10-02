import 'package:flutter/material.dart';

class HomeEntity {
  final int itemIndex;
  final Widget itemWidget;
  final Icon itemIcon;
  final String itemName;

  HomeEntity({
    required this.itemIndex,
    required this.itemWidget,
    required this.itemIcon,
    required this.itemName,
  });
}
