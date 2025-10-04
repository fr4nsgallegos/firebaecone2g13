import 'dart:async';

import 'package:flutter/material.dart';

class ContadorStreamController extends StatefulWidget {
  ContadorStreamController({super.key});

  @override
  State<ContadorStreamController> createState() =>
      _ContadorStreamControllerState();
}

class _ContadorStreamControllerState extends State<ContadorStreamController> {
  final StreamController<int> _streamController = StreamController<int>();

  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    _streamController.sink.add(_counter);
  }

  @override
  void dispose() {
    _streamController.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder(
              stream: _streamController.stream,
              initialData: _counter,
              builder: (context, snapshot) {
                return Text(
                  "valor: ${snapshot.data ?? 0}",
                  style: TextStyle(fontSize: 35),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
              },
              child: Text("Incrementar el contador"),
            ),
          ],
        ),
      ),
    );
  }
}
