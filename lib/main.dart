import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sos/src/sharedInfo/user.dart';
import 'src/screen/LoadingPage.dart';
import 'src/screen/chats/screens/chat.dart';

final FlutterLocalNotificationsPlugin ShowflutterLocalNoificationPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings intiandroidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ignore: prefer_const_constructors
  final InitializationSettings initializationSettings = InitializationSettings(
    android: intiandroidInitializationSettings,
  );

  await ShowflutterLocalNoificationPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = false;

  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () async {
      await _getImageProfile();
    });
  }

  String _token = '';
  late String id;

  _getImageProfile() async {
    var token = await getUserTokenSf();

    // var data = await GetUserProfile();

    setState(() {
      // id = data.id;
      _token = token;
      isLoading = true;
    });
  }

  Widget mainSosApp() {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      // home: const SosPage(),
      // home: HotlinePage(),
      // home: Signup(),
      // home: SignupPhoneNumber(),
      // home: SosPage1(),
      // home: UpDataProfilePage(),
      home: ChatPage(),
      // home: TestPage(),
      // home: id == '' ? Signin() : Home(), // หน้าแรกของแอบ
      // home: _token == '' ? Signin() : Home(), // หน้าแรกของแอบ
    );
  }

  Widget mainLoadingPage() {
    return MaterialApp(
      title: 'SosApp',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LoadingPage(),
    );
  }

  @override
  Widget build(BuildContext context) =>
      isLoading == false ? mainLoadingPage() : mainSosApp();
}
