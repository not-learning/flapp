import 'package:audioplayers/audioplayers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sound.g.dart';

@riverpod
class Sound extends _$Sound {
  final player = AudioPlayer();
  var playing = false;

  @override
  Future<void> build() async {
    return await player.play(AssetSource('power01.ogg'));
  }

  Future<void> play() async {
    await player.resume();
    playing = true;
  }

  Future<void> pause() async {
    print(state);
    if (playing) {
      await player.pause();
      playing = false;
    } else {
      await player.resume();
      playing = true;
    }
  }
}
