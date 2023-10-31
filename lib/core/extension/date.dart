import 'package:intl/intl.dart';

/// Extensión sobre la clase [DateTime] para proporcionar
/// formatos de fecha y hora personalizados.
extension DateFormatExtension on DateTime {
  /// Retorna una cadena de texto formateada en "dd MMMM".
  /// Ejemplo: "31 Octubre"
  String get ddMMMM => DateFormat("dd MMMM").format(this);

  /// Retorna una cadena de texto formateada en "dd MMMM, HH:mm".
  /// Ejemplo: "31 Octubre, 14:00"
  String get ddMMMMHHmm => DateFormat("dd MMMM, HH:mm").format(this);

  /// Retorna una cadena de texto formateada en "HH:mm a".
  /// Ejemplo: "14:00 PM"
  String get hhmm => DateFormat("HH:mm a").format(this);
}
