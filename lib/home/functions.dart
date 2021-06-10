import 'package:mathfunctions/importer.dart';
import 'dart:async';
import 'dart:math' as Math;

/* 関数の式のウィジェット */
Widget funcFormulaWidget(
    String name, List<double> p, StreamController<List<double>> ctrl) {
  List<Widget> formula;
  if (name == '２次関数') {
    formula = spacedFormulaWidgets([
      formulaText('y ='),
      paramWidget('a', p[0]),
      xPow('2'),
      formulaText('+'),
      paramWidget('b', p[1]),
      formulaText('x +'),
      paramWidget('c', p[2]),
    ]);
  } else if (name == '２次関数(平方完成)') {
    formula = spacedFormulaWidgets([
      formulaText('y ='),
      paramWidget('a', p[0]),
      formulaText('( x -'),
      paramWidget('b', p[1]),
      pow2(')'),
      formulaText('+'),
      paramWidget('c', p[2]),
    ]);
  } else if (name == '３次関数') {
    formula = spacedFormulaWidgets([
      formulaText('y ='),
      paramWidget('a', p[0]),
      xPow('3'),
      formulaText('+'),
      paramWidget('b', p[1]),
      xPow('2'),
      formulaText('+'),
      paramWidget('c', p[2]),
      formulaText('x +'),
      paramWidget('d', p[3]),
    ]);
  } else if (name == '４次関数') {
    formula = spacedFormulaWidgets([
      formulaText('y ='),
      paramWidget('a', p[0]),
      xPow('4'),
      formulaText('+'),
      paramWidget('b', p[1]),
      xPow('3'),
      formulaText('+'),
      paramWidget('c', p[2]),
      xPow('2'),
      formulaText('+'),
      paramWidget('d', p[3]),
      formulaText('x +'),
      paramWidget('e', p[4]),
    ]);
  } else if (name == 'sin' || name == 'cos' || name == 'tan') {
    formula = spacedFormulaWidgets([
      formulaText('y ='),
      paramWidget('a', p[0]),
      formulaText(name),
      paramWidget('b', p[1]),
      formulaText('( x +'),
      paramWidget('c', p[2]),
      formulaText(') +'),
      paramWidget('d', p[3]),
    ]);
  } else {
    return Container();
  }
  return Row(children: formula);
}

/* xのべき乗のウィジェット */
Widget xPow(String pow) {
  return SizedBox(
      height: 35,
      child: Row(children: [
        formulaText('x'),
        Align(
            alignment: Alignment.topRight,
            child: Text(pow, style: TextStyle(fontSize: 14)))
      ]));
}

/* 二乗のウィジェット */
Widget pow2(String x) {
  return SizedBox(
      height: 35,
      child: Row(children: [
        formulaText(x),
        Align(
            alignment: Alignment.topRight,
            child: Text('2', style: TextStyle(fontSize: 14)))
      ]));
}

/* 選択されている関数に合わせて、計算用の関数を返す */
double Function(dynamic) getFunction(String name, List<double> p) {
  if (name == '２次関数') {
    return (x) {
      return p[0] * Math.pow(x, 2) + p[1] * x + p[2];
    };
  } else if (name == '３次関数') {
    return (x) {
      return p[0] * Math.pow(x, 3) + p[1] * Math.pow(x, 2) + p[2] * x + p[3];
    };
  } else if (name == '４次関数') {
    return (x) {
      return p[0] * Math.pow(x, 4) +
          p[1] * Math.pow(x, 3) +
          p[2] * Math.pow(x, 2) +
          p[3] * x +
          p[4];
    };
  } else if (name == 'sin') {
    return (x) {
      return p[0] * Math.sin(p[1] * (x + p[2])) + p[3];
    };
  } else if (name == 'cos') {
    return (x) {
      return p[0] * Math.cos(p[1] * (x + p[2])) + p[3];
    };
  } else if (name == 'tan') {
    return (x) {
      return p[0] * Math.tan(p[1] * (x + p[2])) + p[3];
    };
  } else if (name == '２次関数(平方完成)') {
    return (x) {
      return p[0] * Math.pow((x - p[1]), 2) + p[2];
    };
  } else {
    return (x) {
      return 0;
    };
  }
}

/* 関数に応じたパラメータの初期値を返す */
List<double> getInitParam(String name) {
  if (name == 'sin' || name == 'cos' || name == 'tan') {
    return [1.0, 1.0, 0.0, 0.0, 0.0, 0.0];
  } else {
    return [1.0, 0.0, 0.0, 0.0, 0.0, 0.0];
  }
}

/* 座標平面 */
final Widget xyGrid = Stack(
  alignment: AlignmentDirectional.center,
  children: [
    Container(width: 0.7, color: const Color(black)),
    Container(height: 0.7, color: const Color(black)),
    /* 縦線 */
    xLine(1),
    xLine(2),
    xLine(3),
    xLine(4),
    xLine(5),
    xLine(6),
    xLine(7),
    xLine(8),
    xLine(9),
    xLine(10),
    xLine(11),
    xLine(12),
    xLine(13),
    xLine(14),
    xLine(15),
    xLine(-1),
    xLine(-2),
    xLine(-3),
    xLine(-4),
    xLine(-5),
    xLine(-6),
    xLine(-7),
    xLine(-8),
    xLine(-9),
    xLine(-10),
    xLine(-11),
    xLine(-12),
    xLine(-13),
    xLine(-14),
    xLine(-15),
    /* 横線 */
    yLine(1),
    yLine(2),
    yLine(3),
    yLine(4),
    yLine(5),
    yLine(6),
    yLine(7),
    yLine(8),
    yLine(9),
    yLine(10),
    yLine(-1),
    yLine(-2),
    yLine(-3),
    yLine(-4),
    yLine(-5),
    yLine(-6),
    yLine(-7),
    yLine(-8),
    yLine(-9),
    yLine(-10),
  ],
);

/* 縦線 */
Widget xLine(double unitRatio) {
  return Transform.translate(
      offset: Offset(unit * unitRatio, 0),
      child: Container(width: 0.15, color: const Color(black)));
}

/* 横線 */
Widget yLine(double unitRatio) {
  return Transform.translate(
      offset: Offset(0, unit * unitRatio),
      child: Container(height: 0.15, color: const Color(black)));
}

/* グラフ描画 */
// Widget graphLineWidget(double dx, Map<double, double> xyMap) {
//   List<Widget> dots = [];
//   for (var x in xyMap.keys) {
//     dots.add(Transform.translate(
//       offset: Offset(0.0 + dx, graphAreaH / 2.0 - xyMap[x] * dotWidth / step),
//       // offset: Offset(0.0, graphAreaH / 2.0 - xyMap[x] * dotWidth / step + dx),
//       child: Container(
//         width: dotWidth,
//         height: dotHeight,
//         color: Colors.red,
//       ),
//     ));
//   }
//   return Row(mainAxisAlignment: MainAxisAlignment.center, children: dots);
// }

Widget graphLineWidget(Map<double, double> xyMap) {
  List<Widget> dots = [];
  for (var x in xyMap.keys) {
    if ((xyMap[x] * unit).abs() < graphAreaH / 2)
      dots.add(Transform.translate(
        offset: Offset(x * unit, -xyMap[x] * unit),
        child: Container(
          width: dotWidth,
          height: dotHeight,
          color: Colors.red,
        ),
      ));
  }
  return Stack(children: dots);
}

/* 関数, 範囲を指定すると座標群を返す */
Map<double, double> graphCoordinate(double max, double function(double)) {
  double y, yPre;
  Map<double, double> retMap = {};

  gapCooordinate = {};
  step = max / maxIndex;

  for (int i = -maxIndex; i <= maxIndex; i++) {
    y = function(step * i);

    //2点目以降の判定
    if (i > -maxIndex) {
      /* y座標の間が空きすぎていたら、隙間を埋める用の座標を補完する */
      if ((y - yPre).abs() > 0.01) {
        retMap[step * (i - 0.5)] = function(step * (i - 0.5));
      }
    }

    retMap[step * i] = y;
    yPre = y;
  }

  //中点をとってもまだ隙間が大きかったら更に追加
  double xPre = retMap.keys.first;
  for (var x in retMap.keys) {
    if ((function(x) - function(xPre)).abs() > 0.02) {
      gapCooordinate[(x + xPre) / 2.0] = function((x + xPre) / 2.0);
    }
    xPre = x;
  }

  return retMap;
}

/* パラメータ調整ツマミ */
// Widget paramWidget(
//     int index, List<double> p, StreamController<List<double>> ctrl) {
//   return Container(
//       decoration: BoxDecoration(border: Border.all(width: 0.4)),
//       child: Row(children: [
//         const SizedBox(width: 3),
//         Container(
//             width: 40,
//             alignment: Alignment.center,
//             child: Text('${p[index]}', style: const TextStyle(fontSize: 16))),
//         const SizedBox(width: 3),
//         Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//           InkWell(
//             child: const Text('＋'),
//             onTap: () {
//               ctrl.add(changeParamList(index, true, p));
//             },
//           ),
//           const SizedBox(height: 3),
//           InkWell(
//             child: const Text('ー'),
//             onTap: () {
//               ctrl.add(changeParamList(index, false, p));
//             },
//           ),
//         ])
//       ]));
// }

/* ツマミ利用時のパラメータ変更用関数 */
// List<double> changeParamList(int index, bool plus, List<double> p) {
//   if (plus) {
//     p[index] = ((p[index] + paramStep) * 10).round() / 10;
//   } else {
//     p[index] = ((p[index] - paramStep) * 10).round() / 10;
//   }
//   return p;
// }

/* ***** 関数の式で使うTextウィジェット群 ***** */
Widget formulaText(String str) {
  return Text(str, style: const TextStyle(fontSize: 24));
}

Widget paramText(String str) {
  return Text(str,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}

Widget paramWidget(String label, double param) {
  return Container(
      width: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          formulaText(label),
          paramText(roundNum(param).toString()),
        ],
      ));
}

/* ***** 小数第二位を四捨五入 ***** */
double roundNum(double number) {
  return (number * 10).round() / 10;
}

/* ***** 関数の式のWidgetリストに空白を挿入する ***** */
List<Widget> spacedFormulaWidgets(List<Widget> widgets) {
  List<Widget> _ret = [];
  for (var w in widgets) {
    _ret.add(const SizedBox(width: 10));
    _ret.add(w);
  }
  return _ret;
}
