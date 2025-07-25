class Ingredient {
  final String name;
  final double amount;
  final String unit;
  final bool isOptional;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
    this.isOptional = false,
  });

  Ingredient scale(double factor) {
    return Ingredient(
      name: name,
      amount: amount * factor,
      unit: unit,
      isOptional: isOptional,
    );
  }

  String get displayText {
    final amountText = amount == amount.round()
        ? amount.round().toString()
        : amount.toStringAsFixed(1);
    return '$amountText $unit $name${isOptional ? ' (optional)' : ''}';
  }
}
