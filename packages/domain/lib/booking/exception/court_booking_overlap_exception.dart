part of domain;

/// Excepción lanzada cuando se intenta hacer una reserva en una cancha que ya ha sido reservada
/// para el mismo horario.
class CourtBookingOverlapException implements Exception {
  /// Mensaje descriptivo de la excepción.
  final String message =
      "La cancha ya ha sido agendada durante el horario solicitado";

  CourtBookingOverlapException();

  @override
  String toString() => message;
}
