import 'dart:math';

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
    final Player player = players.firstWhere((prod) => prod.name == id);
    final int playerIndex = players.indexWhere((prod) => prod.name == id);

    // Ensure that no player can enter too many points.
    final int currentNumberOfPoints = player.points.length;
    final minNumPoints = players
        .reduce((curr, next) =>
            curr.points.length < next.points.length ? curr : next)
        .points
        .length;

    if (currentNumberOfPoints == minNumPoints) {
      List<int> currentPoints = player.getPlayerPoints().toList()..add(point);
      // currentPoints.add(point);

      final _newPlayer = new Player(
        name: player.name,
        points: currentPoints,
      );

      players[playerIndex] = _newPlayer;

      notifyListeners();
    } else {
      //TODO: Error handling and show a dialog to the user.
      return;
    }
  }

  List<int> getPoints(String id) {
    return players.firstWhere((player) => player.name == id).getPlayerPoints();
  }
}
