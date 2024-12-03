import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

Future<Map<String, String>> getRandomQuote() async {
  String data = await rootBundle.loadString('assets/quote.json');

  var jsonData = json.decode(data);

  List<dynamic> quotes = jsonData['quotes'];

  Random random = Random();
  Map<String, String> randomQuote = Map<String, String>.from(quotes[random.nextInt(quotes.length)]);

  return randomQuote;
}