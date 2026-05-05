import 'package:hive/hive.dart';


@HiveType(typeId: 0)
class HotelBookingModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String hotelName;

  @HiveField(2)
  final String location;

  @HiveField(3)
  final String checkInDate;

  @HiveField(4)
  final String checkOutDate;

  @HiveField(5)
  final int numberOfGuests;

  @HiveField(6)
  final int numberOfRooms;

  @HiveField(7)
  final String roomType;

  @HiveField(8)
  final double pricePerNight;

  HotelBookingModel({
    required this.id,
    required this.hotelName,
    required this.location,
    required this.checkInDate,
    required this.checkOutDate,
    required this.numberOfGuests,
    this.numberOfRooms = 1,
    this.roomType = 'Standard Room',
    this.pricePerNight = 0.0,
  });
}