import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_practical/providers/question_three_provider.dart';
import 'package:progress_practical/utils/countries_constants.dart';
import 'package:provider/provider.dart';

import '../common_widgets/custom_circle_progress.dart';
import '../providers/question_one_provider.dart';
import '../utils/color_constants.dart';
import '../utils/preference_manager.dart';
import '../utils/strings.dart';

class QuestionThreePage extends StatefulWidget {
  QuestionThreePage({super.key});

  @override
  State<QuestionThreePage> createState() => _QuestionThreePageState();
}

class _QuestionThreePageState extends State<QuestionThreePage> {
  TextTheme? textTheme;
  List<dynamic> countries = [];
  List<dynamic> backupCountries = [];
  final TextEditingController controller = TextEditingController();
  final TextEditingController controllerSearch = TextEditingController();
  QuestionThreeProvider? questionThreeProvider;

  Size? size;
  int step = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      questionThreeProvider =
          Provider.of<QuestionThreeProvider>(context, listen: false);
    });
    countries = CountriesConstants.countries.map((e) {
      if (e['name'] != null) {
        return e["name"]["common"];
      } else {
        return "";
      }
    }).toList();
    backupCountries = countries;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.information),
        actions: [TextButton(onPressed: null, child: Text(Strings.skip))],
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
        child: Consumer<QuestionThreeProvider>(
            builder: (_, provider, child) {
              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  buildTopProgress(),
                  buildTextField(context),
                  const Spacer(),
                  if (provider.selectedCountry.isNotEmpty)
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
              );
            }
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
        CustomCircleProgress(size: size!.width / 2.3, progress: 66),
      ],
    );
  }

  Widget buildTextField(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showCountryDialogues();
      },
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            hintText: Strings.country,
            labelText: Strings.country,
            labelStyle: const TextStyle(color: ColorConstants.placeHolderColor),
            focusColor: ColorConstants.primaryColor,
            suffixIcon: const Icon(Icons.arrow_drop_down,
                color: ColorConstants.secondaryColor),
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
            PreferenceManager.instance.setCountry(questionThreeProvider?.selectedCountry ?? "");
            PreferenceManager.instance.setStep(3);
            Navigator.of(context).pushNamed(RouteConstants.congratsPage);
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

  void showCountryDialogues() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: ColorConstants.backgroundColor,
              shadowColor: Colors.grey,
              elevation: 2,
              title: Center(
                  child: Text(
                'Country',
                style: textTheme?.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.primaryColor),
              )),
              content: setupAlertDialogContainer(setState),
            );
          });
        });
  }

  Widget setupAlertDialogContainer(StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildSearchField(setState),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: countries.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title:
                        Text(countries[index], style: textTheme?.displayMedium),
                    onTap: () {
                      setState(() {
                        controller.text = countries[index];
                        questionThreeProvider
                            ?.setSelectedCountry(countries[index]);
                        Navigator.of(context).pop();
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField buildSearchField(StateSetter setState) {
    return TextField(
        controller: controllerSearch,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: Strings.search,
          labelText: Strings.search,
          labelStyle: const TextStyle(color: ColorConstants.placeHolderColor),
          focusColor: ColorConstants.primaryColor,
          prefixIcon: const Icon(
            Icons.search,
            color: ColorConstants.secondaryColor,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onChanged: (value) {
          setState(() {
            countries = backupCountries
                .where((element) =>
                    element.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        });
  }
  @override
  void dispose() {
    questionThreeProvider?.selectedCountry = '';
    controller.clear();
    super.dispose();
  }
  Future<void> checkSteps() async {
    step = await PreferenceManager.instance.getStep();
  }
}
