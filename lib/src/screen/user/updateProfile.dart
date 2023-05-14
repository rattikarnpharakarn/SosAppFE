import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/src/model/accounts/response.dart';
import 'package:sos/src/model/accounts/signup.dart';

import 'package:http/http.dart' as http;
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/provider/config.dart';
import 'package:sos/src/sharedInfo/user.dart';

import '../common/LoadingPage.dart';
import 'home.dart';

class UpDataProfilePage extends StatefulWidget {
  const UpDataProfilePage({Key? key}) : super(key: key);

  @override
  State<UpDataProfilePage> createState() => _UpDataProfilePageState();
}

class _UpDataProfilePageState extends State<UpDataProfilePage> {
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      await _deforeGetUserInfoSF();
      await _getToken();
    });
  }

  _getToken() async {
    var token = await getUserTokenSf();
    setState(()  {
      _token = token;
      isLoading = true;
    });
  }

  String _id = '';
  String _token = '';

  String _deforefirstName = '';
  String _deforelastName = '';
  String _deforeemail = '';

  String _deforebirthday = '';
  String _deforebirthdayshow = '';
  String _deforeImage = '';

  String _deforeIDCard = '';
  String _deforetextIDCard = '';

  String _deforeaddress = '';
  String _deforesubDistrict = '';
  String _deforedistrict = '';
  String _deforeprovince = '';
  String _deforepostalCode = '';

  String selectGroupSex = '';

  void _selectGroupSex(String value) {
    setState(() {
      selectGroupSex = value;
    });
  }

  _deforeGetUserInfoSF() async {
    var data = await GetUserProfile();
    DateTime dt2 = DateTime.parse(data.birthday);
    final String birthday = newFormat.format(dt2);

    setState(() {
      _id = data.id;
      _deforefirstName = data.firstName;
      _deforelastName = data.lastName;
      _deforeemail = data.email;

      _deforebirthday = data.birthday;
      _deforebirthdayshow = birthday;
      selectGroupSex = data.gender;

      _deforeImage = data.imageProfile;

      _deforetextIDCard = data.textIDCard;
      _deforeIDCard = data.pathImage;

      _deforeaddress = data.address;
      _deforesubDistrict = data.subDistrict;
      _deforedistrict = data.district;
      _deforeprovince = data.province;
      _deforepostalCode = data.postalCode;
    });
  }

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _textIDCard = '';

  String _address = '';
  String _subDistrict = '';
  String _district = '';
  String _province = '';
  String _postalCode = '';

  late UpdateProfile userInfoRes;

  void setDataUserInfo() {
    setState(() {
      userInfoRes = UpdateProfile(
        firstName: _firstName == '' ? _deforefirstName : _firstName,
        lastName: _lastName == '' ? _deforelastName : _lastName,
        email: _email == '' ? _deforeemail : _email,
        birthday: _dateTime.toString(),
        gender: selectGroupSex.toString(),
        imageProfile: _deforeImage,
        pathImage: _deforeIDCard,
        textIDCard: _textIDCard == '' ? _deforetextIDCard : _textIDCard,
        address: _address == '' ? _deforeaddress : _address,
        subDistrict: _subDistrict == '' ? _deforesubDistrict : _subDistrict,
        district: _district == '' ? _deforedistrict : _district,
        province: _province == '' ? _deforeprovince : _postalCode,
        postalCode: _postalCode == '' ? _deforepostalCode : _postalCode,
        country: 'ไทย',
      );
    });

    EditUserInfo();
  }

  addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    addUserProfileToSF();
  }

  Future<ReturnResponse> EditUserInfo() async {
    String url = '${urlAccount}user/${_id}';
    final response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${_token}'
      },
      body: jsonEncode(userInfoRes),
    );

    if (response.statusCode == 200) {
      await addStringToSF(_token);

      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const Home();
      }));

      return ReturnResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Send APIName : EditUserInfo || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
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
      _deforebirthday = _dateTime.toString();
    });
  }

  @override
  Widget build(BuildContext context) => isLoading == false
      ? const LoadingPage()
      : Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            iconTheme: const IconThemeData(
              color: Colors.black, // <-- SEE HERE
            ),
            leading:
                const BackButton(color: Color.fromARGB(255, 255, 255, 255)),
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
                            'Edit Profile',
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
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'First Name *',
                                  labelText: _deforefirstName,
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  // helperText: 'Ex. 0812345678',
                                  // helperStyle: TextStyle(color: Colors.white),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 114, 114, 114)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
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
                                decoration: InputDecoration(
                                  labelText: _deforelastName,
                                  hintText: 'Last Name *',
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  // helperText: 'Ex. 0812345678',
                                  // helperStyle: TextStyle(color: Colors.black),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 114, 114, 114)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
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
                                decoration: InputDecoration(
                                  labelText: _deforeemail,
                                  hintText: 'Email',
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  // helperText: 'Ex. 0812345678',
                                  // helperStyle: TextStyle(color: Colors.black),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 114, 114, 114)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
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
                                enabled : false,
                                decoration: InputDecoration(
                                  labelText: _deforetextIDCard,
                                  hintText: 'ID Card *',
                                  labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                  // helperText: 'Ex. 0812345678',
                                  // helperStyle: TextStyle(color: Colors.black),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 114, 114, 114)),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 20, 0),
                                                        child: const Icon(Icons
                                                            .calendar_month)),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 20, 0),
                                                      child: Text(
                                                          _deforebirthdayshow),
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
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 20, 0),
                                                        child: const Icon(Icons
                                                            .calendar_month)),
                                                    Container(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
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
                          // widget.data.verifyCode['verifyCode'].toString(),
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
                          decoration: InputDecoration(
                            hintText: 'House No.',
                            labelText: _deforeaddress,
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
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
                          decoration: InputDecoration(
                            labelText: _deforesubDistrict,
                            hintText: 'Sub-district',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
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
                          decoration: InputDecoration(
                            labelText: _deforedistrict,
                            hintText: 'District',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
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
                          decoration: InputDecoration(
                            labelText: _deforeprovince,
                            hintText: 'Province',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
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
                          decoration: InputDecoration(
                            labelText: _deforepostalCode,
                            hintText: 'Postal Code',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 93, 93, 93)),
                            // helperText: 'Ex. 0812345678',
                            // helperStyle: TextStyle(color: Colors.white),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 114, 114, 114)),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 87, 87, 87)),
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
                                "Save",
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
