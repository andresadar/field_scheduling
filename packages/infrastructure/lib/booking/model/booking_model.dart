part of infrastructure;

/// Modelo que extiende de [Booking] para agregar la funcionalidad de
/// serialización y deserialización desde/hacia JSON.
class BookingModel extends Booking {
  BookingModel(
      {required super.id,
      required super.court,
      required super.date,
      required super.userName,
      required super.weather});

  /// Crea una instancia de [BookingModel] a partir de un mapa [json].
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      court: CourtModel.fromJson(json["court"]),
      date: DateTime.parse(json["date"]),
      userName: json["userName"],
      weather: WeatherModel.fromJson(json["weather"]),
    );
  }

  /// Convierte la instancia de [BookingModel] en un mapa que luego
  /// puede ser serializado a JSON.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};

    data["id"] = id;
    data["court"] = (court as CourtModel).toJson();
    data["date"] = date.toIso8601String();
    data["userName"] = userName;
    data["weather"] = (weather as WeatherModel).toJson();

    return data;
  }
}
