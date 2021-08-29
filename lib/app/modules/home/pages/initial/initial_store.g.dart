// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'initial_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InitialStore on InitialStoreBase, Store {
  final _$showDrawerAtom = Atom(name: 'InitialStoreBase.showDrawer');

  @override
  bool get showDrawer {
    _$showDrawerAtom.reportRead();
    return super.showDrawer;
  }

  @override
  set showDrawer(bool value) {
    _$showDrawerAtom.reportWrite(value, super.showDrawer, () {
      super.showDrawer = value;
    });
  }

  final _$counterAtom = Atom(name: 'InitialStoreBase.counter');

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

  @override
  String toString() {
    return '''
showDrawer: ${showDrawer},
counter: ${counter}
    ''';
  }
}
