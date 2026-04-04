/// Add-on service returned by GET /api/Services/All
class ServiceModel {
  final int serviceId;
  final String name;
  final double fees;

  const ServiceModel({
    required this.serviceId,
    required this.name,
    required this.fees,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json['serviceID'] as int,
      name:      (json['nameService'] as String? ?? '').trim(),
      fees:      (json['fees'] as num).toDouble(),
    );
  }
}
