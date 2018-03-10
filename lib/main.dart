import 'dart:async';
import 'dart:convert';
import 'package:fluttersocial/Publication.dart';
import 'package:fluttersocial/detail_publication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    home: new clsMain(),
  ));
}

final List<Publication> list_publication = new List<Publication>();

class PublicationItem extends StatelessWidget {
  PublicationItem({Key key, @required this.publication})
      : assert(publication != null && publication.isValid),
        super(key: key);
  static final height = 390.0;
  final Publication publication;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle titleStyle =
        theme.textTheme.headline.copyWith(color: Colors.white);
    final TextStyle descriptionStyle = theme.textTheme.subhead;
    return new Container(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: new EdgeInsets.all(10.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                    child: new Image.asset('img/perfil.jpg',
                        height: 40.0, width: 40.0),
                    margin: new EdgeInsets.only(right: 10.0),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "CodigoPanda",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      new Text(
                        "Hi Group Flutter!!!!!",
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0),
                      ),
                      new Text("10/03/2018")
                    ],
                  ),
                ],
              ),
            ),
            new Container(
              child: new Text(publication.detail),
              margin: new EdgeInsets.all(10.0),
            ),
            //aqui empieza lo de la fotografia
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                    padding: new EdgeInsets.all(8.0),
                    child: new Image.network(
                        publication.photo,
                        fit: BoxFit.cover
                    )
                )
              ],
            ),
            //aqui termina la fotografia
            new ButtonTheme.bar(
              child: new ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new FlatButton(
                    child: const Text('Like'),
                    textColor: Colors.blue,
                    onPressed: () {
                      /* do nothing */
                    },
                  ),
                  new FlatButton(
                    child: const Text('Comments'),
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new clsDetailProduct(publication),
                          ));
                    },
                  ),
                  new FlatButton(
                    child: const Text('Share'),
                    textColor: Colors.blue,
                    onPressed: () {
                      /* do nothing */
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const jsonCodec = const JsonCodec();

class clsMain extends StatefulWidget {
  @override
  clsMainList createState() => new clsMainList();
}

class clsMainList extends State<clsMain> {
  List<Map> datos;

  Future<String> getData() async {
    var url = "https://jsonplaceholder.typicode.com/photos";
    var httpClient = createHttpClient();
    var response = await httpClient.get(url, headers: {
      "Accept": "application/json",
    });
    this.setState(() {
      datos = JSON.decode(response.body);
    });
    for (var i = 0; i < datos.length; i++) {
      Map dat = datos[i];
      String title = dat['title'];
      String photo = dat['url'];
      String detail = dat['title'];

      list_publication.add(new Publication(photo, title, detail));
    }

    return "Success!";
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: const Text('Victor Rances'),
            accountEmail: const Text('victordevcode@gmail.com'),
            currentAccountPicture: const CircleAvatar(
                backgroundImage: const AssetImage('img/perfil.jpg')),
            onDetailsPressed: () {},
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new ExactAssetImage('img/header.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          new ListTile(
            leading: const Icon(Icons.person),
            title: new Text('CodigoPanda'),
            onTap: () {},
          ),
          new Divider(),
          new ListTile(
            leading: const Icon(Icons.account_circle),
            title: new Text('About'),
            onTap: () {},
          ),
          new ListTile(
            leading: const Icon(Icons.settings_power),
            title: new Text('exit'),
            onTap: () {},
          ),
        ],
      )),
      appBar: new AppBar(
          title: new Text("Flutter Social"), backgroundColor: Colors.green),
      body: new RefreshIndicator(
        child: new ListView.builder(
            itemCount: list_publication == null ? 0 : list_publication.length,
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            itemBuilder: _itemBuilder),
        onRefresh: _onRefresh,
      ),
    );
  }


  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    Publication todo = list_publication[index];
    return new PublicationItem(publication: todo);
  }
}
