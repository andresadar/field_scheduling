/// Representa un servicio de agendamiento, implementando [BookingDataSource].
/// Esta clase se encarga de gestionar las operaciones relacionadas con las reservas
/// almacenadas localmente mediante [SharedPreferences] y también realiza una solicitud HTTP
/// para obtener la probabilidad de lluvia utilizando la biblioteca [Dio].
///
/// Se define una clave privada [_bookingKey] para almacenar y recuperar las reservas
/// de [SharedPreferences].
part of infrastructure;

class BookingService extends BookingDataSource {
  final SharedPreferences sharedPreferences;
  final Dio dio;

  BookingService({required this.sharedPreferences, required this.dio});

  // Key de los bookings
  final String _bookingKey = "bookingKey";

  /// Elimina una reserva especificada por su [bookingId].
  ///
  /// Se obtiene la lista actual de reservas, se elimina la reserva con el [bookingId]
  /// proporcionado y luego se actualiza la lista de reservas en [SharedPreferences].
  @override
  Future<void> deleteBooking(String bookingId) async {
    try {
      final bookings = await fetchAllBookings();
      bookings.removeWhere((element) => element.id == bookingId);
      final bookingsEncode = jsonEncode(bookings);
      await sharedPreferences.setString(_bookingKey, bookingsEncode);
    } catch (e) {
      rethrow;
    }
  }

  /// Obtiene todas las reservas almacenadas localmente.
  ///
  /// Se recupera la lista de reservas de [SharedPreferences], se decodifica
  /// y se mapea cada objeto JSON a un [BookingModel].
  @override
  Future<List<Booking>> fetchAllBookings() async {
    await sharedPreferences.reload();
    final bookingsList = sharedPreferences.getString(_bookingKey);
    if (bookingsList == null) return [];
    final bookingDecode = jsonDecode(bookingsList);
    final bookings =
        (bookingDecode as List).map((e) => BookingModel.fromJson(e)).toList();
    return bookings;
  }

  /// Obtiene el conteo de reservas para una cancha y fecha especificada.
  ///
  /// [courtName] es el nombre de la cancha, [date] es la fecha de la reserva.
  @override
  Future<List<Booking>> getDailyBookingsCount(
      {required String courtName, required DateTime date}) async {
    final bookings = await fetchAllBookings();
    return bookings
        .where((bk) => (bk.date.year == date.year &&
            bk.date.month == date.month &&
            bk.date.day == date.day))
        .toList();
  }

  /// Guarda una nueva reserva.
  ///
  /// Se obtiene la lista actual de reservas, se añade la nueva reserva y
  /// luego se actualiza la lista de reservas en [SharedPreferences].
  @override
  Future<void> saveBooking(Booking booking) async {
    try {
      final bookings = await fetchAllBookings();
      bookings.add(booking);
      final bookingsEncode = jsonEncode(bookings);
      await sharedPreferences.setString(_bookingKey, bookingsEncode);
    } catch (e) {
      log("$e");
      rethrow;
    }
  }

  /// Obtiene la probabilidad de lluvia para una fecha específica.
  ///
  /// Realiza una solicitud HTTP al servicio de OpenWeatherMap para obtener
  /// la información del clima actual y la probabilidad de lluvia.
  @override
  Future<Weather> getRainProbability(DateTime date) async {
    const double lat = 43.066125257338534;
    const double long = -76.10580284358147;
    const String key = "e615c0a3297e9befec3a6eb9d5bf0649";
    try {
      final response = await dio.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key");
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      log("$e");
      rethrow;
    }
  }
}
