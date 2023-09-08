import 'package:flutter/material.dart';
import 'package:progress_practical/common_widgets/custom_circle_progress.dart';
import 'package:progress_practical/utils/color_constants.dart';
import '../utils/preference_manager.dart';
import '../utils/strings.dart';
import '../utils/utils.dart';
final GlobalKey<_WelcomePageState> welcomePageKey = GlobalKey<_WelcomePageState>();
class WelcomePage extends StatefulWidget {
  WelcomePage({super.key});


  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextTheme? textTheme;
  int step = 0;
  int progress = 0;
  Size? size;
  void refreshState() {
    checkSteps();
  }
  @override
  void initState() {
    checkSteps();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    checkSteps();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.information),
        actions: [TextButton(onPressed: step == 0 ? null : (){
          Utils.manageRouting(context,step: step);
        }, child: Text(Strings.skip))],
      ),
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
            CustomCircleProgress(size: size!.width / 2, progress: progress),
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
      onPressed: () async {
        PreferenceManager.instance.clearAll();
        var res = await Navigator.of(context).pushNamed(RouteConstants.questionOnePage);
        if (res != null && res == false) {
          checkSteps();
        }
      },
      child: Text(
        Strings.start,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Strings.documentDetails,
              style: textTheme?.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.normal)),
          const SizedBox(
            height: 16,
          ),
          Text(Strings.completeTheNextQuestions),
        ],
      ),
    );
  }

  Future<void> checkSteps() async {
       step = await PreferenceManager.instance.getStep();
       progress = Utils.progressBasedOnStep(step: step);
       print("progress :: $progress");
       setState(() {
       });
  }
}
