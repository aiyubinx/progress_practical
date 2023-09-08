import 'package:flutter/material.dart';

import '../common_widgets/custom_circle_progress.dart';
import '../utils/color_constants.dart';
import '../utils/preference_manager.dart';
import '../utils/strings.dart';
import '../utils/utils.dart';

class QuestionTwoPage extends StatefulWidget {
  const QuestionTwoPage({super.key});

  @override
  State<QuestionTwoPage> createState() => _QuestionTwoPageState();
}

class _QuestionTwoPageState extends State<QuestionTwoPage> {
  TextTheme? textTheme;
  final TextEditingController controller = TextEditingController();
  Size? size;
  int step = 0;

  @override
  void initState() {
    super.initState();
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              buildTopProgress(),
              buildTextField(context),
              const Spacer(),
              if (controller.text.isNotEmpty)
                Center(
                  child: Row(
                    children: [
                      buildNextButton(context, isPrev: true),
                      const SizedBox(
                        width: 10,
                      ),
                      buildNextButton(context),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopProgress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Text(Strings.documentDetails,
                maxLines: 2,
                style: textTheme?.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.normal))),
        CustomCircleProgress(size: size!.width / 2.3, progress: 33),
      ],
    );
  }

  Widget buildTextField(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var res = await Navigator.of(context)
            .pushNamed(RouteConstants.enterNumberPage);
        if (res is String) {
          controller.text = res;
        }
      },
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        maxLength: 10,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: Strings.number,
            labelText: Strings.number,
            labelStyle: const TextStyle(color: ColorConstants.placeHolderColor),
            focusColor: ColorConstants.primaryColor,
            enabled: false),
      ),
    );
  }

  Widget buildNextButton(BuildContext context, {bool isPrev = false}) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: isPrev
              ? ColorConstants.secondaryColor
              : ColorConstants.primaryColor,
          side: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        onPressed: () {
          if (isPrev) {
            Navigator.of(context).pop();
          } else {
            PreferenceManager.instance.setNumber(controller.text);
            PreferenceManager.instance.setStep(2);
            Navigator.of(context).pushNamed(RouteConstants.questionThreePage);
          }
        },
        child: Text(
          isPrev ? Strings.prev : Strings.next,
          style: textTheme?.bodyLarge?.copyWith(
              fontSize: 16,
              color: ColorConstants.textWhiteColor,
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
  Future<void> checkSteps() async {
    step = await PreferenceManager.instance.getStep();
  }
}
