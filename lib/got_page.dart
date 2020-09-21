import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

Color mainColor = CupertinoColors.destructiveRed;
Color secColor = Colors.black;

class GotPage extends StatefulWidget {
  @override
  _GotPageState createState() => _GotPageState();
}

class _GotPageState extends State<GotPage> {
  var data;

  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    setState(() {});
  }

  showGridWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
        itemCount: data["_embedded"]["episode"],
        itemBuilder: (context, index) {
          
          var episode = data["_embedded"]["episodes"][index];
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(episode["image"]["original"], fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(episode["name"],
                      style: TextStyle(color: Colors.white)),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text("${episode["season"]}${episode["number"]}"),
                            decoration: BoxDecoration(color:Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16) )
                            ),
                            ))
              ],
            ),
          );
        },
      ),
    );
  }

  dataBody(BuildContext context) {
    var imgUrl = data['image']['original'];
    var body = Column(
      children: <Widget>[
        Center(
          child: CircleAvatar(
            backgroundImage: NetworkImage(imgUrl),
            radius: 70,
          ),
        ),
        SizedBox(height: 20),
        Text(data["name"]),
        SizedBox(height: 20),
        Expanded(child: showGridWidget())
      ],
    );
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: mainColor,
          title: Text(
            "Got 2019",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: data != null
            ? dataBody(context)
            : Center(child: CircularProgressIndicator()));
  }
}
