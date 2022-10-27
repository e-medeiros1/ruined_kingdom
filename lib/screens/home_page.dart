import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ruined_kingdom/screens/map_render.dart';
import 'package:ruined_kingdom/widgets/enemies/boss/boss_sprite_sheet.dart';
import 'package:ruined_kingdom/widgets/enemies/firer/firer_sprite_sheet.dart';
import 'package:ruined_kingdom/widgets/player/super/super_sprite_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPosition = 0;
  late async.Timer _timer;
  List<Future<SpriteAnimation>> sprites = [
    SuperSpriteSheet.attackEspecialRight,
    BossSpriteSheet.attackLeft,
    FirerSpriteSheet.firerRunRight
  ];

  final Uri myGithub =
      Uri(scheme: 'https', host: 'www.github.com', path: '/e-medeiros1/');
  final Uri bonfireGithub = Uri(
      scheme: 'https',
      host: 'www.github.com',
      path: '/RafaelBarbosatec/bonfire/');

  Future<void> _launchInWeb(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

    @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              const Text(
                "RUINED KINGDOM",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.0,
                    fontFamily: 'PressStart2P-Regular'),
              ),
              if (sprites.isNotEmpty)
                SizedBox(
                  height: 280,
                  width: 300,
                  child: CustomSpriteAnimationWidget(
                    animation: sprites[currentPosition],
                  ),
                ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(100, 40),
                  ),
                  child: const Text(
                    'START',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapRender()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              if (Platform.isWindows)
                SizedBox(
                  height: 120,
                  width: 210,
                  child: Sprite.load('decoration/keyboard_tip.png').asWidget(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Made by ',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _launchInWeb(myGithub);
                        });
                      },
                      child: const Text(
                        'Medeiros',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Built with ',
                      style: TextStyle(color: Colors.white, fontSize: 12.0),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _launchInWeb(bonfireGithub);
                        });
                      },
                      child: const Text(
                        'Bonfire',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 12.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    _timer = async.Timer.periodic(const Duration(milliseconds: 1800), (timer) {
      setState(() {
        currentPosition++;
        if (currentPosition > sprites.length - 1) {
          currentPosition = 0;
        }
      });
    });
  }
}

class CustomSpriteAnimationWidget extends StatelessWidget {
  final Future<SpriteAnimation> animation;

  const CustomSpriteAnimationWidget({Key? key, required this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 150,
      child: animation.asWidget(),
    );
  }
}
