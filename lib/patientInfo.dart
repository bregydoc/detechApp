import "package:flutter/material.dart";


class PatientInfo extends StatelessWidget {
    Map _dataOfUser;

    PatientInfo(Map data) {
        _dataOfUser = data;
    }

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            body: new Container(
                child: new Center(
                    child: new ListView(
                        children:[
                            new PatientItem('Full name',_dataOfUser["nombre_completo"], Icons.account_circle),
                            new PatientItem('Address',_dataOfUser["domicilio"], Icons.location_on),
                            new PatientItem('DNI',_dataOfUser["dni"], Icons.tab),
                            new PatientItem('Clinic History',_dataOfUser["numero_de_hc"], Icons.add_circle),
                            new PatientItem('Gender',_dataOfUser["sexo"], Icons.perm_identity),
                            new PatientItem('Phone',_dataOfUser["telefono"], Icons.phone),
                        ],
                    ),

                ),
            ),
            floatingActionButton: new FloatingActionButton(
                child: new Icon(Icons.edit),
                onPressed: null,
                tooltip: "Edit patient information",
            ),
        );
    }
}


class PatientItem extends StatelessWidget {

    String _field;
    String _title;
    IconData _icon;

    PatientItem (String title, String field, IconData icon) {
        this._title = title;
        this._field = field;
        this._icon = icon;
    }

    @override
    Widget build(BuildContext context) {
        return new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
                children: <Widget>[
                    new Row(
                        children: <Widget>[
                            new Padding(
                                padding: new EdgeInsets.only(right: 10.0),
                                child: new Icon(this._icon, color: new Color(0xff035A70),),
                            ),
                            new Text(_title, style: new TextStyle(fontSize: 18.0, color: new Color(0xff035A70)),),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    new Padding(
                        padding: new EdgeInsets.only(top: 5.0),
                        child: new Text(_field, style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),)
                    ),
                ],
            ),
        );
    }
}
