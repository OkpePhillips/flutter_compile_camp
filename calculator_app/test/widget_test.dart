import 'package:calculator_app/claculator_logic.dart';
import 'package:calculator_app/models/calculator_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculator Logic Tests', () {
    test('Basic addition', () {
      var state = const CalculatorState();
      state = CalculatorLogic.processInput(state, "2");
      state = CalculatorLogic.processInput(state, "+");
      state = CalculatorLogic.processInput(state, "3");
      state = CalculatorLogic.processInput(state, "=");

      expect(state.display, "5");
      expect(state.currentValue, 5.0);
    });

    test('Division by zero', () {
      var state = const CalculatorState();
      state = CalculatorLogic.processInput(state, "5");
      state = CalculatorLogic.processInput(state, "÷");
      state = CalculatorLogic.processInput(state, "0");
      state = CalculatorLogic.processInput(state, "=");

      expect(state.display, "Error");
    });

    test('Memory functions', () {
      var state = const CalculatorState();
      state = CalculatorLogic.processInput(state, "5");
      state = CalculatorLogic.processInput(state, "M+");
      expect(state.memory, 5.0);

      state = CalculatorLogic.processInput(state, "3");
      state = CalculatorLogic.processInput(state, "M+");
      expect(state.memory, 8.0);

      state = CalculatorLogic.processInput(state, "MR");
      expect(state.display, "8");
    });

    test('Complex calculation with history', () {
      var state = const CalculatorState();
      state = CalculatorLogic.processInput(state, "2");
      state = CalculatorLogic.processInput(state, "+");
      state = CalculatorLogic.processInput(state, "3");
      state = CalculatorLogic.processInput(state, "=");

      expect(state.history.length, 1);
      expect(state.history.first.expression, "2 + 3");
      expect(state.history.first.result, "5");
    });
  });
}
