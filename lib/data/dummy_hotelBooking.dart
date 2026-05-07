import 'package:skytrip/models/hotel_booking_model.dart';

final List<HotelBookingModel> dummyHotelBookings = [
  HotelBookingModel(
    id: '1',
    hotelName: 'Grand Palace Hotel',
    location: 'New York, USA',
    checkInDate: DateTime(2024, 7, 20),
    checkOutDate: DateTime(2024, 7, 25),
    numberOfGuests: 2,
    numberOfRooms: 1,           // ← مضاف
    roomType: 'Deluxe Room',    // ← مضاف
    pricePerNight: 120.0,       // ← مضاف
  ),
  HotelBookingModel(
    id: '2',
    hotelName: 'Ocean View Resort',
    location: 'Miami, USA',
    checkInDate: DateTime(2024, 8, 10),
    checkOutDate: DateTime(2024, 8, 15),
    numberOfGuests: 4,
    numberOfRooms: 2,          
    roomType: 'Superior Room',  
    pricePerNight: 185.0,       
  ),
];