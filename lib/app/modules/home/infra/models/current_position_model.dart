import 'dart:convert';

import '../../domain/entities/current_position.dart';

class CurrentPositionModel extends CurrentPosition {
  final double lat;
  final double long;
  CurrentPositionModel(this.lat, this.long) : super(lat, long);

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }

  factory CurrentPositionModel.fromMap(Map<String, dynamic> map) {
    return CurrentPositionModel(
      map['lat'] ?? '',
      map['long'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentPositionModel.fromJson(String source) =>
      CurrentPositionModel.fromMap(json.decode(source));
}
