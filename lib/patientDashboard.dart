import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';
import 'patientInfo.dart';
import 'patientCH.dart';
import 'patientThermal.dart';
import 'main.dart';


class PatientView extends StatefulWidget {
    String dni;
    PatientView(String dni) {
        this.dni = dni;
    }

    @override
    _PatientViewState createState() => new _PatientViewState(this.dni);
}

class _PatientViewState extends State<PatientView> with SingleTickerProviderStateMixin {

    String _dni;
    DatabaseReference reference;

    _PatientViewState(String dni) {
        this._dni = dni;
        reference = FirebaseDatabase.instance.reference().child('Patients/$_dni');
    }

    Map _dataOfPatient = new Map();

    TabController tabController;

    @override
    void initState() {
        super.initState();
        tabController = new TabController(length: 3, vsync: this);
    }

    @override
    void dispose() {
        tabController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {

        reference.onValue.listen((event) {
            setState(() {
                var data = event.snapshot.value;
                _dataOfPatient = data;
            });
        });

        return new Scaffold(
            appBar: new AppBar(
                title:  new Text("Detech"),
                backgroundColor: new Color.fromARGB(255, 45, 187, 228),
                bottom: new TabBar(
                    tabs: [
                        new Tab(icon: new Icon(Icons.info), text: "Information",),
                        new Tab(icon: new Icon(Icons.view_module), text: "Clinic history",),
                        new Tab(icon: new Icon(Icons.verified_user), text: "Thermal history",),
                    ],
                    controller: tabController,
                ),
            ),
            body:  new TabBarView(

                controller: tabController,
                children: [
                    new PatientInfo(_dataOfPatient),
                    new PatientClinicHistory(_dataOfPatient["evaluation_file"]),
                    new PatientThermalHistory(),
                ]
            ),
            drawer: generalDrawer,

        );
    }
}
