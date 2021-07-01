import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_app/widgets/dictionary.dart';

import 'models/definitions.dart';

import 'widgets/scores_column.dart';
import 'models/scores.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Definitions(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Game(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: MyHomePage(title: 'Scrabble Dictionary'),
        // actions: [],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Game game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
          // ScoreColumn(game.allPlayers[0])
          Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var player in game.allPlayers)
                  Expanded(child: ScoreColumn(player.name)),
                // Dictionary()
              ],
            ),
          ),
          Dictionary()
        ],
      ),
      // )
      //Dictionary(),
    ); // This trailing comma makes auto-formatting nicer for build methods
  }
}
