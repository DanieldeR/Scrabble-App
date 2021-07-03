import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrabble_app/widgets/dictionary.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

  PanelController _panelController = new PanelController();

  void togglePanel() async {
    if (_panelController.isPanelOpen) {
      await _panelController.close();
    } else {
      await _panelController.open();
    }
  }

  Widget textIcon(
      BuildContext context, IconData icon, String text, Function func) {
    return GestureDetector(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 10)),
            Icon(icon),
            Text(text, style: TextStyle(fontSize: 10)),
          ],
        ),
        onTap: () => func());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score Sheet'),
        leading: textIcon(context, Icons.book, 'Dictionary', togglePanel),
        actions: [
          textIcon(context, Icons.star, 'End Game', () {}),
        ],
      ),
      body: SlidingUpPanel(
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        panel: Dictionary(),
        controller: _panelController,
        backdropEnabled: true,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var player in game.allPlayers)
                    Expanded(child: ScoreColumn(player.name)),
                ],
              ),
            ),
          ],
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods
  }
}
