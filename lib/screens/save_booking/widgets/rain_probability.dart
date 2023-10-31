part of '../save_booking.dart';

/// Widget para obtener y mostrar la probabilidad de lluvia.
///
/// Este widget realiza una solicitud para obtener la probabilidad de lluvia para una fecha específica
/// y luego la muestra junto con información adicional del clima.
///
/// La [date] es la fecha para la cual se quiere obtener la probabilidad de lluvia.
/// El [callback] es una función que se llama con la información del clima una vez que se ha obtenido.
class _RainProbability extends StatelessWidget {
  /// Constructor que toma una [date] y un [callback] como argumentos.
  const _RainProbability(
      {super.key, required this.date, required this.callback});

  /// Fecha para la cual se quiere obtener la probabilidad de lluvia.
  final DateTime date;

  /// Función de devolución de llamada que se llama con la información del clima.
  final Function(Weather) callback;

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia del controlador de reservas.
    final bookingProvider = Provider.of<BookingController>(context);

    return FutureBuilder<Weather>(
      // Obtener la probabilidad de lluvia usando el controlador de reservas.
      future: bookingProvider.getRainProbability(date),
      builder: (context, snapshot) {
        // Mostrar un indicador de actividad mientras se espera la respuesta.
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        }

        // No mostrar nada si hay un error.
        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        // Obtener la información del clima del snapshot.
        final weather = snapshot.data!;
        // Llamar al callback con la información del clima.
        callback(weather);

        // Mostrar la descripción del clima, la ubicación y la temperatura.
        return CupertinoListTile(
          title: Text(
            weather.description,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(weather.location),
          additionalInfo: Text("${weather.temperatureCelsius.round()}°"),
        );
      },
    );
  }
}
