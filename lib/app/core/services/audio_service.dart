import 'package:audioplayers/audioplayers.dart';

abstract class AudioService {
  Future<void> play({String path, bool status = true});
}

class AudioServiceImpl implements AudioService {
  final AudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);
  @override
  Future<void> play({String? path, bool status = true}) async {
    if (status) {
      await _audioPlayer.play(AssetSource(path!));
      return;
    }
    await _audioPlayer.stop();
  }
}
