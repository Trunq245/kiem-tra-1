import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "0";
  String currentCalculation = ""; // Biến lưu trữ phép tính hiện tại
  List<String> history = [];
  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "/" ||
        buttonText == "x") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
      currentCalculation = "$num1 $operand "; // Cập nhật phép tính hiện tại
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output += buttonText;
        currentCalculation += buttonText; // Cập nhật phép tính hiện tại
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      currentCalculation = ""; // Đặt lại phép tính hiện tại
    }
    else if (buttonText == "DEL") { // Xử lý nút xóa
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
    }
    else if (buttonText == "+/-") {
      double currentValue = double.parse(output);
      double newValue = -currentValue; // Chuyển đổi dấu của giá trị hiện tại
      _output = newValue.toString(); // Cập nhật giá trị mới
    }
    else if (buttonText == "x^2") { // Thêm điều kiện cho nút x^2
      double currentValue = double.parse(output);
      double result = currentValue * currentValue;
      _output = result.toStringAsFixed(2); // Cập nhật _output với kết quả mới
    }
    else if (buttonText == "√") { // Thêm điều kiện cho nút căn bậc hai
      double currentValue = double.parse(output);
      if (currentValue >= 0) {
        double result = sqrt(currentValue);
        _output = result.toStringAsFixed(2); // Cập nhật _output với kết quả mới
      } else {
        print("Cannot compute square root of a negative number");
      }
    }
    else if (buttonText == "1/x") { // Thêm điều kiện cho nút 1/x
      double currentValue = double.parse(output);
      if (currentValue != 0) {
        double result = 1 / currentValue;
        _output = result.toStringAsFixed(2); // Cập nhật _output với kết quả mới
      } else {
        print("Cannot divide by zero");
      }
    } else {
      _output += buttonText;
    }

    setState(() {
      output = _output; // Cập nhật giá trị hiển thị trên màn hình
    });
  }


  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: OutlinedButton(
          onPressed: () {
            buttonPressed(buttonText);
          },
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
        actions: <Widget>[
        ],
      ),
      body: Column(
        children: <Widget>[
          // Hiển thị phép tính và số
          Container(
            padding: EdgeInsets.all(24.0),
            alignment: Alignment.centerRight,
            child: Text(
              currentCalculation,
              style: TextStyle(fontSize: 24.0),
            ),
          ),
          // Hiển thị kết quả
          Container(
            padding: EdgeInsets.all(24.0),
            alignment: Alignment.bottomRight,
            child: Text(
              output,
              style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          // Các nút tính toán
          Row(
            children: <Widget>[
              buildButton("MC"),
              buildButton("MR"),
              buildButton("M+"),
              buildButton("M-"),
              buildButton("MS"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("%"),
              buildButton("CE"),
              buildButton("C"),
              buildButton("DEL"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1/x "),
              buildButton("x^2"),
              buildButton("√"),
              buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("x"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("+")
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("+/-"),
              buildButton("0"),
              buildButton(","),
              buildButton("="),
            ],
          ),
        ],
      ),
    );
  }
}
