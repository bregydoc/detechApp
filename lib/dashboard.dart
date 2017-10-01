import "package:flutter/material.dart";
import "dart:async";
import 'package:firebase_database/firebase_database.dart';

import 'patient.dart';


class DashboardPage extends StatefulWidget {

    @override
    _DashboardPageState createState() => new _DashboardPageState();


}

class _DashboardPageState extends State<DashboardPage> {
    final reference = FirebaseDatabase.instance.reference().child('Patients');

    List<ListTile> _users = new List();
    int _size = 0;
    String _dniOfSelectedPatient = "";

    Widget getNewPatient(BuildContext context, int index) {
        return  _users[index];
    }

    void _clickPatient (){
        print(_dniOfSelectedPatient);
        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
            return new PatientView(_dniOfSelectedPatient);
        }));
    }

    @override
    Widget build(BuildContext context) {
        reference.onValue.listen((event) {
            _users.removeRange(0, _users.length);

            var patients = new Map.from(event.snapshot.value);
            patients.forEach((k, v) {
                _users.add(new ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text(v["nombre_completo"]),
                    subtitle: new Text(v["dni"]),
                    onTap: () {
                        _dniOfSelectedPatient = v["dni"];
                        _clickPatient();
                    },
                ));
            });
            setState(() {_size = _users.length;});
        });

        void _pressAddButton() {

        }

        return new Scaffold(
            drawer: new Drawer(
                child: new ListView(
                    children: <Widget>[
                        new UserAccountsDrawerHeader(
                            accountName: new Text("Bregy Malpartida"),
                            accountEmail: new Text("bregy.malpartida@utec.edu.pe")),
                    ],
                ),
            ),
            floatingActionButton: new FloatingActionButton(
                child: new Icon(Icons.add), onPressed: _pressAddButton),
            backgroundColor: new Color(0xffEEEEEE),
            appBar: new AppBar(
                title: new Text("Pacientes",
                    style: new TextStyle(
                        color: Colors.black,
                    )),
                iconTheme: new IconThemeData(color: Colors.black),
                centerTitle: true,
                backgroundColor: Colors.white, //new Color.fromARGB(255, 45, 187, 228)
            ),
            body: new ListView.builder(itemBuilder: getNewPatient, itemCount: _size,)


        );


    }
}
