import "package:flutter/material.dart";
import 'HistoryShow.dart';

class PatientClinicHistory extends StatelessWidget {

    Map _evaluationOfPatientData;

    List<ListTile> _evalFiles = new List();
    int _size = 0;
    BuildContext _context;

    Widget getNewEvaluationFile(BuildContext context, int index) {
        return  _evalFiles[index];
    }

    void _launch(String id) {
        Navigator.push(_context, new MaterialPageRoute(builder: (BuildContext context) {
            return new ClinicHistoryShow(id);
        }));
    }



    PatientClinicHistory (Map patientData) {

        this._evaluationOfPatientData = patientData;

        _evalFiles.removeRange(0, _evalFiles.length);

        if (patientData != null) {
            _evaluationOfPatientData.forEach((k, v) {
                var info = v["informacion_general"];
                _evalFiles.add( new ListTile(
                    isThreeLine: true,
                    title: new Text("Ficha del ${info["fecha"]}"),
                    subtitle: new Column(
                        children: <Widget>[
                            new Text("Edad: ${info["edad"]}, IMC:${info["imc"]}"),
                            new Text("Fecha de hospitalizacion: ${info["fecha_de_hospitalizacion"]}"),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    leading: new Icon(Icons.folder),
                    onTap: (){
                        _launch(v["id"]);
                    },
                ));
            });
            _size = _evalFiles.length;
        }else {
            _evalFiles.add(
                new ListTile(
                    title: new Center(child: new Text("No se encontraron fichas"),),
                )
            );
            _size = _evalFiles.length;
        }

    }

    @override
    Widget build(BuildContext context) {
        _context = context;
        return new Scaffold(
            floatingActionButton: new FloatingActionButton(
                tooltip: "Create new clinic history",
                child: new Icon(Icons.add),
                onPressed: null
            ),
            body: new ListView.builder(itemBuilder: getNewEvaluationFile, itemCount: _size,),
        );

    }
}