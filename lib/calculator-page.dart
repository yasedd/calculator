import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double? _deviceHeight, _deviceWidth;
  String text = "";
  double result = 0;
  String res = "";
  List history = [];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  history[index]["operation"],
                  style: const TextStyle(fontSize: 26),
                ),
                subtitle: Text(
                  "= ${history[index]["result"].toString()}",
                  style: const TextStyle(fontSize: 26),
                ),
                onTap: () {
                  setState(() {
                    // print(index);
                    text = history[index]["operation"];
                    result = history[index]["result"];
                    Navigator.pop(context);
                  });
                },
              );
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: _deviceHeight! * 0.04,
            ),
            Container(
              // color: Colors.amber,
              width: double.maxFinite,
              height: _deviceHeight! * 0.10,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),

              child: Text(
                text == result.toString() ? res : text,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Container(
              // color: Colors.red,
              width: double.maxFinite,
              height: _deviceHeight! * 0.10,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Text(
                result.toString(),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: _deviceHeight! * 0.008,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return DrawerButton(
                      onPressed: () {
                        setState(() {
                          // print(history);
                          Scaffold.of(context).openDrawer();
                        });
                      },
                    );
                  }),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (text != "") {
                            List txt = text.split("");
                            txt.removeLast();
                            text = txt.join("");
                            // print(text);
                          }
                        });
                      },
                      child: const Icon(Icons.backspace))
                ],
              ),
            ),
            SizedBox(
              height: _deviceHeight! * 0.005,
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              color: Colors.grey,
            ),
            SizedBox(
              height: _deviceHeight! * 0.005,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    clearButton("C"),
                    seperatorButton(
                      "()",
                    ),
                    operatorButton(
                      "%",
                    ),
                    operatorButton(
                      "/",
                    )
                  ],
                ),
                SizedBox(
                  height: _deviceHeight! * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    circleButton(
                      7,
                    ),
                    circleButton(
                      8,
                    ),
                    circleButton(
                      9,
                    ),
                    operatorButton(
                      "*",
                    )
                  ],
                ),
                SizedBox(
                  height: _deviceHeight! * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    circleButton(
                      4,
                    ),
                    circleButton(
                      5,
                    ),
                    circleButton(
                      6,
                    ),
                    operatorButton(
                      "-",
                    )
                  ],
                ),
                SizedBox(
                  height: _deviceHeight! * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    circleButton(
                      1,
                    ),
                    circleButton(
                      2,
                    ),
                    circleButton(
                      3,
                    ),
                    operatorButton(
                      "+",
                    )
                  ],
                ),
                SizedBox(
                  height: _deviceHeight! * 0.002,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    plusminsButton(
                      "+/-",
                    ),
                    circleButton(
                      0,
                    ),
                    operatorButton(
                      ".",
                    ),
                    equalButton("=")
                  ],
                ),
                const Center(
                    child: Text(
                  "Created by Eddouche Yasser",
                  style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget circleButton(int val) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text += val.toString();
          // print(text);
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230)),
      child: Text(
        val.toString(),
        style: const TextStyle(
            fontSize: 26, color: Color.fromARGB(255, 52, 52, 52)),
      ),
    );
  }

  Widget equalButton(String eq) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          // print(result);
          try {
            result = text.interpret().toDouble();
            if (text.isNotEmpty) {
              // operation.addEntries(
              //     {MapEntry("operation", text), MapEntry("result", result)});
              history.add({"operation": text, "result": result});
            }
            // print(text.interpret());
          } catch (e) {
            // print(e);
            text = 'Error!';
          }
          res = text;
          text = result.toString();
        });
        // print(exp);
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 129, 255, 112)),
      child: Text(
        eq,
        style: const TextStyle(
            fontSize: 26, color: Color.fromARGB(255, 52, 52, 52)),
      ),
    );
  }

  Widget clearButton(String clr) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text = "";
          result = 0;
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230)),
      child: Text(
        clr,
        style: const TextStyle(
            fontSize: 26, color: Color.fromARGB(255, 255, 41, 41)),
      ),
    );
  }

  Widget operatorButton(String op) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          text += op;
          // print(text);
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230)),
      child: Text(
        op,
        style: const TextStyle(
            fontSize: 26, color: Color.fromARGB(255, 52, 52, 52)),
      ),
    );
  }

  Widget plusminsButton(String symb) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          result *= -1;
          text = result.toString();
          res = text;
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230)),
      child: Text(
        symb,
        style: const TextStyle(
            fontSize: 24, color: Color.fromARGB(255, 52, 52, 52)),
      ),
    );
  }

  Widget seperatorButton(String symb) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          int count1 = 0, count2 = 0;
          for (var i = 0; i < text.length; i++) {
            text[i] == "(" ? count1++ : count1;
            text[i] == ")" ? count2++ : count2;
          }
          if (count1 == count2) {
            text += "(";
          } else {
            text += ")";
          }
        });
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          fixedSize: Size(_deviceWidth! * 0.115, _deviceHeight! * 0.115),
          backgroundColor: const Color.fromARGB(255, 230, 230, 230)),
      child: Text(
        symb,
        style: const TextStyle(
            fontSize: 26, color: Color.fromARGB(255, 52, 52, 52)),
      ),
    );
  }
}
