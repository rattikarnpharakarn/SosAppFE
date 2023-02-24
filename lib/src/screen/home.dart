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
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        child: const Text(
                          "Good morning Gig.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 24,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1),
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
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Image.asset(
                        'assets/images/profile.jpg',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                      // Image.memory( base64Decode(imageBase64), fit: BoxFit.cover )
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
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
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
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
