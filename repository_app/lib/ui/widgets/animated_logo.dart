import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:repository/util/Assets.dart';

class AnimatedLogo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  AnimationStatus? _animationStatus;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          duration: Duration(milliseconds: 300),
          child: _animationStatus == AnimationStatus.completed
              ? Column(
                  children: [
                    Image(
                        image: AssetImage(ImageAssets.repository_logo),
                        fit: BoxFit.scaleDown,
                        height: 200),
                    Text(
                      'Repository search app',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    )
                  ],
                )
              : Lottie.asset(
                  AnimationAssets.circleLoading,
                  width: 200,
                  repeat: false,
                  controller: _animationController,
                  onLoaded: (composition) {
                    _animationController
                      ?..duration = composition.duration
                      ..addStatusListener((status) {
                        setState(() {
                          _animationStatus = status;
                        });
                      })
                      ..forward();
                  },
                ),
        ),
      ],
    );
  }
}
