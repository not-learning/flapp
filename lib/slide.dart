//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'utils.dart';

class Slide extends StatelessWidget {
  final List<Widget> anims;
  //final AudioPlayer player;
  //final BuildContext cnt;
  final String next;
  final String prev;
  final String subs;

  const Slide({
    super.key,
    required this.anims,
    //required this.player,
    //required this.cnt,
    required this.next,
    required this.prev,
    required this.subs,
  });

  @override
  Widget build(BuildContext context) {
    final player = Sound();

    void nextF() {
      player.stop();
      Navigator.pushNamed(context, next);
    }

    void prevF() {
      player.stop();
      Navigator.pushNamed(context, prev);
    }

    player.init('power01.ogg', nextF);
    //player.play();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child: Stack(children: anims)),

            TextS(str: subs),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => prevF(),
                  child: TextL(str: 'B'),
                ),
                TextButton(
                  onPressed: () => player.pause(),
                  child: TextL(str: 'P')
                ),
                TextButton(
                  onPressed: () => nextF(),
                  child: TextL(str: 'F'),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class Sound {
  AudioPlayer player = AudioPlayer();
  bool playing = false;

  Sound();

  void init(String file, Function func) {
    isDone(func);
    player.setSource(AssetSource(file));
    player.pause();
  }

  play() {
    if (!playing) {
      player.resume();
      playing = true;
    }
  }

  stop() async {
    playing = false;
    player.pause();
  }

  pause() async {
    if (playing) {
      playing = false;
      player.pause();
    } else {
      await player.resume();
      playing = true;
    }
  }

  dispose() async {
    playing = false;
    //await player.dispose(); // TODO why no wait?
    player.dispose();
  }

  bool isPlaying() => playing;

  isDone(func) {
    player.onPlayerComplete.first
    .then((onValue) => func());
    //.catchError((error) => print(error)); //todo logging; DEV
  }
}

/*Future<Uint8List?> rr(BuildContext cnt) async {
    AssetBundle tt = DefaultAssetBundle.of(cnt);
    print(tt);
    final aa = tt.load('assets/power01.ogg');
    print(aa);
    /*final ass = AssetSource('assets/power01.ogg');
    final player = AudioPlayer();
    player.play(ass);*/
    return aa;
}*/