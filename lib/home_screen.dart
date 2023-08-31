import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String input = "";
  String result = "0";

  List<String> buttons = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      input,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      result,
                      style: const TextStyle(color: Colors.white, fontSize: 45),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1 / 1,
                            mainAxisExtent: 57),
                    itemCount: buttons.length,
                    itemBuilder: (BuildContext context, int index) {
                      return customButton(buttons[index]);
                    })),
          )
        ],
      ),
    );
  }

  Widget customButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      splashColor: Colors.black,
      child: Ink(
        decoration: BoxDecoration(
          color: buttonColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.white70,
              blurRadius: 3,
              offset: Offset(3, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: textColor(text),
            ),
          ),
        ),
      ),
    );
  }

  textColor(String text) {
    if (text == "(" ||
        text == ")" ||
        text == "/" ||
        text == "" ||
        text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "." ||
        text == "C") {
      return Colors.deepOrange;
    } else {
      return Colors.white;
    }
  }

  buttonColor(text) {
    if (text == "AC") {
      return Colors.deepOrange;
    } else if (text == "=") {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  handleButtons(text) {
    if (text == 'AC') {
      input = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculate();
      if (input.endsWith(".0")) {
        input = input.replaceAll(".0", "");
      }

      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    input += text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(input);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
