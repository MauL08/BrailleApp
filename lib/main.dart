import 'dart:developer';

import 'package:braille_app/state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MainState state = Get.put(MainState());

  double _value = 0;
  int _activePointers = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        setState(() {
          _activePointers++;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _activePointers--;
          if (_activePointers == 0) {
            state.execute();
            state.resetInput();
          }
        });
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(3, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(3, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '4',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(4, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(4, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(5, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(5, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '6',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.rotate(
                  angle: -math.pi / 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              state.backSpace();
                            },
                            child: const Text('Backspace'),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Math Mode : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${state.isCharNumber.value ? "On" : "Off"}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: state.isCharNumber.value
                                      ? Colors.green.shade800
                                      : Colors.red,
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 15,
                      ),
                      // // Container(
                      // //   decoration: BoxDecoration(
                      // //     borderRadius: BorderRadius.circular(8),
                      // //     color: Colors.grey.withOpacity(0.8),
                      // //   ),
                      // //   padding: EdgeInsets.all(12),
                      // //   width: MediaQuery.of(context).size.width,
                      // //   height: 100,
                      // //   child: Align(
                      // //     alignment: Alignment.centerRight,
                      // //     child: SingleChildScrollView(
                      // //       reverse: true,
                      // //       scrollDirection: Axis.horizontal,
                      // //       child: Text(
                      // //         state.brailleText.value,
                      // //         style: const TextStyle(
                      // //           fontSize: 36,
                      // //           fontWeight: FontWeight.bold,
                      // //           color: Colors.black,
                      // //         ),
                      // //         textAlign: TextAlign.right,
                      // //       ),
                      // //     ),
                      // //   ),
                      // // ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          padding: EdgeInsets.all(12),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SingleChildScrollView(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                state.charText.value,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Slider(
                          activeColor: Colors.blue,
                          min: 0.0,
                          max: 100.0,
                          value: _value,
                          onChanged: (value) {
                            setState(() {
                              if (value == 100) {
                                _value = 0;
                                state.reset();
                              } else {
                                _value = value;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(2, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(2, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(1, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(1, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTapDown: (_) {
                        state.setInput(0, '2');
                      },
                      onTapDown: (_) {
                        state.setInput(0, '1');
                      },
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(48),
                        ),
                        onPressed: () {},
                        child: Transform.rotate(
                          angle: -math.pi / 2,
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
