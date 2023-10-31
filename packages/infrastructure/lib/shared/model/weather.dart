part of infrastructure;

/// Extensión del modelo [Weather] definido en el dominio.
/// Esta clase permite la conversión entre objetos [WeatherModel] y su representación
/// en formato JSON, proporcionando un método para crear una instancia de [WeatherModel]
/// a partir de un mapa JSON y un método para convertir un objeto [WeatherModel] a un mapa JSON.
///
/// La estructura de este modelo contiene tres campos: [location], [description] y [temperatureCelsius],
/// los cuales corresponden a la ubicación, descripción del clima y temperatura en grados Celsius respectivamente.
class WeatherModel extends Weather {
  WeatherModel({
    required super.location,
    required super.description,
    required super.temperatureCelsius,
  });

  /// Crea una instancia de [WeatherModel] a partir de un mapa [json].
  ///
  /// [json]: Un mapa que contiene los datos meteorológicos.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['name'],
      description: json['weather'][0]['description'],
      temperatureCelsius: (json['main']['temp']) - 273.15,
    );
  }

  /// Convierte un objeto [WeatherModel] a un mapa JSON.
  ///
  /// Retorna un mapa que representa la estructura JSON de los datos meteorológicos.
  Map<String, dynamic> toJson() {
    return {
      'name': location,
      'weather': [
        {'description': description}
      ],
      'main': {'temp': temperatureCelsius + 273.15},
    };
  }
}
