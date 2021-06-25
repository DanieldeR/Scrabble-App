import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/definitions.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Scrabble Dictionary'),
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
  String _query = 'search';

  Future<void> _getDefinitions(BuildContext context, String word) async {
    Provider.of<Definitions>(context, listen: false).fetchDefitions(word);
  }

  @override
  Widget build(BuildContext context) {
    final definitions = Provider.of<Definitions>(context).items;

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 400,
          child: Column(
            children: [
              Container(
                height: 90,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Search'),
                        onChanged: (value) => _query = value,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) =>
                            _getDefinitions(context, _query),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextButton(
                          child: Text('Search'),
                          onPressed: () => _getDefinitions(context, _query),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: definitions.isEmpty
                    ? SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (_, i) => Card(
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  definitions[i].points,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('pts'),
                              ],
                            ),
                            title: Text(definitions[i].word),
                            subtitle: Text(definitions[i].definition),
                          ),
                        ), //
                        itemCount: definitions.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods
  }
}
