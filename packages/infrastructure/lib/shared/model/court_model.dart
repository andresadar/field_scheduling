part of infrastructure;

/// Extensión del modelo [Court] definido en el dominio.
/// Esta clase permite la conversión entre objetos [CourtModel] y su representación
/// en formato JSON, proporcionando un método para crear una instancia de [CourtModel]
/// a partir de un mapa JSON y un método para convertir un objeto [CourtModel] a un mapa JSON.
///
/// La estructura de este modelo es simple y solo contiene un campo [name] que representa
/// el nombre de la cancha.
class CourtModel extends Court {
  CourtModel({required super.name});

  /// Crea una instancia de [CourtModel] a partir de un mapa [json].
  ///
  /// [json]: Un mapa que contiene los datos de la cancha.
  factory CourtModel.fromJson(Map<String, dynamic> json) {
    return CourtModel(name: json["name"]);
  }

  /// Convierte un objeto [CourtModel] a un mapa JSON.
  ///
  /// Retorna un mapa que representa la estructura JSON de la cancha.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["name"] = name;
    return data;
  }
}
