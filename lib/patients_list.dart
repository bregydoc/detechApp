import 'package:flutter/material.dart';
import 'patients.dart';


class _PatientListItem extends ListTile {

    _PatientListItem(Patient contact) :
            super(
            title : new Text(contact.fullName),
            leading: new CircleAvatar(
                child: new Text(contact.fullName[0])
            )
        );

}


class ContactList extends StatelessWidget {

    final List<Patient> _patients;

    ContactList(this._patients);

    @override
    Widget build(BuildContext context) {
        return new ListView(

        );
    }

    List<_PatientListItem> _buildContactList() {
        return _patients.map((patient) => new _PatientListItem(patient)).toList();
    }

}