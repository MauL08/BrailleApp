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
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(3, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('4'),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(4, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('5'),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(5, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('6'),
                        ),
                      ),
                    ),
                  ],
                ),
                Transform.rotate(
                  angle: -math.pi / 2,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          state.backSpace();
                        },
                        child: const Text('Backspace'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 4,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                // keyOutput.isNotEmpty &&
                                //         keyData.containsKey(keyOutput.join())
                                //     ? keyData[keyOutput.join()]["txt1"]
                                //     : "happy",
                                // keyOutput.isNotEmpty ? keyOutput.join("") : "",
                                state.brailleText.value,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                // keyOutput.isNotEmpty &&
                                //         keyData.containsKey(keyOutput.join(""))
                                //     ? keyData[keyOutput.join("")]["value1"]
                                //     : "",
                                // keyOutput.isNotEmpty ? keyOutput.join("") : "",
                                state.charText.value,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 4,
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
                                state.resetBar();
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
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(2, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('3'),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(1, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('2'),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: -math.pi / 2,
                      child: GestureDetector(
                        onTapDown: (_) {
                          state.setInput(0, '1');
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54,
                          child: Text('1'),
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
