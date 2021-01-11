import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BaslangicSayfasi(),
    );
  }
}

class BaslangicSayfasi extends StatefulWidget {
  @override
  _BaslangicSayfasiState createState() => _BaslangicSayfasiState();
}

class _BaslangicSayfasiState extends State<BaslangicSayfasi> {
  String url = 'https://jsonplaceholder.typicode.com/photos';
  List data;

  Future<String> istekAlmak() async {
    var istek = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      data = json.decode(istek.body);
    });
  }

  @override
  void initState() {
    super.initState();
    this.istekAlmak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return ListTile(
            title: Text(data[i]["id"].toString()),
            subtitle: Text(data[i]["title"]),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[i]["url"]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IkinciSayfa(data: data[i]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class IkinciSayfa extends StatelessWidget {
  IkinciSayfa({this.data});
  final data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İkinci Sayfa'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                data["thumbnailUrl"],
              ),
            ),
            Expanded(
              child: Text(
                data["title"],
              ),
            ),
            Expanded(
              child: Text(
                data["id"].toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
