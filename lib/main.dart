import 'dart:async';

import 'package:flutter/material.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;
  Widget _buildItem(Article article) {
    return new Padding(
      key: Key(article.text),
      padding: const EdgeInsets.all(8.0),
      child: new ExpansionTile(
        title: new Text(
          article.text,
          style: new TextStyle(fontSize: 24.0),
        ),
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Text("${article.commentsCount} comments"),
              new IconButton(
                icon: new Icon(Icons.launch),
                color: Colors.green,
                onPressed: () async {
                  String fakeUrl = "http://${article.url}";
                  if (await canLaunch(fakeUrl)) {
                    launch(fakeUrl);
                  }
                },
              )
            ],
          )
        ],
//      onTap: () async{
//        String fakeUrl = "http://${article.domain}";
//        if(await canLaunch(fakeUrl)) {
//          launch(fakeUrl);
//        }
//      },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new RefreshIndicator(
        onRefresh: () async{
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
          return;
        },
        child: new ListView(
//        mainAxisAlignment: MainAxisAlignment.center,
            children: _articles.map(_buildItem).toList()),
      ),
    );
  }
}
