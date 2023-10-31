part of domain;

/// `BookingUseCase` es una clase que encapsula la lógica de negocio
/// relacionada con los agendamientos, actuando como intermediario entre
/// la capa de presentación y la capa de datos, delegando las operaciones
/// de almacenamiento de datos al [BookingRepository].
class BookingUseCase {
  final BookingRepository _bookingRepository;

  BookingUseCase({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository;

  /// Guarda un agendamiento en el repositorio si la cancha está disponible.
  ///
  /// Este método primero verifica si la cancha ya ha sido agendada tres veces
  /// en el día especificado y luego verifica si el horario solicitado se
  /// superpone con cualquier otro agendamiento existente. Si la cancha está
  /// disponible, el agendamiento se guarda en el repositorio.
  ///
  /// [booking] es el agendamiento que se desea guardar.
  ///
  /// Retorna un `Future<void>` que se completa cuando el agendamiento
  /// ha sido guardado con éxito.
  ///
  Future<void> saveBooking(Booking booking) async {
    // Los agendamientos actuales para el día
    final List<Booking> dailyBookings =
        await _bookingRepository.getDailyBookingsCount(
            courtName: booking.court.name, date: booking.date);

    // Verifica si la cancha ya ha sido agendada tres veces en ese día
    // y no se superponga el horario
    await _validateDailyBookingsLimit(
        booking: booking, dailyBookings: dailyBookings);

    // Guarda el agendamiento en el repositorio si la cancha está disponible
    return _bookingRepository.saveBooking(booking);
  }

  /// Verifica si la cancha ya ha sido agendada tres veces en el día especificado
  /// y si el horario solicitado se superpone con cualquier otro agendamiento existente.
  ///
  /// [booking] es el agendamiento que se desea verificar.
  /// [dailyBookings] es la lista de agendamientos para la misma cancha en el día especificado.
  ///
  /// Lanza una [CourtBookingLimitReachedException] si la cancha ya ha sido agendada tres veces
  /// en el día especificado o [CourtBookingOverlapException] si el horario solicitado se superpone con
  /// otro agendamiento existente.
  Future<void> _validateDailyBookingsLimit(
      {required Booking booking, required List<Booking> dailyBookings}) async {
    int bookingsOnSameDay = dailyBookings
        .where((element) => element.court.name == booking.court.name)
        .length;
    if (bookingsOnSameDay >= 3) throw CourtBookingLimitReachedException();

    // Verifica si el horario solicitado se superpone con cualquier otro agendamiento existente
    bool isOverlapping =
        dailyBookings.any((b) => b.date.hour == booking.date.hour);

    if (isOverlapping) throw CourtBookingOverlapException();
  }

  /// Elimina un agendamiento del repositorio.
  ///
  /// [bookingId] es el identificador del agendamiento que se desea eliminar.
  ///
  /// Retorna un `Future<void>` que se completa cuando el agendamiento
  /// ha sido eliminado con éxito.
  ///
  /// Lanza una [ArgumentError] si el [bookingId] es nulo o vacío.
  Future<void> deleteBooking(String bookingId) {
    if (bookingId.isEmpty) {
      throw ArgumentError(
          'El identificador del agendamiento no puede ser vacío');
    }
    return _bookingRepository.deleteBooking(bookingId);
  }

  /// Recupera todos los agendamientos del repositorio.
  ///
  /// Retorna un `Future<List<Booking>>` que se completa con una lista de
  /// todos los agendamientos almacenados en el repositorio.
  Future<List<Booking>> fetchAllBookings() {
    return _bookingRepository.fetchAllBookings();
  }

  // Obtiene la probabilidad de lluvia
  Future<Weather> getRainProbability(DateTime date) =>
      _bookingRepository.getRainProbability(date);
}
