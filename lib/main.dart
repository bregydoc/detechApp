import "package:flutter/material.dart";
import 'dashboard.dart';
import 'package:firebase_database/firebase_database.dart';



void main() {
    runApp(new MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.pink
        ),
    ));
}

class LoginPage extends StatefulWidget {
    @override
    LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {

    final usersRef = FirebaseDatabase.instance.reference().child('Users_and_ids');
    List<String> validUsernames = new List();
    Map usersData = new Map();

    double _imageScale = 1.0;

    final TextEditingController passController = new TextEditingController();
    final TextEditingController usernameController = new TextEditingController();

    ScrollController scrollController = new ScrollController();

    @override
    void initState() {
        super.initState();
        usersRef.onValue.listen((event){
            Map users = event.snapshot.value;
            users.forEach((k, v) {
                validUsernames.add(v["username"]);
                usersData[v["username"]] = v["id"];
            });
        });
    }

    void userEnteringData(String data ){
        scrollController.animateTo(10.0, duration: new Duration(seconds: 1), curve: null);
    }



    @override
    Widget build(BuildContext context) {




        void loginPressed () {
            print(validUsernames);

            if (validUsernames.contains(usernameController.text)) {
                //Navigator.of(context).pushNamed("/dashboard");
                Navigator.push(
                    context, new MaterialPageRoute(builder: (BuildContext context) {
                        String id = usersData[usernameController.text];
                        return new DashboardPage(id);
                    })
                );
            }else{

            }
        }


        return  new Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: new Color(0xffEEEEEE),
            appBar: new AppBar(
                title: new Text("Detech"),
                centerTitle: true,
                backgroundColor: new Color.fromARGB(255, 45, 187, 228)
            ),
            body: new ListView(
                children: <Widget>[
                    new Container(
                        padding: new EdgeInsets.only(left: 30.0, right: 30.0),
                        child: new Center(
                            child: new Column(

                                crossAxisAlignment: CrossAxisAlignment.stretch,

                                children: <Widget>[
                                    new Container(
                                        child: new Image.asset("assets/logoDetech.png", alignment: FractionalOffset.center, scale: _imageScale,),
                                        padding: new EdgeInsets.only(top: 50.0, bottom: 50.0),
                                    ),

                                    new TextField(
                                        decoration: new InputDecoration(labelText: "Username"),
                                        controller: usernameController,
                                        keyboardType: TextInputType.emailAddress,
                                        autofocus: true,
                                        onChanged: userEnteringData,
                                    ),
                                    new TextField(
                                        decoration: new InputDecoration(labelText: "Password"),
                                        controller: passController,
                                        obscureText: true,
                                    ),
                                    new Container(
                                        child: new RaisedButton(
                                            child: new Text("LOGIN", style: new TextStyle(color: Colors.white),),
                                            onPressed: loginPressed,
                                            color: new Color(0xff035A70),

                                        ),
                                        padding: new EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
                                    ),
                                ],
                            ),
                        ),
                    )
            ],
            controller: scrollController,
            )
        );

    }
}


var generalDrawer = new Drawer(
    child: new ListView(
        children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Bregy Malpartida"),
                accountEmail: new Text("bregy.malpartida@utec.edu.pe"),
            ),
        ],
    ),
);
