import 'package:bonfire/bonfire.dart';

import 'package:ng_bonfire/widgets/interface/bar_life.dart';

class SuperInterface extends GameInterface {
  @override
  Future<void> onLoad() async {
    add(BarLife());
    return super.onLoad();
  }
}
