import 'package:flutter/material.dart';
import 'package:sos/src/component/form_data.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220.0),
        // preferredSize: Size(MediaQuery.of(context).size.width, 200),
        child: AppBar(
          // toolbarHeight: 100,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Colors.black, // <-- SEE HERE
          ),
          leading: const BackButton(color: Colors.black),
          titleSpacing: 0,
          backgroundColor: const Color.fromARGB(255, 248, 0, 0),
          elevation: 0,
          title: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29.8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: const Text(
                            'Please enter your Info',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(360),
            ),
          ),
          flexibleSpace: Container(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
            alignment: Alignment.center,
            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Image.asset(
                                "assets/images/Image1.jpeg",
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: () {
                                print('FAB tapped!');
                              },
                              backgroundColor: Color.fromARGB(255, 17, 17, 17),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form_Data("First Name", 10, 60, 10, 0, TextInputType.text),
                Form_Data("Last Name", 10, 0, 10, 0, TextInputType.text),
                Form_Data("ID Card", 10, 0, 10, 0, TextInputType.number),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Text("asdasdasdasdsa12"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
