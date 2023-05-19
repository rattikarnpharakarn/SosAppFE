import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos/src/provider/accounts/userService.dart';
import 'package:sos/src/screen/common/snack_bar_sos.dart';

class UploadIDCard extends StatefulWidget {
  const UploadIDCard({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  final String username;
  final String password;

  @override
  State<UploadIDCard> createState() => _UploadIDCardState();
}

class _UploadIDCardState extends State<UploadIDCard> {
  final _formKey = GlobalKey<FormState>();

  late bool isButtonDisabled = false;

  final TextEditingController _textIDCard = TextEditingController();

  _uploadImage() async {
    print(_textIDCard.text.trim());
    await updateImageVerifyAgain(
      widget.username,
      widget.password,
      _textIDCard.text.trim(),
      selectImage,
    );

    Navigator.pop(
      context,
    );
    Navigator.pop(
      context,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 0,
        backgroundColor: const Color.fromARGB(255, 248, 0, 0),
        elevation: 0,
        centerTitle: false,
        title: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                child: const Text(
                  "แก้ไขข้อมูลสำหรับการยืนยันตัวตน",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        actions: [
          Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                  child: InkWell(
                      onTap: () => {
                            openImage(),
                          },
                      child: selectImage == ''
                          ? Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Image.asset('assets/images/idcard.png'),
                            )
                          : Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              child: Image.memory(base64Decode(selectImage)),
                            )),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                  child: TextFormField(
                    maxLength: 13,
                    controller: _textIDCard,
                    decoration: const InputDecoration(
                      labelText: 'ID Card',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
                      // helperText: 'Ex. 0812345678',
                      // helperStyle: TextStyle(color: Colors.black),
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
                          // backgroundColor:
                          //     MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.29),
                              side: const BorderSide(
                                  width: 3, color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: isButtonDisabled
                            ? () {
                                if (_textIDCard.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarSos(
                                        context,
                                        const Text(
                                          "Please enter ID Card",
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        ),
                                        Colors.white),
                                  );
                                } else if (_textIDCard.text.length != 13) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    snackBarSos(
                                        context,
                                        const Text(
                                          "The ID card number must contain 13 characters.",
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 16),
                                        ),
                                        Colors.white),
                                  );
                                } else {
                                  _uploadImage();
                                }
                              }
                            : null,
                        child: const Text(
                          "อัพเดทข้อมูล",
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
    );
  }

  final ImagePicker imgPicker = ImagePicker();
  String selectImage = "";

  void openImage() async {
    try {
      var pickedFile = await imgPicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        String imagePath = pickedFile.path;
        File imageFile = File(imagePath);
        Uint8List imageBytes = await imageFile.readAsBytes();
        String base64string = base64.encode(imageBytes);

        Uint8List decodedBytes = base64.decode(base64string);

        String select = base64Encode(decodedBytes);
        setState(() {
          selectImage = select;
          isButtonDisabled = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarSos(
            context,
            Text(
              e.toString(),
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
            Colors.white),
      );
    }
  }
}
