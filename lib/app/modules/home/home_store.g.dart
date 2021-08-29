// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$counterAtom = Atom(name: 'HomeStoreBase.counter');

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  final _$_indexPageAtom = Atom(name: 'HomeStoreBase._indexPage');

  @override
  int get _indexPage {
    _$_indexPageAtom.reportRead();
    return super._indexPage;
  }

  @override
  set _indexPage(int value) {
    _$_indexPageAtom.reportWrite(value, super._indexPage, () {
      super._indexPage = value;
    });
  }

  final _$pageAtom = Atom(name: 'HomeStoreBase.page');

  @override
  List<Widget> get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(List<Widget> value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$incrementAsyncAction = AsyncAction('HomeStoreBase.increment');

  @override
  Future<void> increment() {
    return _$incrementAsyncAction.run(() => super.increment());
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  int getIndexPage() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getIndexPage');
    try {
      return super.getIndexPage();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIndex(int indexActual) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setIndex');
    try {
      return super.setIndex(indexActual);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter},
page: ${page}
    ''';
  }
}
