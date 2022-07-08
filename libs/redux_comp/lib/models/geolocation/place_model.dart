import 'package:redux_comp/models/geolocation/coordinates_model.dart';

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  Coordinates? location;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.location
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}