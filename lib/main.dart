import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LinearProgressIndicator(),
            ElevatedButton(
                onPressed: () {
                  double val = function();
                  print(val);
                },
                child: const Text('one')),
            ElevatedButton(
                onPressed: () {
                  ReceivePort receivePort = ReceivePort();

                  Isolate.spawn(isolatefun, receivePort.sendPort);
                  receivePort.listen((message) {
                    print(message);
                  });
                },
                child: const Text('one'))
          ],
        ),
      ),
    );
  }

  double function() {
    double value = 1;
    for (int i = 1; i < 100000000; i++) {
      value = 1 + value;
    }

    return value;
  }
}

void isolatefun(SendPort sendPort) {
  double value = 1;
  for (int i = 1; i < 100000000; i++) {
    value = 2 + value;
  }
  sendPort.send(value);
}
