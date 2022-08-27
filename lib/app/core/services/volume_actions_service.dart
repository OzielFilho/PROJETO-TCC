import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

abstract class VolumeActionsService {
  initialization(VoidCallback action);
}

class VolumeActionsServiceImpl implements VolumeActionsService {
  @override
  initialization(VoidCallback action) {
    List<int> volume = [];
    PerfectVolumeControl.stream.listen((event) {
      volume.add(1);
      if (volume.toString() == '[1, 1, 1, 1, 1, 1]') {
        action();
        volume.clear();
      }
    });
  }
}
