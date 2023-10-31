import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:infrastructure/infrastructure.dart';

/// La clase [DependencyInjection] se encarga de configurar las dependencias
/// necesarias para la aplicación, utilizando el patrón de inyección de dependencias.
/// Utiliza la biblioteca GetIt para registrar y proporcionar las instancias necesarias.
class DependencyInjection {
  /// Singleton instance de [DependencyInjection].
  static final DependencyInjection _singleton = DependencyInjection._internal();

  /// Fábrica que retorna la instancia singleton de [DependencyInjection].
  factory DependencyInjection() {
    return _singleton;
  }

  /// Constructor interno para configurar el singleton.
  DependencyInjection._internal();

  /// Instancia de [GetIt] utilizada para registrar y proporcionar dependencias.
  final GetIt getIt = GetIt.instance;

  /// Configuración inicial de [Dio] con opciones base.
  final _dio = Dio(
    BaseOptions(responseType: ResponseType.json),
  );

  /// Una referencia a [SharedPreferences], será inicializada en [setup].
  late final SharedPreferences _sharedPreferences;

  /// Método [setup] que se encarga de inicializar las dependencias necesarias.
  /// Este método debe ser llamado antes de que la aplicación esté lista para usar.
  ///
  /// 1. Inicializa [_sharedPreferences].
  /// 2. Crea una instancia de [BookingRepositoryImpl] y la configura con [BookingService].
  /// 3. Registra [BookingUseCase] como un singleton en [GetIt].
  Future<void> setup() async {
    // Inicializar el shared preferences
    _sharedPreferences = await SharedPreferences.getInstance();

    // Crear la instancia del repositorio
    final bookingRepositoryImpl = BookingRepositoryImpl(
        bookingDataSource:
            BookingService(sharedPreferences: _sharedPreferences, dio: _dio));

    // Registrar el singleton BookingUseCase
    getIt.registerSingleton<BookingUseCase>(
        BookingUseCase(bookingRepository: bookingRepositoryImpl));
  }
}
