import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/widgets/decoration/bonfire/bonfire_sprite_sheet.dart';
import 'package:ng_bonfire/widgets/enemies/ghost/ghost.dart';

class Bonfire extends GameDecoration with Sensor, Lighting, ObjectCollision {
  Bonfire({required Vector2 position})
      : super.withAnimation(
            animation: BonfireSpriteSheet.bonfire,
            position: position,
            size: Vector2(tileSize * 2, tileSize * 2)) {
    setupSensorArea(areaSensor: [
      CollisionArea.rectangle(
        size: Vector2(tileSize * 2, tileSize),
        align: Vector2(5, 30),
      ),
    ]);

    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(16, 35),
            align: Vector2(25, 20),
          ),
        ],
      ),
    );

    setupLighting(
      LightingConfig(
        radius: tileSize / 1.4,
        color: Colors.orange.withOpacity(0.3),
        withPulse: true,
        pulseSpeed: 1.5,
        pulseVariation: 0.2,
        align: Vector2(1, 5),
        blurBorder: 25,
      ),
    );
  }

  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      gameRef.player?.addLife(2);
    } else if (component is Enemy) {
      null;
    }
  }

  @override
  void onContactExit(GameComponent component) {}
}
