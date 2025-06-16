/* By Abdullah As-Sadeed */

import 'dart:async';
import 'package:bitscoper_cyber_toolbox/application_toolbar.dart';
import 'package:bitscoper_cyber_toolbox/l10n/app_localizations.dart';
import 'package:bitscoper_cyber_toolbox/main.dart';
import 'package:bitscoper_cyber_toolbox/message_dialog.dart';
import 'package:flutter_traceroute/flutter_traceroute_platform_interface.dart';
import 'package:flutter_traceroute/flutter_traceroute.dart';
import 'package:flutter/material.dart';

class RouteTracerPage extends StatefulWidget {
  const RouteTracerPage({super.key});

  @override
  RouteTracerPageState createState() => RouteTracerPageState();
}

class RouteTracerPageState extends State<RouteTracerPage> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _hostEditingController = TextEditingController();

  final FlutterTraceroute _routeTracer = FlutterTraceroute();
  StreamSubscription? _traceSubscription;

  bool _isTracing = false;
  List<TracerouteStep> _traceResults = [];

  void _onTrace() {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isTracing = true;
          _traceResults = [];
        });

        final TracerouteArgs arguments = TracerouteArgs(
          host: _hostEditingController.text.trim(),
          ttl: TracerouteArgs.ttlDefault,
        );

        _traceSubscription = _routeTracer.trace(arguments).listen((
          TracerouteStep event,
        ) {
          setState(() {
            _traceResults = List<TracerouteStep>.from(_traceResults)
              ..add(event);
          });
        });
      } catch (error) {
        showMessageDialog(
          AppLocalizations.of(navigatorKey.currentContext!)!.error,
          error.toString(),
        );
      } finally {}
    }
  }

  void _onStop() {
    try {
      _routeTracer.stopTrace();
      _traceSubscription?.cancel();
    } catch (error) {
      showMessageDialog(
        AppLocalizations.of(navigatorKey.currentContext!)!.error,
        error.toString(),
      );
    } finally {
      setState(() {
        _isTracing = false;
      });
    }
  }

  @override
  void dispose() {
    _hostEditingController.dispose();
    _routeTracer.stopTrace();
    _traceSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolBar(
        title: AppLocalizations.of(navigatorKey.currentContext!)!.route_tracer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _hostEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(
                    navigatorKey.currentContext!,
                  )!.a_host_or_ip_address,
                  hintText: 'bitscoper.dev',
                ),
                maxLines: 1,
                showCursor: true,
                onChanged: (String value) {},
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(
                      navigatorKey.currentContext!,
                    )!.enter_a_host_or_ip_address;
                  }

                  return null;
                },
                onFieldSubmitted: (String value) {
                  _onTrace();
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isTracing ? null : _onTrace,
                    child: Text(
                      AppLocalizations.of(navigatorKey.currentContext!)!.trace,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isTracing ? _onStop : null,
                    child: Text(
                      AppLocalizations.of(navigatorKey.currentContext!)!.stop,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final result in _traceResults)
                    Text(
                      result.toString(),
                      style: TextStyle(
                        fontWeight: result is TracerouteStepFinished
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  if (_isTracing)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 16.0),
                        const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
