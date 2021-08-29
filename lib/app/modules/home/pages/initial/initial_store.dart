import 'package:mobx/mobx.dart';

part 'initial_store.g.dart';

class InitialStore = InitialStoreBase with _$InitialStore;

abstract class InitialStoreBase with Store {
  @observable
  bool showDrawer = false;

  @observable
  int counter = 0;

  Future<void> increment() async {
    counter = counter + 1;
  }
}
