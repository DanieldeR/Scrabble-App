import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Player {
  final String name;
  final String id = DateTime.now().toString();
  final List<int> points;

  Player({
    this.name,
    this.points,
  });

  List<int> getPlayerPoints() {
    return [...points];
  }

  get getName {
    return name;
  }

  get getScore {
    if (points.length > 0) {
      return points.reduce((a, b) => a + b).toString();
    } else {
      return '0';
    }
  }
}

class Game with ChangeNotifier {
  List<Player> players = [
    Player(name: 'Steve', points: []),
    Player(name: 'Bob', points: []),
    Player(name: 'Carl', points: []),
  ];

  Game(
      // this.players,
      );

  get allPlayers {
    return [...players];
  }

  Player getPlayer(String id) {
    return players.firstWhere((player) => player.name == id);
  }

  void addPoints(int point, String id) {
    final player = players.firstWhere((prod) => prod.name == id);
    final playerIndex = players.indexWhere((prod) => prod.name == id);

    List<int> currentPoints = player.getPlayerPoints().toList();
    currentPoints.add(point);

    final _newPlayer = new Player(
      name: player.name,
      points: currentPoints,
    );

    players[playerIndex] = _newPlayer;

    notifyListeners();
  }

  List<int> getPoints(String id) {
    return players.firstWhere((player) => player.name == id).getPlayerPoints();
  }
}
