import 'package:domain/domain.dart';
import 'package:field_scheduling/core/dependency/dependency_injection.dart';
import 'package:field_scheduling/screens/booking/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'my_app.dart';

/// Punto de entrada principal de la aplicación.
///
/// Este método se ejecuta primero cuando se lanza la aplicación.
/// Se encarga de inicializar la configuración necesaria antes de que la aplicación comience a ejecutarse.
void main() async {
  // Asegura que las bindings de los widgets estén inicializadas.
  // Esto es necesario si vas a ejecutar algún código relacionado con los widgets antes de runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa la configuración regional para la formateación de la fecha.
  // Esto establece la configuración regional de la fecha a 'es_CO' (español Colombia).
  initializeDateFormatting('es_CO', null);

  /// Inyección de dependencia.
  ///
  /// Configura las dependencias necesarias para la aplicación.
  await DependencyInjection().setup();

  // Ejecuta la aplicación.
  //
  // MultiProvider permite inyectar múltiples proveedores de estado en la jerarquía de widgets.
  // En este caso, se está proporcionando el [BookingController] a la jerarquía de widgets.
  runApp(
    MultiProvider(
      providers: [
        // Provee una instancia de [BookingController] a la jerarquía de widgets.
        //
        // Cuando se necesite obtener una instancia de [BookingController],
        // Flutter buscará en la jerarquía de widgets el proveedor más cercano y obtendrá la instancia proporcionada aquí.
        ChangeNotifierProvider(
          create: (context) => BookingController(
            bookingUseCase: DependencyInjection().getIt<BookingUseCase>(),
          ),
        )
      ],
      // Especifica el widget raíz de la aplicación.
      child: const MyApp(),
    ),
  );
}
