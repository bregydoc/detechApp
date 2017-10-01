import "package:flutter/material.dart";
import 'dashboard.dart';

void main() {
  runApp(new MaterialApp(
    home: new LoginPage(),
    theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink
    ),
    routes: <String, WidgetBuilder> {
      "/dashboard" : (BuildContext context) =>  new DashboardPage()
    },
  ));
}

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController passController = new TextEditingController();

    void loginPressed () {
      //Check login
      if (passController.text == "admin") {
        Navigator.of(context).pushNamed("/dashboard");
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
            body: new Container(
              padding: new EdgeInsets.only(left: 30.0, right: 30.0),
              child: new Center(
                child: new Column(

                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    new Container(
                      child: new Image.asset("assets/logoDetech.png", alignment: FractionalOffset.center,),
                      padding: new EdgeInsets.only(top: 50.0, bottom: 50.0),
                    ),

                    new TextField(decoration: new InputDecoration(labelText: "Username"), keyboardType: TextInputType.emailAddress,),
                    new TextField(decoration: new InputDecoration(labelText: "Password"), controller: passController, obscureText: true,),
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
            ));

  }
}

