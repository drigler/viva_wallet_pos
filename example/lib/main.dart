import 'package:flutter/material.dart';
import 'package:viva_wallet_pos/viva_wallet_pos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pos = VivaWalletPos.instance;

  String _message = 'Select action';
  Color _color = Colors.green;

  @override
  void initState() {
    super.initState();
  }

  void _resultMessage(String message, {bool error = false}) {
    setState(() {
      _message = message;
      _color = error ? Colors.red : Colors.green;
    });
  }

  void _activatePos() async {
    try {
      ActivationResponse response =
          await _pos.activatePos(apikey: 'API KEY', apiSecret: 'API SECREET');
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _sale() async {
    try {
      TransactionResponse response = await _pos.sale(
        clientTransactionId: 'Invoice 1234',
        amount: 10.00,
        showRating: false,
        showReceipt: false,
        showTransactionResult: false,
      );
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _cancel() async {
    try {
      TransactionResponse response = await _pos.cancel(
        amount: 10.00,
        showRating: false,
        showReceipt: false,
        showTransactionResult: false,
      );
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _abort() async {
    try {
      AbortResponse response = await _pos.abort();
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _setMode() async {
    try {
      SetModeResponse response = await _pos.setMode(
        mode: ApplicationMode.attended,
        pin: '1234',
      );
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _setPrintingSettings() async {
    try {
      SetPrintingSettingsResponse response = await _pos.setPrintingSettings(
        businessDescriptionEnabled: true,
        businessDescriptionType: BusinessDescriptionType.storeName,
      );
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  void _sendLogs() async {
    try {
      SendLogsResponse response = await _pos.sendLogs();
      _resultMessage(response.message);
    } catch (e) {
      _resultMessage(e.toString(), error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VW Pos Plugin example'),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 80,
              color: _color,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(_message),
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Activate POS', style: TextStyle(fontSize: 18)),
              onPressed: () async {
                _activatePos();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Sale 10.00', style: TextStyle(fontSize: 18)),
              onPressed: () {
                _sale();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Cancel - refund 10.00',
                  style: TextStyle(fontSize: 18)),
              onPressed: () {
                _cancel();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child:
                  const Text('Abort request', style: TextStyle(fontSize: 18)),
              onPressed: () {
                _abort();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Set Mode', style: TextStyle(fontSize: 18)),
              onPressed: () {
                _setMode();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Send logs', style: TextStyle(fontSize: 18)),
              onPressed: () {
                _sendLogs();
              },
            ),
          ),
          Container(
            height: 70,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: const Text('Set printing settings',
                  style: TextStyle(fontSize: 18)),
              onPressed: () {
                _setPrintingSettings();
              },
            ),
          ),
        ]),
      ),
    );
  }
}
