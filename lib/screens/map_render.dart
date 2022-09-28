import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:io' show Platform;

import 'package:ruined_kingdom/utils/basic_value.dart';
import 'package:ruined_kingdom/utils/sounds/sounds.dart';
import 'package:ruined_kingdom/widgets/decoration/bonfire/bonfire.dart';
import 'package:ruined_kingdom/widgets/decoration/boots/boots.dart';
import 'package:ruined_kingdom/widgets/decoration/heal/heal.dart';
import 'package:ruined_kingdom/widgets/decoration/potion/potion.dart';
import 'package:ruined_kingdom/widgets/decoration/sword/sword.dart';
import 'package:ruined_kingdom/widgets/enemies/boss/boss.dart';
import 'package:ruined_kingdom/widgets/enemies/canine/canine.dart';
import 'package:ruined_kingdom/widgets/enemies/deather/deather.dart';
import 'package:ruined_kingdom/widgets/enemies/firer/firer.dart';
import 'package:ruined_kingdom/widgets/enemies/ghost/ghost.dart';
import 'package:ruined_kingdom/widgets/interface/game_controller.dart';
import 'package:ruined_kingdom/widgets/interface/super_interface.dart';
import 'package:ruined_kingdom/widgets/player/super/super.dart';

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

double tileSize = BasicValues.TILE_SIZE;

class _MapRenderState extends State<MapRender> implements GameListener {
  late GameController controller;

  @override
  void initState() {
    controller = GameController()..addListener(this);
    Sounds.playBackgroundSound();
    super.initState();
  }

  @override
  void dispose() {
    Sounds.stopBackgroundSound();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeScreen = min(size.height, size.width) * 2.5;

    var joystick = Joystick(
      directional: JoystickDirectional(
        spriteBackgroundDirectional:
            Sprite.load('decoration/joystick_background.png'),
        spriteKnobDirectional: Sprite.load('decoration/joystick_knob.png'),
        size: 100,
      ),
      actions: [
        JoystickAction(
          actionId: 0,
          sprite: Sprite.load('decoration/red_button.png'),
          spritePressed: Sprite.load('decoration/red_button_pressed.png'),
          size: 80,
          margin: const EdgeInsets.only(bottom: 60, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('decoration/blue_button.png'),
          spritePressed: Sprite.load('decoration/blue_button_pressed.png'),
          size: 55,
          margin: const EdgeInsets.only(bottom: 50, right: 150),
        )
      ],
    );
    if (Platform.isWindows) {
      joystick = Joystick(
        keyboardConfig: KeyboardConfig(
          enable: true,
          keyboardDirectionalType: KeyboardDirectionalType.wasdAndArrows,
          acceptedKeys: [
            LogicalKeyboardKey.space,
            LogicalKeyboardKey.keyZ,
          ],
        ),
      );
    }

    return Center(
      child: SizedBox(
        width: sizeScreen,
        height: sizeScreen,
        child: BonfireWidget(
          showCollisionArea: false,
          //Map
          map: WorldMapByTiled(
            'map/gamemap.json',
            forceTileSize: Vector2.all(tileSize),
            objectsBuilder: {
              'firer': (properties) => Firer(position: properties.position),
              'canine': (properties) => Canine(position: properties.position),
              'ghost': (properties) => Ghost(position: properties.position),
              'deather': (properties) => Deather(position: properties.position),
              'boss': (properties) => Boss(position: properties.position),
              'potion': (properties) => Potion(position: properties.position),
              'bonfire': (properties) => Bonfire(position: properties.position),
              'sword': (properties) => Sword(position: properties.position),
              'boots': (properties) => Boots(position: properties.position),
              'heal': (properties) => Heal(position: properties.position),
            },
          ),
          //Player
          player: Super(position: Vector2(tileSize * 20, tileSize * 31)),

          //Camera
          cameraConfig: CameraConfig(
            moveOnlyMapArea: false,
            zoom: 1.4,
            sizeMovementWindow: Vector2(15, 15),
          ),

          //Joystick
          joystick: joystick,

          interface: SuperInterface(),

          gameController: controller,

          components: [
            MyGameController(),
          ],

          lightingColorGame: Platform.isWindows
              ? Colors.black.withOpacity(0.25)
              : Colors.black.withOpacity(0.15),

          background: BackgroundColorGame(Colors.grey[900]!),

          progress: Scaffold(
            body: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {}
}
