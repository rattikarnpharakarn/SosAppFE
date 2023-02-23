import 'package:flutter/material.dart';
import 'package:sos/src/component/bottom_bar.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home'),
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
  final int _pageNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      body: Container(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            crossAxisCount: 3,
            children: [
              Container(
                color: Colors.red,
                child: const Center(child: Text("1")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("2")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("3")),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(child: Text("4")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("5")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("6")),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(child: Text("1")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("2")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("3")),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(child: Text("4")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("5")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("6")),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(child: Text("1")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("2")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("3")),
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                child: const Center(child: Text("4")),
              ),
              Container(
                color: Colors.brown,
                child: const Center(child: Text("5")),
              ),
              Container(
                color: Colors.green,
                child: const ButtonBar(
                  children: [
                    Center(child: Text("6")),
                  ],
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
