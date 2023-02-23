import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:sos/src/screen/signin.dart';

import '../component/bottom_bar.dart';
import '../component/form_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  final int _pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(1, 1, 1, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Good morning Gig.",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 25, 0, 25),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            'You need any help?',
                            style: TextStyle(
                              color: Colors.red.shade800,
                              fontSize: 25,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.red,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 20,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const ListTile(
                          // leading: Icon(Icons.album, size: 60),
                          title: Text('Sonu Nigam',
                              style: TextStyle(fontSize: 30.0)),
                          subtitle: Text('Best of Sonu Nigam Music.',
                              style: TextStyle(fontSize: 18.0)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              15), //apply padding to all four sides
                        ),
                        ElevatedButton(
                          child: Text(
                            'View Detail',
                            style: TextStyle(
                              color: Color.fromARGB(255, 45, 28, 178),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
