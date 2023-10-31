import 'package:domain/domain.dart';
import 'package:field_scheduling/core/extension/date.dart';
import 'package:field_scheduling/widgets/app_bars/app_bar_bs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// BS
part 'bs/delete_booking_bs.dart';

/// Clase abstracta [BookingMessages] que proporciona métodos para mostrar mensajes
/// o modales relacionados con las reservas en la aplicación.
abstract class BookingMessages {
  /// Método [showDeleteBooking] que muestra un BottomSheet modal para confirmar
  /// la eliminación de una reserva.
  ///
  /// Recibe el [context] de Flutter y una [booking] que es la reserva que se
  /// está considerando eliminar.
  ///
  /// Retorna un `Future<bool?>` que se resuelve con `true` si el usuario confirma
  /// la eliminación, o `null` si el usuario cancela la eliminación.
  static Future<bool?> showDeleteBooking(BuildContext context,
          {required Booking booking}) =>
      showModalBottomSheet(
          context: context,
          builder: (context) => _DeleteBookingBs(booking: booking));
}
