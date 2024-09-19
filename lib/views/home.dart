import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/imc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final registros = ValueNotifier<List<Imc>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrador de IMC"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: registros,
        builder: (ctx, value, __) {
          if (value.isEmpty) {
            return const Center(
              child: Text(
                "Nenhum registro no momento",
                textAlign: TextAlign.center,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: value.length,
                itemBuilder: (ctx, i) {
                  final imc = value[i];
                  return ListTile(
                    leading: Text("${i + 1}"),
                    title: Text("IMC Registrado: ${imc.getImc}"),
                    subtitle: Text(
                        "Peso informado - ${imc.peso}, altura informada - ${imc.altura}"),
                  );
                },
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 16.0))
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Registrar IMC",
        onPressed: () async {
          final imc = await showDialog<Imc>(
              context: context,
              builder: (ctx) {
                final peso = TextEditingController();
                final altura = TextEditingController();
                final formKey = GlobalKey<FormState>();
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Novo registro"),
                  content: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: peso,
                          validator: validarInput,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(labelText: "Peso"),
                        ),
                        TextFormField(
                          controller: altura,
                          validator: validarInput,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration:
                              const InputDecoration(labelText: "Altura"),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text("Cancelar")),
                    FilledButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          Navigator.of(context)
                              .pop(Imc.fromInputs(peso, altura));
                        },
                        child: const Text("Registrar"))
                  ],
                );
              });
          if (imc == null) {
            return;
          }
          addRegistro(imc);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  String? validarInput(String? txt) {
    if (txt!.trim().isEmpty ||
        double.tryParse(txt.replaceAll(',', '.')) == null) {
      return "Inválido";
    }
    double input = double.parse(txt.replaceAll(',', '.'));
    if (input == 0) {
      return "Digite um valor maior que zero";
    }
    return null;
  }

  void addRegistro(Imc imc) {
    registros.value += [imc];
  }
}
