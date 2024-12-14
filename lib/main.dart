import 'package:flutter/material.dart';

void main() {
  runApp(const CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove the debug banner
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[50], // Light background color
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87), // Text color
        ),
      ),
      home: const CurrencyConverterHome(),
    );
  }
}

class CurrencyConverterHome extends StatefulWidget {
  const CurrencyConverterHome({super.key});

  @override
  State<CurrencyConverterHome> createState() => _CurrencyConverterHomeState();
}

class _CurrencyConverterHomeState extends State<CurrencyConverterHome> {
  String? _fromCurrency;
  String? _toCurrency;
  double _amount = 0.0;
  String _result = '';

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'INR'];

  void _convertCurrency() {
    // Mock conversion rates
    double conversionRate = 1.0;

    if (_fromCurrency == 'USD' && _toCurrency == 'EUR') {
      conversionRate = 0.85;
    } else if (_fromCurrency == 'EUR' && _toCurrency == 'USD') {
      conversionRate = 1.18;
    } else if (_fromCurrency == 'GBP' && _toCurrency == 'USD') {
      conversionRate = 1.39;
    } else if (_fromCurrency == 'INR' && _toCurrency == 'USD') {
      conversionRate = 0.013;
    }

    setState(() {
      _result = (_amount * conversionRate).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.blueAccent, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              hint: const Text('From Currency'),
              value: _fromCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _fromCurrency = newValue;
                });
              },
              items: _currencies.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10), // Spacing between dropdowns
            DropdownButton<String>(
              hint: const Text('To Currency'),
              value: _toCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _toCurrency = newValue;
                });
              },
              items: _currencies.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
                height: 10), // Spacing between dropdowns and text field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white, // TextField background color
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fromCurrency != null && _toCurrency != null
                  ? _convertCurrency
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button color
              ),
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result.isNotEmpty
                  ? 'Converted Amount: $_result $_toCurrency'
                  : '',
              style: const TextStyle(
                  fontSize: 20, color: Colors.black87), // Result text color
            ),
          ],
        ),
      ),
    );
  }
}
