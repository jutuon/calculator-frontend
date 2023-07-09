import 'package:calculator_frontend/logic/calculator/calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String _displayText = '';
  String _currentBlocState = '';

  void _addToDisplay(BuildContext context, String value) {
      print("add to display: ${value}");

      try {
        final number = int.parse(value);
        setState(() {
          if (_displayText == "0") {
            _displayText = "";
          }
          _displayText += value;
        });
        return;
      } catch (e) {
        // not a number
        print("Not a number");
      }

      final int number;
      try {
        number = int.parse(_displayText);
        setState(() {
          _displayText = "";
        });
      } catch (e) {
        // not a number
        print("Not a number");
        return;
      }

      switch (value) {
        case '+': {
          context.read<CalculatorBloc>().add(DoOperation(CalculatorOperation.add, number));
        }
        case '-': {
          context.read<CalculatorBloc>().add(DoOperation(CalculatorOperation.subtract, number));
        }
        case '*': {
          context.read<CalculatorBloc>().add(DoOperation(CalculatorOperation.multiply, number));
        }
        case '/': {
          context.read<CalculatorBloc>().add(DoOperation(CalculatorOperation.divide, number));
        }
      }
  }

  void _clearDisplay(BuildContext context) {
    setState(() {
      _displayText = '';
      context.read<CalculatorBloc>().add(Reset());
    });
  }

  void _calculateResult(BuildContext context) {
    final int number;
    try {
      number = int.parse(_displayText);
    } catch (e) {
      // not a number
      print("Not a number");
      return;
    }

    context.read<CalculatorBloc>().add(DoOperation(CalculatorOperation.equals, number));
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: BlocBuilder<CalculatorBloc, CalculatorData>(
                builder: (context, data) {
                  if (_currentBlocState != data.state) {
                    _currentBlocState = data.state ?? '';
                    _displayText = data.state ?? '';
                  }
                  return Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              ),
            ),
          ),
          Divider(height: 1.0),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    _buildNumberButton(context, '7'),
                    _buildNumberButton(context, '8'),
                    _buildNumberButton(context, '9'),
                    _buildOperatorButton(context, '/'),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton(context, '4'),
                    _buildNumberButton(context, '5'),
                    _buildNumberButton(context, '6'),
                    _buildOperatorButton(context, '*'),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton(context, '1'),
                    _buildNumberButton(context, '2'),
                    _buildNumberButton(context, '3'),
                    _buildOperatorButton(context, '-'),
                  ],
                ),
                Row(
                  children: [
                    _buildNumberButton(context, '0'),
                    _buildOperatorButton(context, '+'),
                    _buildActionButton(context, 'C'),
                    _buildActionButton(context, '='),
                  ],
                ),
              ],
            ),
          ),
        ],
    );
  }

  Widget _buildNumberButton(BuildContext context, String value) {
    return Expanded(
      child: MaterialButton(
        height: 100.0,
        onPressed: () => _addToDisplay(context, value),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  Widget _buildOperatorButton(BuildContext context, String value) {
    return Expanded(
      child: MaterialButton(
        height: 100.0,
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () => _addToDisplay(context, value),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String value) {
    return Expanded(
      child: MaterialButton(
        height: 100.0,
        color: Colors.red,
        textColor: Colors.white,
        onPressed: () {
          final f = value == 'C' ? _clearDisplay : _calculateResult;
          f(context);
        },
        child: Text(
          value,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
