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
    int a = 10;
    return Scaffold(
      bottomNavigationBar: Bottombar(pageNumber: _pageNumber),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: <Widget>[
                  Text(
                    "Good morning Gig.",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  'You need any help?',
                  style: TextStyle(
                    color: Colors.red.shade800,
                    fontSize: 18,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
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
                      title:
                          Text('Sonu Nigam', style: TextStyle(fontSize: 30.0)),
                      subtitle: Text('Best of Sonu Nigam Music.',
                          style: TextStyle(fontSize: 18.0)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton(
                        child: const Text(
                          'View Detail',
                          style: const TextStyle(
                            color: const Color.fromARGB(255, 45, 28, 178),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: const Text(
                'แจ้งเหตุ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              height: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 20,
                child: GridView.count(
                  primary: true,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(
                    4,
                    (index) {
                      a += 10;
                      return Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.blue.withAlpha(a),
                        child: Text('Item ${index}'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
