import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/main.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/provider/config.dart';
import 'package:http/http.dart' as http;

import '../model/accounts/response.dart';
import '../model/accounts/signup.dart';
import '../screen/common/changePassword.dart';
import '../screen/user/home.dart';
import '../screen/user/signin.dart';
import '../screen/user/updateProfile.dart';
import '../sharedInfo/user.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  @override
  void initState() {
    super.initState();
    _getNameProfile();
  }
  String _token = '';
  String _fullName = '';
  String _email = '';

  _getNameProfile() async {
    {
      String email = await getUserEmailSF();
      String firstName = await getUserFirstNameSF();
      String lastName = await getUserLastNameSF();
      var token = await getUserTokenSf();
      setState(() {
        _fullName = firstName + ' ' + lastName;
        _email = email;
        _token = token;
      });
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = '';
  String images = '';

  openImage() async {
    try {
      var pickedFile;
      pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        imagepath = pickedFile.path;
        File imagefile = File(imagepath);
        Uint8List imagebytes = await imagefile.readAsBytes();
        String base64string = base64.encode(imagebytes);

        Uint8List decodedbytes = base64.decode(base64string);

        String tobase64 = base64Encode(decodedbytes);
        setState(() {
          images = tobase64;
        });

        await setDataUserInfo();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  addStringToSF(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    addUserProfileToSF();
  }
  late UpdateProfile userInfoRes;

  setDataUserInfo() async {
    setState(() {
      userInfoRes = UpdateProfile(
        firstName: '',
        lastName: '',
        email: '',
        birthday: '',
        gender: '',
        imageProfile: images,
        pathImage: '',
        textIDCard: '',
        address: '',
        subDistrict: '',
        district: '',
        province: '',
        postalCode:'',
        country: '',
      );
    });

    EditUserInfo();
  }


  Future<ReturnResponse> EditUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id') ?? '';
    String url = '${urlAccount}user/${id}';
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
        return const MyApp();
      }));

      return ReturnResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Send APIName : EditUserInfo || statusCode : ${response.statusCode.toString()} || Msg : ${jsonDecode(response.body)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: MediaQuery.of(context).size.width * 0.59,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                currentAccountPicture: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Container(
                      padding: EdgeInsets.zero,
                      child: TextButton(
                        child: Image_NavBer(width: 200, height: 200),
                        onPressed: () {
                          openImage();
                        },
                      ),
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                accountName: Text(
                  _fullName,
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  _email,
                  style: TextStyle(color: Colors.black),
                ),
                // otherAccountsPictures: [
                //   CircleAvatar(
                //     backgroundColor: Colors.white,
                //     backgroundImage: NetworkImage(
                //         "https://randomuser.me/api/portraits/women/74.jpg"),
                //   ),
                //   CircleAvatar(
                //     backgroundColor: Colors.white,
                //     backgroundImage: NetworkImage(
                //         "https://randomuser.me/api/portraits/men/47.jpg"),
                //   ),
                // ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("EditProfile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpDataProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.password_outlined),
              title: const Text("ChangePassword"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangePasswordPage(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.account_box),
            //   title: const Text("About"),
            //   onTap: () {},
            // ),
            const AboutListTile(
              // <-- SEE HERE
              icon: Icon(
                Icons.info,
              ),
              child: Text('About app'),
              applicationIcon: Icon(
                Icons.local_play,
              ),
              applicationName: 'Sos Application',
              applicationVersion: '0.1',
              applicationLegalese: '© 2019 Bell & Gig',
              aboutBoxChildren: [
                ///Content goes here...
              ],
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                removeValues();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Signin(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
