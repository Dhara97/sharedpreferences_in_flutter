import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginflutter/DataModel.dart';
import 'package:loginflutter/LoginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Future<dynamic> resData() async {
  http.Response response =
      await http.get('https://simplifiedcoding.net/demos/marvel/');
  List responseJson = json.decode(response.body);
  return responseJson;
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  SharedPreferences logindata;
  String mobile;

  @override
  void initState() {
    super.initState();
    initial();
    resData();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      mobile = logindata.getString('mobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Welcome User'.text(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
              onTap: () async {
                logindata.setBool('login', true);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => LoginScreen()));
              },
              child: Icon(Icons.exit_to_app).paddingRight(20))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<dynamic>(
          future: resData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              List<dynamic> mdata = snapshot.data;

              return ListView.builder(
                  itemCount: mdata.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: InkWell(
                        onTap: () async {
                          String result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screenDetail(
                                detail: mdata[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                            height: 100,
                            width: 100,
                            child: Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(mdata[index]['imageurl']),
                                  10.width,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text('Name: ' +
                                          mdata[index]['name'].toString()),
                                      5.height,
                                      Text('Real Name: ' +
                                          mdata[index]['realname'].toString()),
                                      5.height,
                                      Text('Team: ' +
                                          mdata[index]['team'].toString()),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator().center();
          },
        ),
      ),
    );
  }
}

class screenDetail extends StatefulWidget {
  final dynamic detail;

  const screenDetail({Key key, this.detail}) : super(key: key);

  @override
  _screenDetailState createState() => _screenDetailState();
}

class _screenDetailState extends State<screenDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Item Details'.text(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.network(widget.detail['imageurl']),
              10.height,
              Text("Name: " + widget.detail['name'].toString()),
              10.height,
              Text("Real name: " + widget.detail['realname'].toString()),
              10.height,
              Text("Team: " + widget.detail['team'].toString()),
              10.height,
              Text("First Appearance: " +
                  widget.detail['firstappearance'].toString()),
              10.height,
              Text("Created By " + widget.detail['createdby'].toString()),
              10.height,
              Text("Publisher: " + widget.detail['publisher'].toString()),
              10.height,
              Text("Bio: " + widget.detail['bio'].toString()),
            ],
          ),
        ),
      ),
    );
  }
}
