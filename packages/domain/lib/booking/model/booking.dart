part of domain;

/// Modelo para representar un agendamiento de cancha.
///
/// [id] es el identificador único del agendamiento.
/// [court] es la cancha que se ha agendado.
/// [date] es la fecha y hora del agendamiento.
/// [userName] es el nombre del usuario que realizó el agendamiento.
/// [weather] es el pronóstico del tiempo para la fecha del agendamiento.
abstract class Booking {
  final String id;
  final Court court;
  final DateTime date;
  final String userName;
  final Weather weather;

  Booking(
      {required this.id,
      required this.court,
      required this.date,
      required this.userName,
      required this.weather});
}
