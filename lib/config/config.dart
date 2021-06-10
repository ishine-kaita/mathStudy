import 'package:flutter/material.dart';

/* グローバル変数 */
double step; //点の刻み幅

// double paramStep = 0.10;

/* 隙間埋め用の点 */
Map<double, double> gapCooordinate;

/* 定数 */
const double graphAreaH = 500;
const int maxIndex = 1000; //点の個数(正負それぞれmaxIndex個ずつ)
const double unit = 25; //25ピクセルで座標平面上の1
const double dotHeight = 1.0;
const double dotWidth = 1.0;

const List<String> funcNameList = [
  '２次関数',
  '２次関数(平方完成)',
  '３次関数',
  '４次関数',
  'sin',
  'cos',
  'tan',
];
const List<double> paramStepList = [0.1, 0.5, 1.0];

/* アプリのテーマカラー */
const MaterialColor customSwatch = const MaterialColor(
  0xFF00FA9A,
  const <int, Color>{
    50: const Color(0xFFE0FEF3),
    100: const Color(0xFFB3FEE1),
    200: const Color(0xFF80FDCD),
    300: const Color(0xFF4dFCB8),
    400: const Color(0xFF26FBA9),
    500: const Color(0xFF00FA9A),
    600: const Color(0xFF00F992),
    700: const Color(0xFF00F988),
    800: const Color(0xFF00F87E),
    900: const Color(0xFF00F66C),
  },
);

const int black = 0xFF030303;
const int white = 0xFFF5F5F5;
