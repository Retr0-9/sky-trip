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
  final DateTime checkInDate;

  @HiveField(4)
  final DateTime checkOutDate;

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

  factory HotelBookingModel.fromJson(Map<String, dynamic> json) {
    return HotelBookingModel(
      id: json['id'] as String,
      hotelName: json['hotelName'] as String,
      location: json['location'] as String,
      checkInDate: DateTime.parse(json['checkInDate'] as String),
      checkOutDate: DateTime.parse(json['checkOutDate'] as String),
      numberOfGuests: json['numberOfGuests'] as int,
      numberOfRooms: json['numberOfRooms'] as int? ?? 1,
      roomType: json['roomType'] as String? ?? 'Standard Room',
      pricePerNight: (json['pricePerNight'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'hotelName': hotelName,
        'location': location,
        'checkInDate': checkInDate.toIso8601String(),
        'checkOutDate': checkOutDate.toIso8601String(),
        'numberOfGuests': numberOfGuests,
        'numberOfRooms': numberOfRooms,
        'roomType': roomType,
        'pricePerNight': pricePerNight,
      };
}