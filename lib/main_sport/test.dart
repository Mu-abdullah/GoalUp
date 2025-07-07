import 'package:flutter/material.dart';
import 'package:arabic_roman_conv/arabic_roman_conv.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key, required this.title});

  final String title;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _text = '';
  final ArabicRomanConv romanizationService = ArabicRomanConv();
  void _updateText(String text) {
    setState(() {
      _text = romanizationService.romanized(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: _updateText,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Arabic text',
                ),
              ),
            ),
            Text(_text, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
