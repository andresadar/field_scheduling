part of '../booking_messages.dart';

/// Una clase Stateless que representa un BottomSheet utilizado para confirmar
/// la eliminación de una reserva.
///
/// Recibe una [booking] como argumento, que es la reserva que el usuario
/// está considerando eliminar.
class _DeleteBookingBs extends StatelessWidget {
  /// Constructor que toma una reserva específica [booking] como argumento,
  /// que el usuario está considerando eliminar.
  const _DeleteBookingBs({super.key, required this.booking});

  /// La reserva que el usuario está considerando eliminar.
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      /// El contenido principal del BottomSheet.
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// App bar personalizada.
          const AppBarBs(title: "Delete booking"),

          /// Descripción informativa para el usuario.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Está seguro de borrar la reserva de ${booking.userName} para el ${booking.date.ddMMMMHHmm}",
              textAlign: TextAlign.center,
            ),
          ),

          /// Acciones disponibles: Cancelar o Eliminar.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              /// Botón para cancelar la eliminación.
              CupertinoButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text("Cancel")),

              /// Botón para confirmar la eliminación.
              CupertinoButton(
                  color: Theme.of(context).colorScheme.error,
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Delete")),
            ],
          )
        ],
      ),
    );
  }
}
