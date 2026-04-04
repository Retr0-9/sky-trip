/// Cabin class returned by GET /api/PassengerClass/All
class PassengerClassModel {
  final int classId;
  final String name;
  final double fees;

  const PassengerClassModel({
    required this.classId,
    required this.name,
    required this.fees,
  });

  factory PassengerClassModel.fromJson(Map<String, dynamic> json) {
    return PassengerClassModel(
      classId: json['classID'] as int,
      name:    (json['nameClass'] as String? ?? '').trim(),
      fees:    (json['feesClass'] as num? ?? 0).toDouble(),
    );
  }
}
