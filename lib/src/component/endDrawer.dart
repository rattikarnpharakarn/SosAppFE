import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sos/src/component/image_navBer.dart';
import 'package:sos/src/screen/home.dart';
import 'package:sos/src/screen/signin.dart';

import '../screen/changePassword.dart';
import '../screen/updateProfile.dart';
import '../sharedInfo/user.dart';

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
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
                      child: Image_NavBer(width: 150,height: 150),
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                accountName: const Text(
                  "Chirapon Hemrkan",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: const Text(
                  "Chirapon.job@gmail.com",
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
