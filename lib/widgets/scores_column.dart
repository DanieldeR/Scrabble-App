import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/scores.dart';

class ScoreColumn extends StatefulWidget {
  final String playerId;

  ScoreColumn(this.playerId);

  @override
  _ScoreColumnState createState() => _ScoreColumnState();
}

class _ScoreColumnState extends State<ScoreColumn> {
  int _enteredPoints = 0;
  final _formKey = GlobalKey<FormState>();

  void updateScore(BuildContext context) {
    if (_enteredPoints > 0) {
      Provider.of<Game>(context, listen: false)
          .addPoints(_enteredPoints, widget.playerId);
      _formKey.currentState.reset();
      _enteredPoints = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final player = game.getPlayer(widget.playerId);
    final _points = player.getPlayerPoints();

    print(_points);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${player.name}: ${player.getScore}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Center(
                  child: Text(
                    player.getPlayerPoints()[i].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              itemCount: player.getPlayerPoints().length,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 50,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: ''),
                      onChanged: (value) => _enteredPoints = int.parse(value),
                      onFieldSubmitted: (_) => updateScore(context),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      child: Text('Enter'),
                      onPressed: () => updateScore(context),
                    ),
                  ),
                ],
              ),
            ),
            // Text(player.getScore)
          ],
        ),
      ),
    );
  }
}
