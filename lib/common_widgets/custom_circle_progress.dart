import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/color_constants.dart';

class CustomCircleProgress extends StatelessWidget {
  CustomCircleProgress({super.key, required this.size, required this.progress});

  final double size;
  final int progress;
  TextTheme? textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return buildCircularProgress(size: size, progress: progress);
  }

  Stack buildCircularProgress({required int progress, required double size}) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: size - 36,
          width: size - 36,
          child: CircularProgressIndicator(
            strokeWidth: 20.0,
            backgroundColor: ColorConstants.secondaryColor,
            valueColor: const AlwaysStoppedAnimation<Color>(
                ColorConstants.textPinkColor),
            value: progress / 100,
          ),
        ),
        SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
            backgroundColor: ColorConstants.secondaryColor,
            valueColor:
                AlwaysStoppedAnimation<Color>(ColorConstants.textPinkColor),
            value: progress / 100,
          ),
        ),
        SizedBox(
          height: size + 60,
          width: size + 60,
          child: DottedCircularProgress(
            progress: progress/100,
            size: size + 60,
          ),
        ),
        Positioned(
          child: Container(
            height: size,
            width: size,
            child: Center(
              child: Text(
                "$progress%",
                style: textTheme?.bodyLarge?.copyWith(fontSize: 28),
              ),
            ),
          ),
        ),
        Stack(
          children: buildSeparators(3, size: size),
        ),
      ],
    );
  }

  List<Widget> buildSeparators(int nbSeparators, {required double size}) {
    var sep = <Widget>[];
    for (var i = 0; i < nbSeparators; i++) {
      sep.add(
        Transform.rotate(
          angle: i * 1 / nbSeparators * 2 * pi,
          child: Container(
            width: 6,
            height: size + 6,
            child: Column(
              children: <Widget>[
                Container(
                  width: 8,
                  height: 10,
                  color: ColorConstants.backgroundColor,
                )
              ],
            ),
          ),
        ),
      );
    }
    return sep;
  }
}

class DottedCircularProgress extends StatelessWidget {
  final double progress;
  final int totalDots = 60;
  final double dotSize = 8.0;
  final double size;

  const DottedCircularProgress({super.key, required this.progress, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: List.generate(
          (progress * totalDots).ceil(),
          (index) {
            final angle = ((index * 360 / totalDots) - 90) * (pi / 180);
            final double distance = size / 2 - 15;
            return index == ((progress * totalDots).ceil()-1)
                ? buildPositionedDot(distance, angle)
                : const SizedBox();
          },
        ),
      ),
    );
  }

  Positioned buildPositionedDot(double distance, double angle) {
    return Positioned(
      left: (size / 2) + distance * cos(angle) - dotSize / 2,
      top: (size / 2) + distance * sin(angle) - dotSize / 2,
      child: Container(
        width: dotSize,
        height: dotSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}
