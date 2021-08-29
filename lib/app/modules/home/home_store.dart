import 'package:app/app/modules/home/pages/initial/initial_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  int counter = 0;

  @observable
  int _indexPage = 0;

  @observable
  List<Widget> page = [
    InitialPage(),
  ];

  @action
  int getIndexPage() => _indexPage;

  @action
  setIndex(int indexActual) => _indexPage = indexActual;

  @action
  Future<void> increment() async {
    counter = counter + 1;
  }
}
