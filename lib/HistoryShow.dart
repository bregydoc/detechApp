import "package:flutter/material.dart";
import 'package:firebase_database/firebase_database.dart';


class ClinicHistoryShow extends StatefulWidget {
    String _id;
    ClinicHistoryShow(String dni) {
        this._id = dni;
    }

    @override
    _ClinicHistoryShowState createState() => new _ClinicHistoryShowState(this._id);
}

class _ClinicHistoryShowState extends State<ClinicHistoryShow>{

    List<ListTile> _items = new List();

    DatabaseReference reference;
    String _idOfHC;
    Map _historyData = new Map();
    var _size = 0;


    _ClinicHistoryShowState(String idOfHC) {
        this._idOfHC = idOfHC;
        reference = FirebaseDatabase.instance.reference().child('EvaluationFiles/$_idOfHC');
        reference.onValue.listen((event) {
            _historyData = event.snapshot.value;
            var size;
            if (_historyData.isNotEmpty) {
                print(_historyData);
                List additionalDataKeys = _historyData["datos_adicionales"].keys.toList();
                List generalDataKeys = _historyData["datos_generales"].keys.toList();
                List informationKeys = _historyData["informacion"].keys.toList();

                size = additionalDataKeys.length + generalDataKeys.length + informationKeys.length;

                var createdData;
                var internalData;

                for (var index=0;index<additionalDataKeys.length;index++) {
                    createdData = additionalDataKeys[index];
                    createdData = createdData.toString().replaceAll("_", " ");
                    createdData = createdData.toString().substring(0, 1).toUpperCase() + createdData.toString().substring(1);
                    internalData = _historyData["datos_adicionales"][additionalDataKeys[index]];
                    _items.add(new ListTile(title: new Text(createdData), subtitle: new Text(internalData.toString()),));
                }

                for (var index=0;index<generalDataKeys.length;index++) {
                    createdData = generalDataKeys[index];
                    createdData = createdData.toString().replaceAll("_", " ");
                    createdData = createdData.toString().substring(0, 1).toUpperCase() + createdData.toString().substring(1);
                    internalData = _historyData["datos_adicionales"][generalDataKeys[index]];
                    _items.add(new ListTile(title: new Text(createdData), subtitle: new Text(internalData.toString()),));
                }
                for (var index=0;index<informationKeys.length;index++) {
                    createdData = informationKeys[index];
                    createdData = createdData.toString().replaceAll("_", " ");
                    createdData = createdData.toString().substring(0, 1).toUpperCase() + createdData.toString().substring(1);
                    internalData = _historyData["datos_adicionales"][informationKeys[index]];
                    _items.add(new ListTile(title: new Text(createdData), subtitle: new Text(internalData.toString()),));
                }



            }
            setState((){
               _size = size;
            });

        });

    }



    @override
    Widget build(BuildContext context) {
        Widget getEvaluationFileData(BuildContext context, int index) {
            return _items[index];
        }
        return new Scaffold(
            appBar: new AppBar(title: new Text("Clinic History"), backgroundColor: new Color.fromARGB(255, 45, 187, 228),),
            body: new ListView.builder(itemBuilder: getEvaluationFileData, itemCount: _size,),
            floatingActionButton: new FloatingActionButton(child: new Icon(Icons.delete), onPressed: null),
        );
    }


}