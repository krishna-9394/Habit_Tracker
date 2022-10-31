import 'package:flutter/material.dart';
import 'dart:math' as Math;
import 'clipper_widget.dart';

class WaveWidget extends StatefulWidget {
  final Size size;
  final double yOffset;
  final Color color;

  const WaveWidget({super.key,
    required this.size, required this.yOffset, required this.color});

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin{
  late AnimationController animationController;
  List<Offset> WavePoint = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 5000))
      ..addListener(() {
        WavePoint.clear();
        final double waveSpeed = animationController.value * 1080;
        final double fullSphere = animationController.value * Math.pi * 2;
        final double normalizer = Math.cos(fullSphere);
        final double waveWidth = Math.pi /270;
        final double waveHeight = 20;

        for(int i = 0;i <= widget.size.width.toInt();++i){
          double calculations = Math.sin((waveSpeed - i) * waveWidth);
          WavePoint.add(Offset(i.toDouble(), calculations * waveHeight * normalizer + widget.yOffset));
        }
      });
    animationController.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context,_) {
        return ClipPath(
            clipper: ClipperWidget(
              waveList: WavePoint,
            ),
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              color: widget.color,
            )
        );
      }
    );
  }
}
