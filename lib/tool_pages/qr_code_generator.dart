/* By Abdullah As-Sadeed */

// import 'package:bitscoper_cyber_toolbox/main.dart';
// import 'package:bitscoper_cyber_toolbox/message_dialog.dart';
import 'package:bitscoper_cyber_toolbox/commons/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});

  @override
  QRCodeGeneratorPageState createState() => QRCodeGeneratorPageState();
}

class QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _stringEditingController =
      TextEditingController();
  final TextEditingController _paddingEditingController = TextEditingController(
    text: '16',
  );

  int _version = QrVersions.auto;
  int _errorCorrectionLevel = QrErrorCorrectLevel.H;
  QrEyeShape _eyeShape = QrEyeShape.square;
  QrDataModuleShape _dataModuleShape = QrDataModuleShape.square;
  Color _eyeColor = Colors.black;
  Color _dataModuleColor = Colors.black;
  Color _backgroundColor = Colors.white;
  bool _gapless = false;
  final String _semanticsLabel = 'Generated QR Code';

  void pickColor(
    BuildContext context,
    Color currentColor,
    Function(Color) onColorChanged,
  ) {
    Color pickerColor = currentColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(navigatorKey.currentContext!)!.color_selection,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
            ),
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: Text(
                  AppLocalizations.of(navigatorKey.currentContext!)!.select,
                ),
                onPressed: () {
                  onColorChanged(pickerColor);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NumberFormat numberFormat = NumberFormat(
      '#',
      AppLocalizations.of(navigatorKey.currentContext!)!.localeName,
    );

    return Scaffold(
      appBar: ApplicationToolBar(
        title: AppLocalizations.of(
          navigatorKey.currentContext!,
        )!.qr_code_generator,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _stringEditingController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(
                    navigatorKey.currentContext!,
                  )!.a_multiline_string,
                  hintText: AppLocalizations.of(
                    navigatorKey.currentContext!,
                  )!.abdullah_as_sadeed,
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
                onChanged: (String value) {
                  if (_formKey.currentState!.validate()) {
                    setState(() {});
                  }
                },
                onFieldSubmitted: (String value) {
                  if (_formKey.currentState!.validate()) {
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.version,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: QrVersions.auto,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.automatic,
                        ),
                      ),
                      ...List.generate(40, (index) => index + 1).map(
                        (qrVersion) => DropdownMenuItem(
                          value: qrVersion,
                          child: Text(numberFormat.format(qrVersion)),
                        ),
                      ),
                    ],
                    initialValue: _version,
                    onChanged: (int? value) {
                      setState(() {
                        _version = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.error_correction_level,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: QrErrorCorrectLevel.H,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.high,
                        ),
                      ),
                      DropdownMenuItem(
                        value: QrErrorCorrectLevel.Q,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.quartile,
                        ),
                      ),
                      DropdownMenuItem(
                        value: QrErrorCorrectLevel.M,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.medium,
                        ),
                      ),
                      DropdownMenuItem(
                        value: QrErrorCorrectLevel.L,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.low,
                        ),
                      ),
                    ],
                    initialValue: _errorCorrectionLevel,
                    onChanged: (int? value) {
                      setState(() {
                        _errorCorrectionLevel = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.eye_shape,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: QrEyeShape.square,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.square,
                        ),
                      ),
                      DropdownMenuItem(
                        value: QrEyeShape.circle,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.circle,
                        ),
                      ),
                    ],
                    initialValue: _eyeShape,
                    onChanged: (QrEyeShape? value) {
                      setState(() {
                        _eyeShape = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.data_module_shape,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: QrDataModuleShape.square,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.square,
                        ),
                      ),
                      DropdownMenuItem(
                        value: QrDataModuleShape.circle,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.circle,
                        ),
                      ),
                    ],
                    initialValue: _dataModuleShape,
                    onChanged: (QrDataModuleShape? value) {
                      setState(() {
                        _dataModuleShape = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text(
              AppLocalizations.of(navigatorKey.currentContext!)!.colors,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      pickColor(context, _eyeColor, (Color color) {
                        setState(() {
                          _eyeColor = color;
                        });
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                          color: _eyeColor,
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.eye,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: useWhiteForeground(_eyeColor)
                                  ? Colors.white
                                  : DefaultTextStyle.of(context).style.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      pickColor(context, _dataModuleColor, (Color color) {
                        setState(() {
                          _dataModuleColor = color;
                        });
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                          color: _dataModuleColor,
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.data,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: useWhiteForeground(_dataModuleColor)
                                  ? Colors.white
                                  : DefaultTextStyle.of(context).style.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      pickColor(context, _backgroundColor, (Color color) {
                        setState(() {
                          _backgroundColor = color;
                        });
                      });
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                          color: _backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.background,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: useWhiteForeground(_backgroundColor)
                                  ? Colors.white
                                  : DefaultTextStyle.of(context).style.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.gapless,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: false,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.false_,
                        ),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.true_,
                        ),
                      ),
                    ],
                    initialValue: _gapless,
                    onChanged: (Object? value) {
                      setState(() {
                        _gapless = value as bool;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _paddingEditingController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.padding,
                      hintText: _paddingEditingController.text,
                    ),
                    showCursor: true,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.enter_padding;
                      } else if (double.tryParse(value) == null) {
                        return AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.enter_a_number;
                      } else if (double.tryParse(value)! < 1.toDouble()) {
                        return AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.enter_a_positive_number;
                      }

                      return null;
                    },
                    onChanged: (String value) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                    onFieldSubmitted: (String value) {
                      if (_formKey.currentState!.validate()) {
                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 96,
                bottom: 80, // 80 = (96 - 16)
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (_stringEditingController.text.isNotEmpty)
                      QrImageView(
                        version: _version,
                        errorCorrectionLevel: _errorCorrectionLevel,
                        eyeStyle: QrEyeStyle(
                          eyeShape: _eyeShape,
                          color: _eyeColor,
                        ),
                        dataModuleStyle: QrDataModuleStyle(
                          dataModuleShape: _dataModuleShape,
                          color: _dataModuleColor,
                        ),
                        backgroundColor: _backgroundColor,
                        gapless: _gapless,
                        semanticsLabel: _semanticsLabel,
                        data: _stringEditingController.text,
                        padding: EdgeInsets.all(
                          double.tryParse(
                            _paddingEditingController.text.trim(),
                          )!,
                        ),
                        size: MediaQuery.of(context).size.width * 0.5,
                      )
                    else
                      Text(
                        AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.start_typing_a_string_to_generate_qr_code,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  // TODO: Add EmbeddedImage
  // TODO: Add Save Button
