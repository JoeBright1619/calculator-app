import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iOS Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0';
  String _expression = '';

  // Function to update the output when a button is pressed
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        output = '0';
      } else if (buttonText == '=') {
        try {
          output = _calculateResult(_expression);
          _expression = output;
        } catch (e) {
          output = 'Error';
        }
      } else if (buttonText == 'DEL') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
          output = _expression.isEmpty ? '0' : _expression;
        }
      } else {
        _expression += buttonText;
        output = _expression;
      }
    });
  }

  // Function to evaluate the expression
  String _calculateResult(String expression) {
    try {
      // Basic evaluation (for more complex parsing, consider using a package)
      return _evalExpression(expression).toString();
    } catch (e) {
      return 'Error';
    }
  }

  // Simple evaluator function for the expression
  double _evalExpression(String expression) {
    // A more robust solution would involve parsing the expression and handling errors
    return double.parse(expression); // Simple conversion for demo purposes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('iOS Calculator'),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          // Display result/output at the top
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Calculator button layout
          Row(
            children: <Widget>[
              _buildButton('C', Colors.red),
              _buildButton('DEL', Colors.grey),
              _buildButton('%', Colors.orange),
              _buildButton('/', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('7', Colors.grey),
              _buildButton('8', Colors.grey),
              _buildButton('9', Colors.grey),
              _buildButton('x', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('4', Colors.grey),
              _buildButton('5', Colors.grey),
              _buildButton('6', Colors.grey),
              _buildButton('-', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('1', Colors.grey),
              _buildButton('2', Colors.grey),
              _buildButton('3', Colors.grey),
              _buildButton('+', Colors.orange),
            ],
          ),
          Row(
            children: <Widget>[
              _buildButton('0', Colors.grey),
              _buildButton('.', Colors.grey),
              _buildButton('=', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  // Custom method to build buttons with text and style
  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
