import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

abstract class _SplashStoreBase with Store {
  @action
  initPage() {
    return Future.delayed(
        Duration(seconds: 5), () => Modular.to.pushReplacementNamed('/home'));
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
