part of infrastructure;

/// Implementación de [BookingRepository] que delega las operaciones
/// de almacenamiento de datos al [_bookingDataSource].
class BookingRepositoryImpl extends BookingRepository {
  // Instancia del repositorio del booking data source
  final BookingDataSource _bookingDataSource;

  /// Constructor que recibe una instancia de [BookingDataSource] que se utilizará
  /// para manejar las operaciones de almacenamiento de datos.
  BookingRepositoryImpl({required BookingDataSource bookingDataSource})
      : _bookingDataSource = bookingDataSource;

  /// Elimina una reserva identificada por [bookingId] delegando la operación
  /// al [_bookingDataSource].
  @override
  Future<void> deleteBooking(String bookingId) =>
      _bookingDataSource.deleteBooking(bookingId);

  /// Recupera todas las reservas delegando la operación al [_bookingDataSource].
  @override
  Future<List<Booking>> fetchAllBookings() =>
      _bookingDataSource.fetchAllBookings();

  /// Obtiene el número de reservas en un día específico y cancha delegando la operación
  /// al [_bookingDataSource].
  @override
  Future<List<Booking>> getDailyBookingsCount(
          {required String courtName, required DateTime date}) =>
      _bookingDataSource.getDailyBookingsCount(
          courtName: courtName, date: date);

  /// Guarda una reserva delegando la operación al [_bookingDataSource].
  @override
  Future<void> saveBooking(Booking booking) =>
      _bookingDataSource.saveBooking(booking);

  /// Obtiene la probabilidad de lluvia para una fecha específica delegando la operación
  /// al [_bookingDataSource].
  @override
  Future<Weather> getRainProbability(DateTime date) =>
      _bookingDataSource.getRainProbability(date);
}
