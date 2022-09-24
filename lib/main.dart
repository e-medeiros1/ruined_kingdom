import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      theme: ThemeData(fontFamily: 'PressStart2P-Regular'),
      debugShowCheckedModeBanner: false,
      home: const  HomePage(),
    );
  }
}
