import 'package:assets_audio_player/assets_audio_player.dart';

abstract class AudioService {
  Future<void> play({String path, bool status = true});
}

class AudioServiceImpl implements AudioService {
  final AssetsAudioPlayer _audioPlayer;

  AudioServiceImpl(this._audioPlayer);
  @override
  Future<void> play({String? path, bool status = true}) async {
    await _audioPlayer.open(
      Audio(path!),
      autoStart: true,
      volume: 100,
      loopMode: LoopMode.single,
      showNotification: false,
    );
    if (status) {
      _audioPlayer.play();
      return;
    }
    _audioPlayer.stop();
  }
}
