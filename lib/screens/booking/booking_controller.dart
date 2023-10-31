import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:infrastructure/infrastructure.dart';

/// Clase [BookingController] que actúa como un intermediario entre la UI y la lógica de negocio
/// relacionada con las reservas.
///
/// Esta clase extiende [ChangeNotifier] para notificar a los widgets que la escuchan sobre cambios en
/// los datos relacionados con las reservas.
class BookingController extends ChangeNotifier {
  /// Instancia de [BookingUseCase] que encapsula la lógica de negocio relacionada con las reservas.
  final BookingUseCase _bookingUseCase;

  /// Constructor que inyecta una instancia de [BookingUseCase] y realiza una
  /// llamada inicial a [fetchAllBookings] para obtener todas las reservas.
  BookingController({required BookingUseCase bookingUseCase})
      : _bookingUseCase = bookingUseCase {
    fetchAllBookings();
  }

  /// Indica si se están cargando los datos.
  bool isLoading = true;

  /// Lista de reservas.
  List<Booking>? bookings;

  /// Lista de canchas disponibles.
  final List<Court> courts =
      List.generate("ABC".length, (index) => CourtModel(name: "ABC"[index]));

  /// Método para obtener todas las reservas activas.
  /// Se establece [isLoading] a true al inicio de la llamada y a false al final.
  /// Si la llamada es exitosa, se actualiza [bookings]. Si hay un error, se loguea el error y se establece [bookings] a null.
  void fetchAllBookings() async {
    isLoading = true;
    notifyListeners();
    try {
      bookings = await _bookingUseCase.fetchAllBookings();
    } catch (e) {
      log("$e");
      bookings = null;
    }
    isLoading = false;
    notifyListeners();
  }

  /// Método para crear una reserva.
  /// La reserva se añade a la lista [bookings] y se notifica a los oyentes.
  Future<void> saveBooking(
    Booking booking,
  ) async {
    await _bookingUseCase.saveBooking(booking);
    bookings?.add(booking);
    notifyListeners();
  }

  /// Método para borrar una reserva dado su [bookindId].
  Future<void> deleteBooking(String bookindId) =>
      _bookingUseCase.deleteBooking(bookindId);

  /// Método para obtener la probabilidad de lluvia en una [date] dada.
  Future<Weather> getRainProbability(DateTime date) =>
      _bookingUseCase.getRainProbability(date);
}
