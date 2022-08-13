import 'package:assets_audio_player/assets_audio_player.dart';

abstract class AudioService {
  Future<void> play({String path});
}

class AudioServiceImpl implements AudioService {
  final AssetsAudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);
  @override
  Future<void> play({String? path}) async {
    await _audioPlayer.open(
      Audio(path!),
      autoStart: true,
      volume: 100,
      showNotification: false,
    );
    _audioPlayer.play();
  }
}
