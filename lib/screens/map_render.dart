import 'dart:math';
import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ng_bonfire/utils/basic_value.dart';
import 'package:ng_bonfire/widgets/decoration/bonfire/bonfire.dart';
import 'package:ng_bonfire/widgets/decoration/boots/boots.dart';
import 'package:ng_bonfire/widgets/decoration/potion/potion.dart';
import 'package:ng_bonfire/widgets/decoration/sword/sword.dart';
import 'package:ng_bonfire/widgets/enemies/boss/boss.dart';
import 'package:ng_bonfire/widgets/enemies/canine/canine.dart';
import 'package:ng_bonfire/widgets/enemies/deather/deather.dart';
import 'package:ng_bonfire/widgets/enemies/firer/firer.dart';
import 'package:ng_bonfire/widgets/enemies/ghost/ghost.dart';
import 'package:ng_bonfire/widgets/player/super/super.dart';
import 'dart:io' show Platform;

const double tileSize = BasicValues.TILE_SIZE;

class MapRender extends StatefulWidget {
  const MapRender({super.key});

  @override
  State<MapRender> createState() => _MapRenderState();
}

class _MapRenderState extends State<MapRender> {
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
          sprite: Sprite.load('decoration/joystick_atack.png'),
          spritePressed: Sprite.load('decoration/joystick_atack_selected.png'),
          size: 80,
          margin: const EdgeInsets.only(bottom: 50, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('decoration/joystick_atack_range.png'),
          spritePressed:
              Sprite.load('decoration/joystick_atack_range_selected.png'),
          size: 50,
          margin: const EdgeInsets.only(bottom: 50, right: 160),
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
            LogicalKeyboardKey.keyX,
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
            },
          ),
          player: Super(position: Vector2(tileSize * 20, tileSize * 31)),
          //Camera
          cameraConfig: CameraConfig(
            moveOnlyMapArea: false,
            zoom: 1.4,
            sizeMovementWindow: Vector2(15, 15),
          ),
          //Joystick
          joystick: joystick,
          lightingColorGame: Colors.black.withOpacity(0.3),
          background: BackgroundColorGame(Colors.grey[900]!),
          progress: Scaffold(
            body: Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Carregando...",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
