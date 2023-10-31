part of '../booking_screen.dart';

class _BookingsList extends StatefulWidget {
  final List<Booking> bookings;

  const _BookingsList({super.key, required this.bookings});

  @override
  State<_BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<_BookingsList> {
  @override
  Widget build(BuildContext context) {
    final groupedBookings = filterAndGroupBookings(widget.bookings);

    if (groupedBookings.isEmpty) {
      return const Center(child: Text("Sin reservas disponibles"));
    }

    // Convertir las claves del mapa a una lista y ordenarlas
    final sortedKeys = groupedBookings.keys.toList()
      ..sort(
          (a, b) => a.compareTo(b)); // Ordenar las fechas en orden ascendente

    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final date =
            sortedKeys[index]; // Acceder a la fecha en el orden correcto
        final dateBookings = groupedBookings[date]!;

        return CupertinoListSection(
          backgroundColor: Colors.transparent,
          header: Text(
            DateFormat('d MMMM', 'es').format(date), // Formato de la fecha
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: List.generate(
            dateBookings.length,
            (index) {
              final booking = dateBookings[index];

              return Dismissible(
                key: Key(booking.id), // Una clave única para este elemento
                direction: DismissDirection
                    .endToStart, // Deslizar hacia la izquierda para eliminar
                confirmDismiss: (direction) async {
                  final bool? isDismissed =
                      await BookingMessages.showDeleteBooking(context,
                          booking: booking);

                  if (isDismissed == true) {
                    await _deleteBooking(booking);
                    setState(() {});
                  }

                  return isDismissed;
                },
                background: Container(
                  color: Theme.of(context).colorScheme.error,
                ), // Fondo rojo al deslizar
                child: CupertinoListTile(
                  backgroundColor: Colors.white24,
                  title: Text(
                    'Cancha ${booking.court.name} - ${booking.userName} - ${booking.date.hhmm}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                      '${booking.weather.temperatureCelsius.round()}° - ${booking.weather.description}'),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _deleteBooking(Booking booking) async {
    await context.read<BookingController>().deleteBooking(booking.id).then(
        (value) =>
            widget.bookings.removeWhere((element) => element.id == booking.id));
  }

  Map<DateTime, List<Booking>> filterAndGroupBookings(List<Booking> bookings) {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    final Map<DateTime, List<Booking>> groupedBookings = {};

    for (final booking in bookings) {
      final bookingDate =
          DateTime(booking.date.year, booking.date.month, booking.date.day);
      if (!(bookingDate.isBefore(todayDate))) {
        if (!groupedBookings.containsKey(bookingDate)) {
          groupedBookings[bookingDate] = [];
        }
        groupedBookings[bookingDate]?.add(booking);
      }
    }

    return groupedBookings;
  }
}
