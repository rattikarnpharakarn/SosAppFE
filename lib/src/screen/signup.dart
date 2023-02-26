import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:sos/src/model/response.dart';
import 'package:sos/src/model/signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Signup extends StatefulWidget {
  Signup({Key? key, required this.userInfo}) : super(key: key);
  // const Signup({Key? key}) : super(key: key);

  UserInfo userInfo;
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String _password = '';
  String _confirmPassword = '';

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _textIDCard = '';

  String _address = '';
  String _subDistrict = '';
  String _district = '';
  String _province = '';
  String _postalCode = '';
  late UserInfo userInfoRes;
  bool isPasswordError = true;
  void setDataUserInfo() {
    if (_password != _confirmPassword) {
      setState(() {
        isPasswordError = false;
      });
    } else {
      setState(() {
        isPasswordError = true;
      });
      var user = widget.userInfo;

      setState(() {
        userInfoRes = UserInfo(
          phoneNumber: user.phoneNumber,
          password: _password,
          confirmPassword: _confirmPassword,
          firstName: _firstName,
          lastName: _lastName,
          email: _email,
          birthday: _dateTime.toString(),
          gender: selectGroupSex.toString(),
          imageProfile: imageProfile,
          pathImage: iDCard,
          textIDCard: _textIDCard,
          address: _address,
          subDistrict: _subDistrict,
          district: _district,
          province: _province,
          postalCode: _postalCode,
          country: 'ไทย',
          otp: user.otp,
          verifyCode: user.verifyCode,
        );
      });

      createUserInfo();

      // print('======> UserInfo  <======\n');
      // print('phoneNumber : ' + userInfoRes!.phoneNumber);
      // print('password :' + userInfoRes!.password);
      // print('confirmPassword : ' + userInfoRes!.confirmPassword);
      // print('firstName : ' + userInfoRes!.firstName);
      // print('lastName : ' + userInfoRes!.lastName);
      // print('email : ' + userInfoRes!.email);
      // print('birthday : ' + userInfoRes!.birthday);
      // print('gender : ' + userInfoRes!.gender);
      // print('imageProfile : ' + userInfoRes!.imageProfile);
      // print('======> UserInfo  <======\n');

      // print('======> idCard  <======\n');
      // print('pathImage : ' + userInfoRes!.idCard.pathImage);
      // print('textIDCard : ' + userInfoRes!.idCard.textIDCard);
      // print('======> idCard  <======\n');

      // print('======> address  <======\n');
      // print('address : ' + userInfoRes!.address.address);
      // print('country : ' + userInfoRes!.address.country);
      // print('district : ' + userInfoRes!.address.district);
      // print('postalCode : ' + userInfoRes!.address.postalCode);
      // print('province : ' + userInfoRes!.address.province);
      // print('subDistrict : ' + userInfoRes!.address.subDistrict);
      // print('======> address  <======\n');

      // print('======> verify  <======\n');
      // print('otp : ' + userInfoRes!.verify.otp);
      // print('verifyCode : ' + userInfoRes!.verify.verifyCode);
      // print('======> verify  <======\n');

    }
  }

  Future<ReturnResponse> createUserInfo() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:80/SosApp/accounts/createUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userInfoRes),
    );

    if (response.statusCode == 200) {
      print(response.body);
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Home();
      }));

      return ReturnResponse.fromJson(jsonDecode(response.body));
    } else {
      // print(response.body);
      var dataResponse = jsonDecode(response.body);

      throw Exception(dataResponse);
    }
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
      _dateTime = date;
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
                                        'assets/images/profile.webp',
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'First Name *',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              // helperText: 'Ex. 0812345678',
                              // helperStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 114, 114, 114)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 87, 87, 87)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) => setState(
                              () {
                                _firstName = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Last Name *',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              // helperText: 'Ex. 0812345678',
                              // helperStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 114, 114, 114)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 87, 87, 87)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) => setState(
                              () {
                                _lastName = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              // helperText: 'Ex. 0812345678',
                              // helperStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 114, 114, 114)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 87, 87, 87)),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) => setState(
                              () {
                                _email = value;
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'ID Card *',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 93, 93, 93)),
                              // helperText: 'Ex. 0812345678',
                              // helperStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 114, 114, 114)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color.fromARGB(255, 87, 87, 87)),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.black),
                            onChanged: (value) => setState(
                              () {
                                _textIDCard = value;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
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
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(17, 10, 20, 0),
                          child: const Text(
                            'Birthday * :',
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
                                                ),
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
                          child: const Text('Sex *  : '),
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
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                    child: const Text(
                      // widget.call().data.verifyCode['verifyCode'].toString(),
                      "Address.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'House No.',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _address = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sub-district',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _subDistrict = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'District',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _district = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Province',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _province = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Postal Code',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _postalCode = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                    child: isPasswordError == false
                        ? const Text(
                            "*** Password and Confirm Password do not match.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 245, 18, 18),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            "Set Password.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password.',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _password = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password.',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                        // helperText: 'Ex. 0812345678',
                        // helperStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 114, 114, 114)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: Color.fromARGB(255, 87, 87, 87)),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) => setState(
                        () {
                          _confirmPassword = value;
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 45, 0, 50),
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
                            "SingUp",
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
