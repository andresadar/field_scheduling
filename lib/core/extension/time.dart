import 'package:flutter/material.dart';

/// Extensión sobre la clase [TimeOfDay] para proporcionar
/// una función de formateo para representar rangos de tiempo.
extension TimeOfDayFormatExtension on TimeOfDay {
  /// Formatea un rango de tiempo desde la hora actual hasta 2 horas después.
  /// Retorna una cadena de texto en el formato: 'HH:mm - HH:mm'.
  ///
  /// Ejemplo: Si la hora actual es 14:00, retornará '14:00 - 16:00'.
  String formatTimeRange(BuildContext context) {
    final startTime = format(context);
    final endTime =
        replacing(hour: (hour + 2) % TimeOfDay.hoursPerDay).format(context);
    return '$startTime - $endTime';
  }
}
