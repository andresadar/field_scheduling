import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:field_scheduling/core/extension/date.dart';
import 'package:field_scheduling/routes/routes.dart';
import 'package:field_scheduling/screens/booking/messages/booking_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'booking_controller.dart';

// Widgets
part 'widgets/bookings_list.dart';

/// [BookingScreen] es la pantalla principal para ver y gestionar las reservas.
///
/// Esta pantalla permite a los usuarios ver una lista de reservas,
/// y también proporciona una manera de navegar a la pantalla de creación de reservas.
class BookingScreen extends StatefulWidget {
  /// Constructor para [BookingScreen].
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    /// Observa [BookingController] para obtener el estado actual de las reservas.
    final bookingProvider = context.watch<BookingController>();

    return Scaffold(
      // AppBar
      appBar: AppBar(
        title: const Text("Reservas"),
        actions: [
          IconButton(
            /// Navega a [SaveBookingScreen] cuando se presiona el botón.
            onPressed: () => Navigator.pushNamed(context, MyRoutes.saveBooking),
            icon: const Icon(Icons.add),
          )
        ],
      ),

      body: Builder(
        builder: (context) {
          /// Muestra un indicador de carga mientras se están cargando las reservas.
          if (bookingProvider.isLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          /// Muestra un mensaje de error si no se pudo cargar las reservas.
          if (bookingProvider.bookings == null) {
            return const Center(child: Text("Revisa tu conexión a internet"));
          }

          /// Muestra la lista de reservas una vez que estén cargadas.
          return _BookingsList(bookings: bookingProvider.bookings!);
        },
      ),
    );
  }
}
