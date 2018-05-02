/**
 * Vicky Mohammad
 * This is a name generator app from the flutter doc
 * https://flutter.io/get-started/codelab/
 */

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String titleBar = 'Startup Name Generator';
    RandomWords newRanWord = new RandomWords();
    return new MaterialApp(
      title: titleBar,
      home: new RandomWords(),
      theme: new ThemeData(primaryColor: Colors.white)
    );
  }//end build
}//end myApp

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug paint" (press "p" in the console where you ran
          // "flutter run", or select "Toggle Debug Paint" from the Flutter tool
          // window in IntelliJ) to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/////////////////////// testing my custom classes

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordsState();
}//end random words class

class RandomWordsState extends State<RandomWords>{
  // isntance var
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  // build suggestion method
  Widget _buildSuggestion() {
    //create a divider 
    final edgePadding = EdgeInsets.all(16.0);
    Widget createDivider(BuildContext context, int i){
      if(i.isOdd){
        return new Divider();
      } //end if
      final index = i ~/ 2;
      if(index >= _suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }//end if
      return _buildRow(_suggestions[index]);
    }//end func

    // return the widget
    return new ListView.builder(
      padding: edgePadding,
      itemBuilder: createDivider
    );//end return
  }//end widget

  // build row method
  Widget _buildRow(WordPair pair) {
    // dec vars
    final newTitle = new Text(pair.asPascalCase, style: _biggerFont);
    final alreadySaved = _saved.contains(pair); // return bool
    //return red heart icon or empty heart
    Icon getHeartIcon(){
      // set fav solid or border 
      var iconType = Icons.favorite;
      var iconColor = Colors.red;
      if(alreadySaved == false){
        iconType = Icons.favorite_border;
        iconColor = null;
      }//end if
      return new Icon(iconType, color: iconColor);
    }//end func
    
    // !!!!!!!! im confused with the syntax !!!!!!!!!!
    void whenHeartIsPressed(){
      setState(() {//this one syntax that has (){}
        if(alreadySaved == true){
          _saved.remove(pair);
        }else{
          _saved.add(pair);
        }//end if
      });
    }//end funcc

    // return the widget
    return new ListTile(
      title: newTitle, 
      trailing: getHeartIcon(),
      onTap: (){whenHeartIsPressed();},
    );
  }//end widget

  @override
  Widget build(BuildContext context){
    // title name
    final titleName = new Text('Startup Name Generator');

    // func which for nav a page
    void _pushSaved() {
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context) {
            final tiles = _saved.map(
              (pair) {
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },//end pair
            );//end builder
            final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )//end divide tiles
              .toList();

              // return a new page
              return new Scaffold(
                appBar: new AppBar(
                  title: new Text('Saved Suggestions'),
                ),
                body: new ListView(children: divided),
              );

          },//end builder
        ),
      );//end nav context
    }//end func

    // button
    IconButton button = new IconButton(
      icon: new Icon(Icons.list), 
      onPressed: _pushSaved,
    ); 
    final newBar = new AppBar(title: titleName, actions: <Widget>[button]);
    
    // return the widget
    return new Scaffold(appBar: newBar, body: _buildSuggestion());
  }//end widget
}//end random state class