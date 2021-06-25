import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Definition {
  final String definition;
  final String word;
  final String root;
  final String points;

  Definition({
    this.definition,
    this.word,
    this.root,
    this.points,
  });
}

class Definitions with ChangeNotifier {
  List<Definition> _definitions = [];

  List<Definition> get items {
    return [..._definitions];
  }

  Future<void> fetchDefitions(String word) async {
    final url = Uri.http('127.0.0.1:8000', 'definition', {'q': word});

    try {
      final response = await http.get(url);

      final decodedDefinitions = json.decode(response.body);
      final List<Definition> loadedDefinitions = [];

      decodedDefinitions.forEach((elem) {
        loadedDefinitions.add(Definition(
          definition: elem['definition'],
          word: elem['word'],
          root: elem['root'],
          points: elem['points'],
        ));
      });

      _definitions = loadedDefinitions;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
