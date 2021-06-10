import 'package:mathfunctions/home/functions.dart';
import 'package:mathfunctions/importer.dart';
import 'dart:async';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final StreamController<String> funcNameCtrl = StreamController.broadcast();
  final StreamController<List<double>> funcParamCtrl =
      StreamController.broadcast();
  // final StreamController<String> funcNameCtrl = StreamController.broadcast();
  @override
  void dispose() {
    funcNameCtrl.close();
    funcParamCtrl.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: funcNameCtrl.stream,
          initialData: funcNameList[0],
          builder: (context, funcType) {
            return StreamBuilder(
                stream: funcParamCtrl.stream,
                initialData: [1.0, 0.0, 0.0, 0.0, 0.0, 0.0],
                builder: (context, funcParam) {
                  Map<double, double> coordinateMap = graphCoordinate(
                      15.0, getFunction(funcType.data, funcParam.data));
                  return Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /* 刻み幅・リセット */

                            // Row(children: [
                            //   const SizedBox(width: 10),
                            //   const Text('パラメータ変化幅：'),
                            //   const SizedBox(width: 5),
                            //   DropdownButton<double>(
                            //     value: paramStep,
                            //     onChanged: (value) {
                            //       setState(() {
                            //         paramStep = value;
                            //       });
                            //     },
                            //     items: paramStepList.map((item) {
                            //       return DropdownMenuItem(
                            //           value: item,
                            //           child: Text(item.toString()));
                            //     }).toList(),
                            //   ),
                            //   const SizedBox(width: 40),
                            //   TextButton(
                            //     child: const Text('パラメータリセット'),
                            //     style: ButtonStyle(
                            //       backgroundColor:
                            //           MaterialStateProperty.all(Colors.grey),
                            //       foregroundColor:
                            //           MaterialStateProperty.all(Colors.white),
                            //     ),
                            //     onPressed: () {
                            //       funcParamCtrl
                            //           .add(getInitParam(funcType.data));
                            //     },
                            //   ),
                            //   const SizedBox(width: 20)
                            // ]),

                            /* 関数の種類 */
                            Container(
                              height: 80,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Text(
                                    '関数の種類',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(width: 50),
                                  DropdownButton<String>(
                                    value: funcType.data,
                                    onChanged: (value) {
                                      funcNameCtrl.add(value);
                                      funcParamCtrl.add(getInitParam(value));
                                    },
                                    items: funcNameList.map((item) {
                                      return DropdownMenuItem(
                                          value: item,
                                          child: Text(item,
                                              style: const TextStyle(
                                                  fontSize: 24)));
                                    }).toList(),
                                  ),
                                  SizedBox(width: 50),
                                  TextButton(
                                    child: const Text('パラメータリセット'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.grey),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {
                                      funcParamCtrl
                                          .add(getInitParam(funcType.data));
                                    },
                                  ),
                                ],
                              ),
                            ),

                            /* 関数の式 */
                            Container(
                              height: 85,
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  funcFormulaWidget(funcType.data,
                                      funcParam.data, funcParamCtrl),
                                ],
                              ),
                            ),

                            /* グラフ */
                            Container(
                              height: graphAreaH,
                              color: const Color(white),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  xyGrid,
                                  graphLineWidget(coordinateMap),
                                  graphLineWidget(gapCooordinate),
                                ],
                              ),
                            ),

                            /* パラメータのスライダー */
                            paramSlider('a', 5.0, -5.0, funcParam.data[0],
                                (value) {
                              funcParam.data[0] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                            paramSlider('b', 5.0, -5.0, funcParam.data[1],
                                (value) {
                              funcParam.data[1] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                            paramSlider('c', 5.0, -5.0, funcParam.data[2],
                                (value) {
                              funcParam.data[2] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                            paramSlider('d', 5.0, -5.0, funcParam.data[3],
                                (value) {
                              funcParam.data[3] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                            paramSlider('e', 5.0, -5.0, funcParam.data[4],
                                (value) {
                              funcParam.data[4] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                            paramSlider('f', 5.0, -5.0, funcParam.data[5],
                                (value) {
                              funcParam.data[5] = value;
                              funcParamCtrl.add(funcParam.data);
                            }),
                          ],
                        ),
                      ));
                });
          },
        ));
  }
}

/* パラメータのスライダー */
Widget paramSlider(String label, double max, double min, double value,
    void Function(double) onChanged) {
  return Row(
    children: [
      SizedBox(width: 100),
      SizedBox(width: 40, child: Text(label, style: TextStyle(fontSize: 20))),
      Container(
          // color: (label == 'a') ? Colors.yellow : Colors.green,
          height: 60,
          width: 500,
          child: Slider(
              max: max,
              min: min,
              divisions: 100,
              value: value,
              activeColor: const Color(0xff6666fa),
              inactiveColor: const Color(0xff6666fa),
              onChanged: onChanged))
    ],
  );
}
