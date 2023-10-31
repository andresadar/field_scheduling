part of domain;

/// Modelo abstracto para representar la información meteorológica.
///
/// [location] es la ubicación geográfica donde se obtuvo la información meteorológica.
/// [description] es una descripción textual del estado del clima.
/// [temperatureCelsius] es la temperatura en grados Celsius.
abstract class Weather {
  final String location;
  final String description;
  final double temperatureCelsius;

  Weather({
    required this.location,
    required this.description,
    required this.temperatureCelsius,
  });
}
