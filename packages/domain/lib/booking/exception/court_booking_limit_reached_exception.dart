part of domain;

/// Excepción lanzada cuando se ha alcanzado el límite de reservas para una cancha en un día particular.
///
/// Esta excepción se lanza cuando se intenta hacer una reserva en una cancha que ya ha sido reservada
/// tres veces en el mismo día.
class CourtBookingLimitReachedException implements Exception {
  /// Mensaje descriptivo de la excepción.
  final String message =
      "La cancha ya se encuentra reservada 3 veces para el día";

  CourtBookingLimitReachedException();

  @override
  String toString() => message;
}
