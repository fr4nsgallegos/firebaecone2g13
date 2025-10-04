import 'dart:async';

import 'package:flutter/material.dart';

class MultipleStreamController extends StatefulWidget {
  const MultipleStreamController({super.key});

  @override
  State<MultipleStreamController> createState() =>
      _MultipleStreamControllerState();
}

class _MultipleStreamControllerState extends State<MultipleStreamController> {
  StreamController<int> streamController1 = StreamController<int>();
  StreamController<int> streamController2 = StreamController<int>();
  StreamController<int> streamController3 = StreamController<int>.broadcast();

  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;

  void _incrementCounter1() {
    counter1++;
    streamController1.sink.add(counter1);
  }

  void _incrementCounter2() {
    counter2++;
    streamController2.sink.add(counter2);
  }

  void _incrementCounter3() {
    counter3++;
    streamController3.sink.add(counter3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<int>(
              stream: streamController1.stream,
              initialData: counter1,
              builder: (context, snapshot) {
                return Text(
                  'Stream 1: ${snapshot.data}',
                  style: TextStyle(fontSize: 25),
                );
              },
            ),
            StreamBuilder<int>(
              stream: streamController2.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  'Stream 2: ${snapshot.data}',
                  style: TextStyle(fontSize: 25),
                );
              },
            ),
            StreamBuilder<int>(
              stream: streamController3.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return Text(
                  'Stream 3: ${snapshot.data}',
                  style: TextStyle(fontSize: 25),
                );
              },
            ),
            Divider(),
            ElevatedButton(
              onPressed: _incrementCounter1,
              child: Text('Increment Stream 1'),
            ),
            ElevatedButton(
              onPressed: _incrementCounter2,
              child: Text('Increment Stream 2'),
            ),
            ElevatedButton(
              onPressed: _incrementCounter3,
              child: Text('Increment Stream 3'),
            ),
            Divider(),
            StreamBuilder(
              stream: streamController3.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 16,
                  ),
                  child: LinearProgressIndicator(
                    value: (snapshot.data ?? 0) / 10,
                  ),
                );
              },
            ),
            StreamBuilder(
              stream: streamController3.stream,
              builder: (context, snapshot) {
                if ((snapshot.data ?? 0) >= 10) {
                  return Text('Stream 3 llegóa a 10!');
                }
                return Text("Progreso: ${snapshot.data ?? 0}/10");
              },
            ),
          ],
        ),
      ),
    );
  }
}
