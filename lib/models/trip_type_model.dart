/// Trip type returned by GET /api/Triptypes/All
class TripTypeModel {
  final int tripTypeId;
  final String name;

  const TripTypeModel({required this.tripTypeId, required this.name});

  factory TripTypeModel.fromJson(Map<String, dynamic> json) {
    return TripTypeModel(
      tripTypeId: json['tripTypeID'] as int,
      name:       (json['tripTypeName'] as String? ?? '').trim(),
    );
  }
}
