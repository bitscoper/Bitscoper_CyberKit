/* By Abdullah As-Sadeed */

import 'package:bitscoper_cyber_toolbox/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/copy_to_clipboard.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:bitscoper_cyber_toolbox/message_dialog.dart';
import 'package:bitscoper_cyber_toolbox/notification_sender.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class SeriesURICrawlerPage extends StatefulWidget {
  const SeriesURICrawlerPage({super.key});

  @override
  SeriesURICrawlerPageState createState() => SeriesURICrawlerPageState();
}

class SeriesURICrawlerPageState extends State<SeriesURICrawlerPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uriPrefixEditingController =
      TextEditingController();
  final TextEditingController _uriSuffixEditingController =
      TextEditingController();
  final TextEditingController _lowerLimitEditingController =
      TextEditingController();
  final TextEditingController _upperLimitEditingController =
      TextEditingController();

  bool _isCrawling = false;
  Map<String, String> webPages = {};

  Future<void> crawl() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isCrawling = true;
          webPages.clear();
        });

        for (
          int iteration = int.tryParse(
            _lowerLimitEditingController.text.trim(),
          )!;
          iteration <= int.tryParse(_upperLimitEditingController.text.trim())!;
          iteration++
        ) {
          if (!_isCrawling) {
            return;
          }

          String uri =
              '${_uriPrefixEditingController.text.trim()}$iteration${_uriSuffixEditingController.text.trim()}';

          Response response = await http.get(Uri.parse(uri));

          if (response.statusCode == 200) {
            dom.Document document = parser.parse(response.body);

            dom.Element? titleElement = document.querySelector('title');
            String title;
            if (titleElement != null) {
              title = titleElement.text;
            } else {
              title = 'NO TITLE';
            }

            setState(() {
              webPages[uri] = title;
            });
          }
        }

        await sendNotification(
          title: AppLocalizations.of(
            navigatorKey.currentContext!,
          )!.series_uri_crawler,
          subtitle: AppLocalizations.of(
            navigatorKey.currentContext!,
          )!.bitscoper_cyber_toolbox,
          body: AppLocalizations.of(navigatorKey.currentContext!)!.crawled,
          payload: "Series_URI_Crawler",
        );
      } catch (error) {
        showMessageDialog(
          AppLocalizations.of(navigatorKey.currentContext!)!.error,
          error.toString(),
        );
      } finally {
        setState(() {
          _isCrawling = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _uriPrefixEditingController.dispose();
    _uriSuffixEditingController.dispose();
    _lowerLimitEditingController.dispose();
    _upperLimitEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolBar(
        title: AppLocalizations.of(
          navigatorKey.currentContext!,
        )!.series_uri_crawler,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _uriPrefixEditingController,
                          keyboardType: TextInputType.url,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.uri_prefix,
                            hintText: 'https://bitscoper.dev/publication-',
                          ),
                          showCursor: true,
                          maxLines: 1,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_a_uri_prefix;
                            }

                            return null;
                          },
                          onChanged: (String value) {},
                          onFieldSubmitted: (String value) {
                            crawl();
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _uriSuffixEditingController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.uri_suffix,
                            hintText: '.php',
                          ),
                          showCursor: true,
                          maxLines: 1,
                          // validator: (
                          //   String? value,
                          // ) {},
                          onChanged: (String value) {},
                          onFieldSubmitted: (String value) {
                            crawl();
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _lowerLimitEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.lower_limit,
                            hintText: '1',
                          ),
                          showCursor: true,
                          maxLines: 1,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_a_lower_limit;
                            } else if (int.tryParse(value) == null) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_an_integer;
                            } else if (int.tryParse(value)! < 1) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_a_positive_integer;
                            } else if (int.tryParse(value)! >
                                int.tryParse(
                                  _upperLimitEditingController.text.trim(),
                                )!) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.upper_limit_must_be_greater_than_lower_limit;
                            }

                            return null;
                          },
                          onChanged: (String value) {},
                          onFieldSubmitted: (String value) {
                            crawl();
                          },
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: TextFormField(
                          controller: _upperLimitEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.upper_limit,
                            hintText: '100',
                          ),
                          showCursor: true,
                          maxLines: 1,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_an_upper_limit;
                            } else if (int.tryParse(value) == null) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_an_integer;
                            } else if (int.tryParse(value)! < 1) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.enter_a_positive_integer;
                            } else if (int.tryParse(value)! <
                                int.tryParse(
                                  _lowerLimitEditingController.text.trim(),
                                )!) {
                              return AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.upper_limit_must_be_greater_than_lower_limit;
                            }

                            return null;
                          },
                          onChanged: (String value) {},
                          onFieldSubmitted: (String value) {
                            crawl();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _isCrawling
                            ? null
                            : () {
                                crawl();
                              },
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.crawl,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _isCrawling
                            ? () {
                                setState(() {
                                  _isCrawling = false;
                                });
                              }
                            : null,
                        child: Text(
                          AppLocalizations.of(
                            navigatorKey.currentContext!,
                          )!.stop,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Column(
              children: <Widget>[
                for (MapEntry<String, dynamic> entry in webPages.entries)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.link_rounded),
                        title: Text(
                          entry.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy_rounded),
                          onPressed: () {
                            copyToClipBoard(
                              AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.uri,
                              entry.key,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if (_isCrawling)
                  const Column(
                    children: [
                      SizedBox(height: 8.0),
                      Center(child: CircularProgressIndicator()),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add Bulk Save Button
