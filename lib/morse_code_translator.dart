/* By Abdullah As-Sadeed */

import 'package:bitscoper_cyber_toolbox/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:bitscoper_cyber_toolbox/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morse_code_translator/morse_code_translator.dart';

class MorseCodeTranslatorPage extends StatefulWidget {
  const MorseCodeTranslatorPage({super.key});

  @override
  MorseCodeTranslatorPageState createState() => MorseCodeTranslatorPageState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MorseCodeTranslatorPageState extends State<MorseCodeTranslatorPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _stringFormKey = GlobalKey<FormState>(),
      _morseCodeFormKey = GlobalKey<FormState>();
  final TextEditingController _stringEditingController =
          TextEditingController(),
      _morseCodeController = TextEditingController();

  final MorseCode _translator = MorseCode();

  void _encodeString() {
    try {
      setState(() {
        if (_stringFormKey.currentState!.validate()) {
          _morseCodeController.text = _translator.enCode(
            _stringEditingController.text,
          );

          _morseCodeFormKey.currentState!.validate();
        }
      });
    } catch (error) {
      showMessageDialog(
        AppLocalizations.of(navigatorKey.currentContext!)!.error,
        error.toString(),
      );
    }
  }

  void _decodeMorseCode() {
    try {
      setState(() {
        if (_morseCodeFormKey.currentState!.validate()) {
          _stringEditingController.text = _translator.deCode(
            _morseCodeController.text,
          );

          _stringFormKey.currentState!.validate();
        }
      });
    } catch (error) {
      showMessageDialog(
        AppLocalizations.of(navigatorKey.currentContext!)!.error,
        error.toString(),
      );
    }
  }

  @override
  void dispose() {
    _stringEditingController.dispose();
    _morseCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolBar(
        title: AppLocalizations.of(
          navigatorKey.currentContext!,
        )!.morse_code_translator,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Form(
              key: _stringFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _stringEditingController,
                    keyboardType: TextInputType.text,
                    inputFormatters: [UpperCaseTextFormatter()],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.a_string,
                      hintText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.abdullah_as_sadeed.toUpperCase(),
                    ),
                    showCursor: true,
                    maxLines: null,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.enter_a_string;
                      }

                      return null;
                    },
                    onChanged: (String? value) {
                      _encodeString();
                    },
                    onFieldSubmitted: (String value) {
                      _encodeString();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _morseCodeFormKey,
              child: TextFormField(
                controller: _morseCodeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(
                    navigatorKey.currentContext!,
                  )!.morse_code,
                  hintText:
                      '.- -... -.. ..- .-.. .-.. .- .... / .- ... -....- ... .- -.. . . -..',
                ),
                showCursor: true,
                maxLines: null,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(
                      navigatorKey.currentContext!,
                    )!.enter_morse_code;
                  }

                  return null;
                },
                onChanged: (String? value) {
                  _decodeMorseCode();
                },
                onFieldSubmitted: (String value) {
                  _decodeMorseCode();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add Copy Buttons
