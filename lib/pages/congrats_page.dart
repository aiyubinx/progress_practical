import 'package:flutter/material.dart';
import 'package:progress_practical/pages/welcome_page.dart';

import '../common_widgets/custom_circle_progress.dart';
import '../utils/color_constants.dart';
import '../utils/preference_manager.dart';
import '../utils/strings.dart';

class CongratulationsPage extends StatelessWidget {
   CongratulationsPage({super.key});
  TextTheme? textTheme;
  Size? size;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            CustomCircleProgress(size: size!.width / 2, progress: 100),
            buildSpacing(),
            buildCenterInterface(),
            const Spacer(),
            buildStartButton(context)
          ],
        ),
      ),
    );
  }

  OutlinedButton buildStartButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        PreferenceManager.instance.clearAll();
        Navigator.popUntil(context, (route) {
          return route.isFirst;
        });
        welcomePageKey.currentState?.refreshState();
      },
      child: Text(
        Strings.reStart,
        style: textTheme?.bodyLarge?.copyWith(
            fontSize: 16,
            color: ColorConstants.textColor,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  SizedBox buildSpacing() {
    return const SizedBox(
      height: 16,
    );
  }

  Widget buildCenterInterface() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Strings.congratulation, style: textTheme?.bodyLarge?.copyWith(fontWeight: FontWeight.normal)),
          const SizedBox(
            height: 16,
          ),
          Text(Strings.quizPercent),
        ],
      ),
    );
  }
}
