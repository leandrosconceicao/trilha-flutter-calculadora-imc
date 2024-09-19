import 'package:flutter/material.dart';

class Imc {
  double _peso;
  double _altura;

  Imc({
    required double peso,
    required double altura
  }) : _peso = peso, _altura = altura;

  factory Imc.fromInputs(TextEditingController pesoInput, TextEditingController alturaInput) {
    final parsedPeso = double.tryParse(pesoInput.text.replaceAll(',', '.'));
    final parsedAlt = double.tryParse(alturaInput.text.replaceAll(',', '.'));
    return Imc(
      peso: parsedPeso ?? 0.0,
      altura: parsedAlt ?? 0.0
    );
  }

  double get peso => _peso;
  double get altura => _altura;

  double get getImc => double.parse((_peso / (_altura * _altura)).toStringAsFixed(2));
}