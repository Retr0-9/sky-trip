// lib/models/vehicle.dart

class Vehicle {
  final String name;
  final String type;
  final double rating;
  final int seats;
  final int bags;
  final List<String> features;
  final double price;

  const Vehicle({
    required this.name,
    required this.type,
    required this.rating,
    required this.seats,
    required this.bags,
    required this.features,
    required this.price,
  });
}