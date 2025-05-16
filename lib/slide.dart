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
    //final tt = Tt();
    final pp = AudioPlayer();
    pp.play(AssetSource('power01.ogg'));
    pp.pause();
    //final ass = AssetSource('assets/power01.ogg');
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
                  onPressed: () {
                    pp.stop();
                    Navigator.pushNamed(context, prev);
                  },
                  child: TextL(str: 'B'),
                ),
                TextButton(
                  onPressed: () {
                    if (pp.state == PlayerState.paused) {
                      pp.resume();
                    } else {
                      pp.pause();
                    }
                  },
                  child: TextL(str: 'P')
                ),
                TextButton(
                  onPressed: () {
                    pp.stop();
                    Navigator.pushNamed(context, next);
                  },
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