import 'package:flutter/material.dart';
import 'package:progress_practical/common_widgets/custom_circle_progress.dart';
import 'package:progress_practical/providers/question_one_provider.dart';
import 'package:progress_practical/utils/color_constants.dart';
import 'package:progress_practical/utils/preference_manager.dart';
import 'package:provider/provider.dart';

import '../utils/strings.dart';
import '../utils/utils.dart';

class QuestionOnePage extends StatefulWidget {
  QuestionOnePage({super.key});

  @override
  State<QuestionOnePage> createState() => _QuestionOnePageState();
}

class _QuestionOnePageState extends State<QuestionOnePage> {
  TextTheme? textTheme;
  QuestionOneProvider? questionOneProvider;
  Size? size;
  int step = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      questionOneProvider =
          Provider.of<QuestionOneProvider>(context, listen: false);
      checkSteps();
    });

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
        leading: BackButton(
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: [
          TextButton(
              onPressed: step == 0
                  ? null
                  : () {
                      Utils.manageRouting(context, step: step);
                    },
              child: Text(Strings.skip))
        ],
      ),
      body: buildBody(context),
    );
  }

  SafeArea buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Consumer<QuestionOneProvider>(
          builder: (_, provider, child) {
            return Column(
              children: [
                buildTopProgress(),
                buildDropDown(context),
                const Spacer(),
                provider.selectedItem.isNotEmpty
                    ? buildNextButton(context)
                    : SizedBox(),
              ],
            );
          },
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
        CustomCircleProgress(size: size!.width / 2.3, progress: 0),
      ],
    );
  }

  Widget buildDropDown(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the bottom sheet when the TextField is tapped
        _showBottomSheet(context);
      },
      child: TextField(
        controller: questionOneProvider?.controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: Strings.type,
          labelText: Strings.type,
          labelStyle: const TextStyle(color: ColorConstants.placeHolderColor),
          suffixIcon: const Icon(Icons.arrow_drop_down,
              color: ColorConstants.secondaryColor),
          focusColor: ColorConstants.primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        enabled:
            false, // This makes sure the keyboard doesn't pop up when tapped
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: ColorConstants.backgroundColor,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                children: <Widget>[
                  _roundedListTile(
                    title: Strings.passport,
                    onTap: () {
                      questionOneProvider?.setSelectedItem(Strings.passport);
                      Navigator.pop(context);
                    },
                  ),
                  _roundedListTile(
                    title: Strings.nationalCard,
                    onTap: () {
                      questionOneProvider
                          ?.setSelectedItem(Strings.nationalCard);
                      Navigator.pop(context);
                    },
                  ),
                  _roundedListTile(
                    title: 'CANCEL',
                    needBorder: false,
                    onTap: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _roundedListTile(
      {required String title,
      required void Function() onTap,
      bool needBorder = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: needBorder
                  ? ColorConstants.secondaryColor
                  : Colors.transparent)),
      child: ListTile(
        tileColor: ColorConstants.backgroundColor,
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(title,
            style: textTheme?.bodySmall?.copyWith(
                color: needBorder
                    ? ColorConstants.textWhiteColor
                    : ColorConstants.secondaryColor,
                fontWeight: needBorder ? FontWeight.normal : FontWeight.bold),
            textAlign: TextAlign.center),
        onTap: onTap,
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: ColorConstants.primaryColor,
        side: const BorderSide(
          color: Colors.transparent,
        ),
      ),
      onPressed: () {
        PreferenceManager.instance
            .setType(questionOneProvider?.selectedItem ?? "");
        PreferenceManager.instance.setStep(1);
        Navigator.of(context).pushNamed(RouteConstants.questionTwoPage);
      },
      child: Text(
        Strings.next,
        style: textTheme?.bodyLarge?.copyWith(
            fontSize: 16,
            color: ColorConstants.textWhiteColor,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  @override
  void dispose() {
    questionOneProvider?.selectedItem = "";
    super.dispose();
  }

  Future<void> checkSteps() async {
    step = await PreferenceManager.instance.getStep();
  }
}
