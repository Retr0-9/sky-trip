import 'package:hive/hive.dart';


@HiveType(typeId: 3) 
class BookedVehicleModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String vehicleName;

  @HiveField(2)
  final String vehicleType;

  @HiveField(3)
  final int seats;

  @HiveField(4)
  final int bags;

  @HiveField(5)
  final double rating;

  @HiveField(6)
  final double price;

  @HiveField(7)
  final List<String> features;

  @HiveField(8)
  final String pickupLocation;

  @HiveField(9)
  final String dropLocation;

  @HiveField(10)
  final String pickupDate;

  @HiveField(11)
  final String returnDate;

  @HiveField(12)
  final int days;

  @HiveField(13)
  final double totalPrice;

  BookedVehicleModel({
    required this.id,
    required this.vehicleName,
    required this.vehicleType,
    required this.seats,
    required this.bags,
    required this.rating,
    required this.price,
    required this.features,
    required this.pickupLocation,
    required this.dropLocation,
    required this.pickupDate,
    required this.returnDate,
    required this.days,
    required this.totalPrice,
  });
}