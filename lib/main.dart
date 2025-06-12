import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('PHP Data Receiver')),
        body: const DataDisplayWidget(),
      ),
    );
  }
}

class DataDisplayWidget extends StatefulWidget {
  const DataDisplayWidget({super.key});

  @override
  State<DataDisplayWidget> createState() => _DataDisplayWidgetState();
}

class _DataDisplayWidgetState extends State<DataDisplayWidget> {
  String _displayText = "Waiting for data...";
  Map<String, dynamic>? _receivedData;

  @override
  void initState() {
    super.initState();
    _requestLatestData();
  }

  void _requestLatestData() {
    final chrome = js.context['chrome'];
    if (chrome != null) {
      final runtime = chrome['runtime'];
      runtime.callMethod('sendMessage', [
        "get_latest_data",
        js.allowInterop((response) {
          if (response != null) {
            final jsonString = js.context['JSON'].callMethod('stringify', [
              response,
            ]);
            final parsedData = json.decode(jsonString);
            setState(() {
              _receivedData = Map<String, dynamic>.from(parsedData);
              _displayText = _receivedData?['content'] ?? "No content received";
            });
          }
        }),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_displayText, style: const TextStyle(fontSize: 20)),
          if (_receivedData != null) ...[
            const SizedBox(height: 20),
            Text('Title: ${_receivedData!['title']}'),
            Text('Time: ${_receivedData!['timestamp']}'),
            ElevatedButton(
              onPressed: () {
                html.window.print();
              },
              child: Text('Print'),
            ),
          ],
        ],
      ),
    );
  }
}
