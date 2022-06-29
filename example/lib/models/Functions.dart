import 'package:flutter/material.dart';

import '../constants.dart';

class FunctionInfo {
  final String? svgSrc, title, totalStorage;
  final int? numOfFiles, percentage;
  final Color? color;

  FunctionInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
  });
}

List functionalities = [
  FunctionInfo(
    title: "manual drive",
    numOfFiles: 1328,
    svgSrc: "assets/icons/manual_drive.svg",
    totalStorage: "1.9GB",
    color: primaryColor,
    percentage: 35,
  ),
  FunctionInfo(
    title: "voice drive",
    numOfFiles: 1328,
    svgSrc: "assets/icons/voice_drive.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  FunctionInfo(
    title: "Recent Devices",
    numOfFiles: 1328,
    svgSrc: "assets/icons/recent.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  FunctionInfo(
    title: "Chat page",
    numOfFiles: 1328,
    svgSrc: "assets/icons/chat.svg",
    totalStorage: "1GB",
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
];
