import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ng_bonfire/widgets/player/super/super.dart';

class BarLife extends InterfaceComponent {
  double padding = 20;
  double widthBar = 83;
  double strokeWidth = 12;

  double maxLife = 0;
  double life = 0;
  double maxStamina = 100;
  double stamina = 0;

  BarLife()
      : super(
          id: 1,
          position: Vector2(18, 16),
          spriteUnselected: Sprite.load('decoration/health_ui.png'),
          size: Vector2(120, 40),
        );

  @override
  void update(double dt) {
    if (gameRef.player != null) {
      life = gameRef.player!.life;
      maxLife = gameRef.player!.maxLife;
      if (gameRef.player is Super) {
        stamina = (gameRef.player as Super).stamina;
      }
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawLife(canvas);
      _drawStamina(canvas);
    // ignore: empty_catches
    } catch (e) {}
    super.render(canvas);
  }

  void _drawLife(Canvas canvas) {
    double xBar = 21;
    double yBar = 26;
    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + widthBar, yBar),
        Paint()
          ..color = Colors.blueGrey[800]!
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);

    double currentBarLife = (life * widthBar) / maxLife;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarLife, yBar),
        Paint()
          ..color = _getColorLife(currentBarLife)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  void _drawStamina(Canvas canvas) {
    double xBar = 21;
    double yBar = 46;

    double currentBarStamina = (stamina * widthBar) / maxStamina;

    canvas.drawLine(
        Offset(xBar, yBar),
        Offset(xBar + currentBarStamina, yBar),
        Paint()
          ..color = const Color.fromARGB(255, 82, 191, 212)
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.fill);
  }

  Color _getColorLife(double currentBarLife) {
    if (currentBarLife > widthBar - (widthBar / 3)) {
      return Colors.green;
    }
    if (currentBarLife > (widthBar / 3)) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
