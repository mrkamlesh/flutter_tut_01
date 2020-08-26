import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Flutter Home Page'),
    );
  }
}

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
//  _MyHomePageState createState() => _MyHomePageState();
  _MyListPageState createState() => _MyListPageState();
}


class _MyListPageState extends State<MyHomePage> {
  static final showGrid = false; // Set to false to show ListView
  var users = new List<User>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("My List App"),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text("Hello: "+users[index].name),
            subtitle: Text(users[index].email),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(user: users[index])
              )
            );
            },
          );
        })
    );
  }

// body: Center(child: _buildList()), //body: Center(child: showGrid ? _buildGrid() : _buildList()),
  Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    padding: const EdgeInsets.all(4),
    children: _buildGridTitleList(30),
  );

  // #docregion list
  Widget _buildList() => ListView(
    children: [
      _tile('CineArts at the Empire', '85 W Portal Ave', Icons.theaters),
      _tile('The Castro Theater', '429 Castro St', Icons.theaters),
      _tile('Alamo Drafthouse Cinema', '2550 Mission St', Icons.theaters),
      _tile('Roxie Theater', '3117 16th St', Icons.theaters),
      _tile('United Artists Stonestown Twin', '501 Buckingham Way',
          Icons.theaters),
      _tile('AMC Metreon 16', '135 4th St #3000', Icons.theaters),
      Divider(),
      _tile('Kescaped_code#39;s Kitchen', '757 Monterey Blvd', Icons.restaurant),
      _tile('Emmyescaped_code#39;s Restaurant', '1923 Ocean Ave', Icons.restaurant),
      _tile(
          'Chaiya Thai Restaurant', '272 Claremont Blvd', Icons.restaurant),
      _tile('La Ciccia', '291 30th St', Icons.restaurant),
    ],
  );

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );

  List<Container> _buildGridTitleList(int count) => List.generate(count, (index) =>
      Container(child: Image.asset("images/pic$index.jpg"),)
  );

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.formJson(model)).toList();
      });
  });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUsers();
  }

}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("My First App"), //widget.title
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: EdgeInsets.all(2.5),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget> [
            Text("Text1"),
            Text("Text2"),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget> [
                  ListTile(
                      title: Text("ABC", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                  ),
                  Divider(color: Colors.black12,),
                  ListTile(
                    title: Text("EFG", style: CustomFontStyle.textPrimary(),),
                  ),
                ],
              ),
            ),
//            Stack(
//              alignment: const Alignment(0.6, 0.8),
//              children: <Widget>[
//                Container(
//                  height: 200,
//                  width: 200,
//                  color: Colors.blue,
//                ),
//                Container(
//                  height: 150,
//                  width: 150,
//                  color: Colors.white24,
//                ),
//                Container(
//                  decoration: BoxDecoration(
//                    color: Colors.black45,
//                  ),
//                  child: Text(
//                    "Hello Sonali",
//                    style: TextStyle(
//                        fontSize: 20,
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//                )
//              ],
//            ),
            SizedBox(
              height: 210,
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("1625 Main Street",
                        style: TextStyle(fontWeight: FontWeight.w500),),
                      subtitle: Text("My City, CA 99820"),
                      leading: Icon(
                        Icons.restaurant_menu,
                        color: Colors.blue[500]
                      ),
                    ),
                    Divider(color: Colors.black12,),
                    ListTile(
                      title: Text("(423)382-9232",
                      style: TextStyle(
                        fontWeight: FontWeight.w500
                      ),),
                      leading: Icon(
                        Icons.contact_phone,
                        color: Colors.blue[500],
                      ),
                    ),
                    ListTile(
                      title: Text("contact@myresturant.com", style: TextStyle(fontWeight: FontWeight.w500),),
                      leading: Icon(Icons.email, color: Colors.blue[500],),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget> [
            DrawerHeader(
              child: Text("Welcome User123"),
              decoration: BoxDecoration(color: Colors.blue),
            ),

            ListTile(
              title: Text("Menu list 1"),
            ),
            ListTile(
              title: Text("Menu list 2"),
            )
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key key, this.colorName}) : super(key: key, );
  final Color colorName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: this.colorName,
    );
  }
}

class CustomFontStyle {
  static TextStyle textPrimary() {
    return TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);
  }
}

class User {
  int id;
  String name;
  String email;


  User(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  User.formJson(Map json)
    : id = json['id'],
      name = json['name'],
      email = json['email'];

  Map json() {
    return { 'id': id, 'name': name, 'email': email };
  }

}

const baseURL = 'https://jsonplaceholder.typicode.com';

class API {
  static Future getUsers() {
    var url = baseURL + '/users';
    return http.get(url);
  }
}

class DetailsScreen extends StatelessWidget {
  final User user;

  DetailsScreen({Key key, @required this.user})  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(user.email),
      ),
    );
  }
}
