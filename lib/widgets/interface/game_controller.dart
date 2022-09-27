import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/screens/home_page.dart';
import 'package:ng_bonfire/screens/map_render.dart';

class MyGameController extends GameComponent {
  bool endGame = false;
  bool gameOver = false;

  @override
  void update(double dt) {
    if (checkInterval('end game', 1000, dt)) {
      if ((gameRef.livingEnemies().isEmpty) && !endGame) {
        endGame = true;
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: AlertDialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: const Text(
                    'CONGRATULATIONS!!! I hope that you enjoyed!',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        _goHome();
                      },
                      child: const Text(
                        'Back to home!',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    }

    if (checkInterval('gameover', 1000, dt)) {
      if (gameRef.player?.isDead == true && !gameOver) {
        gameOver = true;
        showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
              backgroundColor: Colors.red.shade500.withOpacity(0.15),
              body: AlertDialog(
                backgroundColor: Colors.transparent,
                actionsAlignment: MainAxisAlignment.center,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: const Text(
                  'YOU DIED!!!',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                alignment: Alignment.center,
                actions: [
                  TextButton(
                    onPressed: () {
                      _goHome();
                    },
                    child: const Text('Return to home',
                        style: TextStyle(fontSize: 14, color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () {
                      _goStage();
                    },
                    child: const Text('Play again',
                        style: TextStyle(fontSize: 14, color: Colors.blue)),
                  ),
                ],
              ),
            );
          },
        );
      }
    }

    super.update(dt);
  }

  void _goStage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return const MapRender();
      }),
      (route) => false,
    );
  }

  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return const HomePage();
      }),
      (route) => false,
    );
  }
}
