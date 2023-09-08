import 'package:flutter/material.dart';

import '../utils/color_constants.dart';
import '../utils/font_constants.dart';
import '../utils/strings.dart';

class EnterNumberPage extends StatefulWidget {
  const EnterNumberPage({super.key});

  @override
  State<EnterNumberPage> createState() => _EnterNumberPageState();
}

class _EnterNumberPageState extends State<EnterNumberPage> {
  TextEditingController controller = TextEditingController();
  bool isKeyboardVisible = true;
  TextTheme? textTheme;
  bool _hasTenNumbers = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text.length == 10) {
        setState(() {
          _hasTenNumbers = true;
        });
      } else {
        setState(() {
          _hasTenNumbers = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(Strings.number),
        ),
        body: buildBody(context),
      ),
    );
  }

  buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(context),
            Spacer(),
            if (isKeyboardVisible) buildNextButton(context),
          ],
        ),
      ),
    );
  }

  TextField buildTextField(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      maxLength: 10,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: Strings.number,
        labelText: Strings.number,
        labelStyle: const TextStyle(color: ColorConstants.placeHolderColor),
        focusColor: ColorConstants.primaryColor,
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
        if (MediaQuery.of(context).viewInsets.bottom != 0 &&
            !isKeyboardVisible) {
          setState(() {
            isKeyboardVisible = true;
          });
        } else if (MediaQuery.of(context).viewInsets.bottom == 0 &&
            isKeyboardVisible) {
          setState(() {
            isKeyboardVisible = false;
          });
        }
      },
    );
  }

  Widget buildNextButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: ColorConstants.primaryColor,
          side: const BorderSide(
            color: Colors.transparent,
          ),
          disabledBackgroundColor:
              ColorConstants.primaryColor.withOpacity(_hasTenNumbers ? 1 : 0.5),
          textStyle: TextStyle(
              fontFamily: FontConstants.montserrat,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: ColorConstants.placeHolderColor
                  .withOpacity(_hasTenNumbers ? 1 : 0.1))),
      onPressed: _hasTenNumbers
          ? () {
              print("object :: ${controller.text}");
              Navigator.of(context).pop(controller.text);
            }
          : null,
      child: Text(
        Strings.next,
        style: textTheme?.bodyLarge?.copyWith(
            fontSize: 16,
            color: ColorConstants.textWhiteColor,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
