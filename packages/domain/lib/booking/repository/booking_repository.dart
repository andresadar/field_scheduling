part of domain;

/// `BookingRepository` es una clase abstracta que define el contrato para el
/// repositorio de agendamientos. Este repositorio se encarga de la persistencia y
/// recuperación de los agendamientos.
///
/// La idea detrás de esta abstracción es desacoplar la lógica de la aplicación
/// de las operaciones de almacenamiento de datos, lo que permite cambiar la
/// implementación del repositorio sin afectar a otras partes de la aplicación.
abstract class BookingRepository {
  /// Guarda un agendamiento en el repositorio.
  ///
  /// [booking] es el agendamiento que se desea guardar.
  ///
  /// Retorna un `Future<void>` que se completa cuando el agendamiento
  /// ha sido guardado con éxito.
  Future<void> saveBooking(Booking booking);

  /// Elimina un agendamiento del repositorio.
  ///
  /// [bookingId] es el identificador del agendamiento que se desea eliminar.
  ///
  /// Retorna un `Future<void>` que se completa cuando el agendamiento
  /// ha sido eliminado con éxito.
  Future<void> deleteBooking(String bookingId);

  /// Recupera todos los agendamientos del repositorio.
  ///
  /// Retorna un `Future<List<Booking>>` que se completa con una lista de
  /// todos los agendamientos almacenados en el repositorio.
  Future<List<Booking>> fetchAllBookings();

  /// Obtiene la cantidad de agendamientos para una cancha en una fecha específica.
  ///
  /// [courtId] es el identificador de la cancha.
  /// [date] es la fecha para la cual se desean contar los agendamientos.
  ///
  /// Retorna un `Future<int>` que se completa con la cantidad de agendamientos
  /// para la cancha especificada en la fecha especificada.
  Future<List<Booking>> getDailyBookingsCount(
      {required String courtName, required DateTime date});

  /// Obtiene la probabilidad de lluvia para una fecha específica.
  ///
  /// [date] es la fecha para la cual se desea obtener la probabilidad de lluvia.
  ///
  /// Retorna un `Future<Weather>` que se completa con la información del pronóstico
  /// del tiempo para la fecha especificada.
  Future<Weather> getRainProbability(DateTime date);
}
