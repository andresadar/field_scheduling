part of infrastructure;

/// `BookingDataSource` es una interfaz que define las operaciones de datos
/// que deben ser implementadas para interactuar con los datos de las reservas.
abstract class BookingDataSource {
  /// Obtiene todas las reservas existentes.
  Future<List<Booking>> fetchAllBookings();

  /// Obtiene el número de reservas para una cancha y fecha específicas.
  Future<List<Booking>> getDailyBookingsCount(
      {required String courtName, required DateTime date});

  /// Elimina una reserva identificada por [bookingId].
  Future<void> deleteBooking(String bookingId);

  /// Guarda una reserva.
  Future<void> saveBooking(Booking booking);

  /// Obtiene la probabilidad de lluvia para una fecha específica.
  Future<Weather> getRainProbability(DateTime date);
}
