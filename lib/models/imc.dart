import 'package:flutter/material.dart';

class Imc {
  int? id;
  double _peso;
  double _altura;

  Imc({
    this.id,
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

  String get getPeso => _peso.toStringAsFixed(2).replaceAll('.', ',');
  String get getAltura => _altura.toStringAsFixed(2).replaceAll('.', ',');

  String get getImc => double.parse((_peso / (_altura * _altura)).toStringAsFixed(2)).toString().replaceAll('.', ',');
}