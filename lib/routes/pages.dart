import 'package:field_scheduling/routes/routes.dart';
import 'package:flutter/widgets.dart';

import '../screens/booking/booking_screen.dart';
import '../screens/save_booking/save_booking.dart';

/// Clase abstracta que centraliza la definición de las rutas
/// y las páginas asociadas en la aplicación.
abstract class MyPages {
  /// Mapa que asocia los nombres de las rutas con las
  /// funciones de construcción de las páginas correspondientes.
  ///
  /// Las rutas definidas son:
  /// - [MyRoutes.home] que lleva a la página [BookingScreen].
  /// - [MyRoutes.saveBooking] que lleva a la página [SaveBookingScreen].
  static Map<String, Widget Function(BuildContext)> routes = {
    MyRoutes.home: (context) => const BookingScreen(),
    MyRoutes.saveBooking: (context) => const SaveBookingScreen(),
  };
}
