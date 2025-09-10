/* By Abdullah As-Sadeed */

import 'dart:async';
import 'package:bitscoper_cyber_toolbox/commons/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/commons/copy_to_clipboard.dart';
import 'package:bitscoper_cyber_toolbox/commons/message_dialog.dart';
import 'package:bitscoper_cyber_toolbox/commons/notification_sender.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:dnsolve/dnsolve.dart';
import 'package:flutter/material.dart';

class DNSRecordRetrieverPage extends StatefulWidget {
  const DNSRecordRetrieverPage({super.key});

  @override
  DNSRecordRetrieverPageState createState() => DNSRecordRetrieverPageState();
}

class DNSRecord {
  final String type, record;

  DNSRecord(this.type, this.record);
}

class DNSRecordRetrieverPageState extends State<DNSRecordRetrieverPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hostEditingController = TextEditingController();
  late StreamController<String> _recordTypeController;

  DNSProvider _recordProvider = DNSProvider.cloudflare;
  bool _isRetrieving = false;
  List<DNSRecord> _records = [];

  Future<void> retrieveDNSRecord() async {
    if (_formKey.currentState!.validate()) {
      try {
        _recordTypeController = StreamController<String>.broadcast();

        setState(() {
          _isRetrieving = true;
          _records = [];
        });

        for (RecordType recordType in RecordType.values) {
          _recordTypeController.add(
            recordType.toString().replaceFirst('RecordType.', '').toUpperCase(),
          );

          final ResolveResponse response = await DNSolve().lookup(
            _hostEditingController.text.trim(),
            dnsSec: true,
            type: recordType,
            provider: _recordProvider,
          );

          if (response.answer!.records != null) {
            for (final record in response.answer!.records!) {
              _records.add(
                DNSRecord(
                  recordType.toString().split('.').last.toUpperCase(),
                  record.toBind,
                ),
              );
            }
          }
        }

        await sendNotification(
          title: AppLocalizations.of(
            navigatorKey.currentContext!,
          )!.dns_record_retriever,
          subtitle: AppLocalizations.of(
            navigatorKey.currentContext!,
          )!.bitscoper_cyber_toolbox,
          body: AppLocalizations.of(navigatorKey.currentContext!)!.retrieved,
          payload: "DNS_Record_Retriever",
        );
      } catch (error) {
        showMessageDialog(
          AppLocalizations.of(navigatorKey.currentContext!)!.error,
          error.toString(),
        );
      } finally {
        setState(() {
          _recordTypeController.close();
          _recordTypeController = StreamController<String>();

          _isRetrieving = false;
        });
      }
    }
  }

  String _capitalize(String string) {
    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  void dispose() {
    _hostEditingController.dispose();
    _recordTypeController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolBar(
        title: AppLocalizations.of(
          navigatorKey.currentContext!,
        )!.dns_record_retriever,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _hostEditingController,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.a_host_or_ip_address,
                      hintText: 'bitscoper.dev',
                    ),
                    showCursor: true,
                    maxLines: 1,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.enter_a_host_or_ip_address;
                      }

                      return null;
                    },
                    onChanged: (String value) {},
                    onFieldSubmitted: (String value) {
                      retrieveDNSRecord();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<DNSProvider>(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.dns_provider,
                    ),
                    initialValue: _recordProvider,
                    onChanged: (DNSProvider? newValue) {
                      setState(() {
                        _recordProvider = newValue!;
                      });
                    },
                    items: DNSProvider.values
                        .map<DropdownMenuItem<DNSProvider>>((
                          DNSProvider value,
                        ) {
                          return DropdownMenuItem<DNSProvider>(
                            value: value,
                            child: Text(
                              _capitalize(value.toString().split('.').last),
                            ),
                          );
                        })
                        .toList(),
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _isRetrieving
                              ? null
                              : () {
                                  retrieveDNSRecord();
                                },
                          child: Text(
                            AppLocalizations.of(
                              navigatorKey.currentContext!,
                            )!.retrieve,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _isRetrieving
                              ? () {
                                  setState(() {
                                    _isRetrieving = false;
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
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            if (_isRetrieving)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder<String>(
                      stream: _recordTypeController.stream,
                      builder:
                          (
                            BuildContext context,
                            AsyncSnapshot<String> snapshot,
                          ) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text(
                                AppLocalizations.of(
                                  navigatorKey.currentContext!,
                                )!.wait,
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              return Text(
                                '${AppLocalizations.of(navigatorKey.currentContext!)!.retrieving} ${snapshot.data} ${AppLocalizations.of(navigatorKey.currentContext!)!.records}',
                              );
                            } else if (snapshot.hasError) {
                              showMessageDialog(
                                AppLocalizations.of(
                                  navigatorKey.currentContext!,
                                )!.error,
                                snapshot.toString(),
                              );

                              return const SizedBox();
                            } else {
                              return const SizedBox();
                            }
                          },
                    ),
                    const SizedBox(height: 16.0),
                    const CircularProgressIndicator(),
                  ],
                ),
              )
            else
              _records.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(
                          navigatorKey.currentContext!,
                        )!.it_takes_time_to_retrieve_all_possible_types_of_forward_and_reverse_records,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _records.map((record) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Card(
                            child: ListTile(
                              title: Text(record.type),
                              subtitle: Text(record.record),
                              trailing: IconButton(
                                icon: const Icon(Icons.copy_rounded),
                                onPressed: () {
                                  copyToClipboard(
                                    '${record.type} ${AppLocalizations.of(navigatorKey.currentContext!)!.dns_record}',
                                    record.record,
                                  );
                                },
                                tooltip: 'Copy to Clipboard',
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add Bulk Save Button
