import 'flight_model.dart';
import 'passenger_model.dart';

class SelectedService {
  final String name;
  final double price;
  final int quantity;

  const SelectedService({
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get total => price * quantity;
}

class BookingModel {
  final FlightModel flight;
  final List<PassengerModel> passengers;
  final List<SelectedService> services;
  final String? selectedSeat;

  const BookingModel({
    required this.flight,
    required this.passengers,
    this.services = const [],
    this.selectedSeat,
  });

  double get flightTotal => flight.price * passengers.length;

  double get servicesTotal =>
      services.fold(0, (sum, s) => sum + s.total);

  double get grandTotal => flightTotal + servicesTotal;
}
