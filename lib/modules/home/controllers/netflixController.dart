import 'package:flutter/cupertino.dart';

class NetflixController extends ChangeNotifier{
  final addNomePerfil = TextEditingController();

  static const clickAnimationDurationMillis = 130;

  late final AnimationController animationController;
  
  double scaleTransformValue = 1;

  void shrinkButtonSize() {
    animationController.forward();
  }

  void restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis - 90),
      () => animationController.reverse(),
    );
  }

  bool isValidNome(){
    return addNomePerfil.text.isNotEmpty ? true : false;
  }
}