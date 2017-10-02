import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';

import 'patientDashboard.dart';

import 'main.dart';


class DashboardPage extends StatefulWidget {

    String _id;
    DashboardPage(String id) {
        this._id = id;
    }

    @override
    _DashboardPageState createState() => new _DashboardPageState(_id);


}

class _DashboardPageState extends State<DashboardPage> {

    String _id;
    DatabaseReference reference;
    _DashboardPageState(String id) {
        this._id = id;
        reference = FirebaseDatabase.instance.reference().child('Users/$_id/patients');
    }


    List<ListTile> _patients = new List();
    int _size = 0;
    String _dniOfSelectedPatient = "";

    Widget getNewPatient(BuildContext context, int index) {
        return  _patients[index];
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
            _patients.removeRange(0, _patients.length);

            var patients = new Map.from(event.snapshot.value);
            patients.forEach((k, v) {
                _patients.add(new ListTile(
                    leading: new Icon(Icons.person),
                    title: new Text(v["nombre_completo"]),
                    subtitle: new Text(v["dni"]),
                    onTap: () {
                        _dniOfSelectedPatient = v["dni"];
                        _clickPatient();
                    },
                ));
            });
            setState(() {_size = _patients.length;});
        });

        void _pressAddButton() {

        }

        return new Scaffold(
            drawer: generalDrawer,
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
