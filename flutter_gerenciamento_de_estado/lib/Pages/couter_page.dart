import 'package:flutter/material.dart';

import 'package:flutter_gerenciamento_de_estado/provider/counter.dart';

class CouterPage extends StatefulWidget {
  const CouterPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CouterPage> createState() => _CouterPageState();
}

class _CouterPageState extends State<CouterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemplo contador'),
      ),
      body: Column(
        children: [
          Text(CounterProvider.of(context)?.state.value.toString() ?? '0'),
          IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)?.state.inc();
                  // print(CounterProvider.of(context)?.state.value);
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                setState(() {
                  CounterProvider.of(context)?.state.dec();
                  // print(CounterProvider.of(context)?.state.value);
                });
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
