enum PassengerType { adult, youth, child, infant }

class PassengerModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime? dateOfBirth;
  final String gender;
  final String issuedCountry;
  final String documentType; // 'passport' or 'id'
  final PassengerType type;

  const PassengerModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.dateOfBirth,
    required this.gender,
    required this.issuedCountry,
    required this.documentType,
    required this.type,
  });

  String get fullName => '$firstName $lastName';

  String get typeLabel {
    switch (type) {
      case PassengerType.adult:
        return 'Adult';
      case PassengerType.youth:
        return 'Youth';
      case PassengerType.child:
        return 'Child';
      case PassengerType.infant:
        return 'Infant';
    }
  }
}
