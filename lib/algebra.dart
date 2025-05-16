//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'shapes.dart';
import 'slide.dart';

class Algebra01 extends StatelessWidget {
  const Algebra01({super.key});
  
  @override
  Widget build(BuildContext context) {
    //player.setSource(AssetSource('power01.ogg'));
    final slide = Slide(
      anims: [
        TextAnim(
          text: 'x + 3 = 5',
          fontSize: 30,
          startP1: Offset(-100, -100),
          startP2: Offset(120, -120),
          finishP1: Offset(0, 0),
          finishP2: Offset(120, -100),
          startClr: null,
          finishClr: Colors.white,
          dur: 1,
        ),
      ],
      //player: AudioPlayer(),
      //cnt: context,
      next: 'algebra02',
      prev: 'maths',
      subs: 'I got Algebra!'
    );
    //slide.player.setSource(AssetSource('power01.ogg'));
    //slide.player.resume();
    return slide;
  }
}

class Algebra02 extends StatelessWidget {
  const Algebra02({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Slide(
      anims: [
        TextAnim(
          text: 'x = 2',
          fontSize: 30,
          startP1: Offset(-100, -100),
          startP2: Offset(120, -120),
          finishP1: Offset(0, 0),
          finishP2: Offset(120, -100),
          startClr: null,
          finishClr: Colors.white,
          dur: 1,
        ),
      ],
     // player: AudioPlayer(),
      //cnt: context,
      next: 'algebra03',
      prev: 'algebra01',
      subs: 'going?'
    );
  }
}

