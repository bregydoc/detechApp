import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';



class PatientView extends StatefulWidget {
    String dni;
    PatientView(String dni) {
        this.dni = dni;
    }

    @override
    _PatientViewState createState() => new _PatientViewState(this.dni);
}

class _PatientViewState extends State<PatientView> {

    String _dni;
    DatabaseReference reference;

    _PatientViewState(String dni) {
        this._dni = dni;
        reference = FirebaseDatabase.instance.reference().child('Patients/$_dni');
    }

    Map _dataOfUser = new Map();

    @override
    Widget build(BuildContext context) {


        reference.onValue.listen((event) {
            setState(() {
                var data = event.snapshot.value;
                _dataOfUser = data;
            });
        });

        return new Scaffold(
            appBar: new AppBar(title:  new Text("Detech"), backgroundColor: new Color.fromARGB(255, 45, 187, 228)),
            body: new Container(
                child: new Center(
                    child: new Column(
                        children: <Widget>[new Material(child:  new Text(_dataOfUser["nombre_completo"]), type: MaterialType.card,),

                            new Text(_dataOfUser["domicilio"]),
                            new Text(_dataOfUser["dni"]),
                            new Text(_dataOfUser["numero_de_hc"]),
                            new Text(_dataOfUser["sexo"]),
                            new Text(_dataOfUser["telefono"]),

                        ],
                    ),

                ),
            ),

        );
    }
}
