import 'package:flutter/material.dart';
import 'package:progress_practical/utils/strings.dart';

abstract class Utils {
  static void manageRouting(BuildContext context, {required step}) {
    switch (step) {
      case 1 :
        Navigator.of(context).pushNamed(RouteConstants.questionTwoPage);
        break;
      case 2 :
        Navigator.of(context).pushNamed(RouteConstants.questionThreePage);
        break;
      case 3 :
      //you can still change the data
        Navigator.of(context).pushNamed(RouteConstants.questionThreePage);
    }
  }

  static int progressBasedOnStep({required step}) {
    switch (step) {
      case 0 :
        return 0;
      case 1 :
        return 33;
      case 2 :
        return 66;
      default :
        return 100;
    }
  }
}