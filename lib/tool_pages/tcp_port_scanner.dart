/* By Abdullah As-Sadeed */

import 'dart:async';
import 'package:bitscoper_cyber_toolbox/commons/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/commons/message_dialog.dart';
import 'package:bitscoper_cyber_toolbox/commons/notification_sender.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcp_scanner/tcp_scanner.dart';

class TCPPortScannerPage extends StatefulWidget {
  const TCPPortScannerPage({super.key});

  @override
  TCPPortScannerPageState createState() => TCPPortScannerPageState();
}

class TCPPortScannerPageState extends State<TCPPortScannerPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hostEditingController = TextEditingController();

  final Stopwatch _stopwatch = Stopwatch();

  final List<int> _portList = List.generate(
    65536,
    (int iteration) => iteration,
  );

  bool _isScanning = false;
  List<int> _openPorts = [];
  String _scanInformation = '';

  Future<void> _scanTCPPorts() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isScanning = true;
        });

        _stopwatch.reset();
        _stopwatch.start();

        await TcpScannerTask(
              _hostEditingController.text.trim(),
              _portList,
              shuffle: false,
              parallelism: 64,
            )
            .start()
            .asStream()
            .transform(
              StreamTransformer.fromHandlers(
                handleData: (TcpScannerTaskReport report, EventSink<Object?> sink) {
                  setState(() {
                    _openPorts = report.openPorts.cast<int>();
                    _openPorts.sort();

                    final NumberFormat numberFormat = NumberFormat(
                      '#',
                      AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.localeName,
                    );
                    final DateFormat timeFormat = DateFormat(
                      'HH:mm:ss',
                      AppLocalizations.of(
                        navigatorKey.currentContext!,
                      )!.localeName,
                    );

                    _scanInformation =
                        '${AppLocalizations.of(navigatorKey.currentContext!)!.scanned_ports}: ${numberFormat.format(report.ports.length)}\n${AppLocalizations.of(navigatorKey.currentContext!)!.elapsed_time}: ${timeFormat.format(DateTime.fromMillisecondsSinceEpoch(_stopwatch.elapsedMilliseconds, isUtc: true))}';
                  });

                  sink.add(report);
                },
                handleDone: (EventSink<Object?> sink) async {
                  sink.close();

                  await sendNotification(
                    title: AppLocalizations.of(
                      navigatorKey.currentContext!,
                    )!.tcp_port_scanner,
                    subtitle: AppLocalizations.of(
                      navigatorKey.currentContext!,
                    )!.bitscoper_cyber_toolbox,
                    body: AppLocalizations.of(
                      navigatorKey.currentContext!,
                    )!.scanned,
                    payload: "TCP_Port_Scanner",
                  );
                },
                handleError: (error, stackTrace, sink) {
                  showMessageDialog(
                    AppLocalizations.of(navigatorKey.currentContext!)!.error,
                    error.toString(),
                  );

                  sink.addError(error, stackTrace);

                  sink.close();
                },
              ),
            )
            .toList();
      } catch (error) {
        showMessageDialog(
          AppLocalizations.of(navigatorKey.currentContext!)!.error,
          error.toString(),
        );
      } finally {
        setState(() {
          _isScanning = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _hostEditingController.dispose();

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
        )!.tcp_port_scanner,
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
                      _scanTCPPorts();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Center(
                    child: _isScanning
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () async {
                              await _scanTCPPorts();
                            },
                            child: Text(
                              AppLocalizations.of(
                                navigatorKey.currentContext!,
                              )!.scan,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            if (!_isScanning)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: <Widget>[
                      for (int port in _openPorts)
                        Chip(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            right: 4.0,
                            bottom: 8.0,
                            left: 4.0,
                          ),
                          label: Text(numberFormat.format(port)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(_scanInformation),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

// TODO: Add Save Button
