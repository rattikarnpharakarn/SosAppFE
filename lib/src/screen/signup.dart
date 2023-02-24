import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sos/src/component/form_data.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/model/signup.dart';
import 'package:sos/src/screen/home.dart';

import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  Signup({Key? key, required this.userInfo}) : super(key: key);

  UserInfo userInfo;
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  void setDataUserInfo() {
    print(widget.userInfo!);
    UserInfo userInfoRes = UserInfo(
      phoneNumber: widget.userInfo.phoneNumber,
      password: '',
      confirmPassword: '',
      firstName: '',
      lastName: '',
      email: '',
      birthday: '',
      gender: '',
      imageProfile: '',
      idCard: IdCard(
        pathImage: '',
        textIDCard: '',
      ),
      address: Address(
          address: '',
          country: '',
          district: '',
          postalCode: '',
          province: '',
          subDistrict: ''),
      verify: Verify(
        otp: widget.userInfo.verify.otp,
        verifyCode: widget.userInfo.verify.verifyCode,
      ),
    );
  }

  // upload Image to base64
  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String imageProfile = '';
  String iDCard = '';
  openImage(String type) async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagepath = pickedFile.path;
        File imagefile = File(imagepath);
        Uint8List imagebytes = await imagefile.readAsBytes();
        String base64string = base64.encode(imagebytes);

        Uint8List decodedbytes = base64.decode(base64string);

        String tobase64 = base64Encode(decodedbytes);
        if (type == 'Profile') {
          setState(() {
            imageProfile = tobase64;
          });
        } else {
          setState(() {
            iDCard = tobase64;
          });
        }
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  var newFormat = DateFormat("dd-MM-yyyy");
  DateTime _dateTime = DateTime.now();
  String showDate = '';

  void pickDate(DateTime date) {
    _dateTime = date;
    final String formatted = newFormat.format(_dateTime);
    setState(() {
      showDate = formatted.toString();
    });
  }

  String selectGroupSex = '';
  void _selectGroupSex(String value) {
    setState(() {
      selectGroupSex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        leading: const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
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
                          color: Color.fromARGB(255, 255, 255, 255),
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
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(360),
                                child: imageProfile == ''
                                    ? Image.asset(
                                        'assets/images/profile.jpg',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(
                                        base64Decode(imageProfile),
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                // Image.memory( base64Decode(imageBase64), fit: BoxFit.cover )
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                child: FloatingActionButton(
                                  child: Icon(Icons.add),
                                  onPressed: () {
                                    openImage('Profile');
                                  },
                                  backgroundColor:
                                      Color.fromARGB(255, 17, 17, 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Form_Data("First Name", 0, 0, 0, 0, TextInputType.text),
                        Form_Data("Last Name", 0, 0, 0, 0, TextInputType.text),
                        Form_Data("ID Card", 0, 0, 0, 0, TextInputType.number),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                    margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    child: InkWell(
                      onTap: () => {openImage('iDCard')},
                      child: iDCard == ''
                          ? const Text(
                              'กรุณา แนบรูปภาพบัตรประจำตัวประชาชน ***',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.transparent, // Step 2 SEE HERE
                                shadows: [
                                  Shadow(
                                      offset: Offset(0, -5),
                                      color: Colors.black)
                                ],
                                decoration: TextDecoration.underline,
                                decorationColor: Color.fromARGB(255, 177, 0, 0),
                              ),
                            )
                          : const Text(
                              'แนบรูปภาพบัตรประจำตัวประชาชน สำเร็จ',
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: Colors.transparent, // Step 2 SEE HERE
                                shadows: [
                                  Shadow(
                                      offset: Offset(0, -5),
                                      color: Colors.black)
                                ],
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    Color.fromARGB(255, 34, 172, 0),
                              ),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(17, 10, 20, 0),
                          child: const Text(
                            'Birthday :',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(17, 10, 20, 0),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1960),
                                    lastDate: DateTime(3000),
                                  ).then((date) => pickDate(date!));
                                },
                                child: Container(
                                  child: showDate == ''
                                      ? SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    child: const Icon(
                                                        Icons.calendar_month)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 20, 0),
                                                  child: Text(
                                                    newFormat
                                                        .format(_dateTime)
                                                        .toString(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 0),
                                                    child: const Icon(
                                                        Icons.calendar_month)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 20, 0),
                                                  child: Text(
                                                    showDate.toString(),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(17, 0, 60, 0),
                          child: Text('Sex : '),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Radio(
                            value: 'M',
                            groupValue: selectGroupSex,
                            onChanged: (value) => _selectGroupSex(value!),
                          ),
                        ),
                        const Text('Male'),
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Radio(
                            value: 'F',
                            groupValue: selectGroupSex,
                            onChanged: (value) => _selectGroupSex(value!),
                          ),
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        width: 312.48,
                        height: 63.4,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.29),
                                side: const BorderSide(
                                    width: 3, color: Colors.black),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setDataUserInfo();
                          },
                          child: const Text(
                            "Next page",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
