import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruined_kingdom/screens/home_page.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  await Sounds.initialize();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: 'PressStart2P-Regular'),
    home: const HomePage(),
  ));
}
