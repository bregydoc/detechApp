
class Patient {
  final String fullName;
  final bool favorite;

  const Patient({this.fullName, this.favorite});
}

const kPatients = const <Patient>[
  const Patient(
      fullName: 'Romain Hoogmoed',
      favorite: true,

  ),
  const Patient(
      fullName: 'Emilie Olsen',
      favorite: false,

  )
];