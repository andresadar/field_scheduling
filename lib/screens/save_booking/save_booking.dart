import 'dart:developer';

import 'package:domain/domain.dart';
import 'package:field_scheduling/core/extension/date.dart';
import 'package:field_scheduling/core/extension/time.dart';
import 'package:field_scheduling/widgets/inputs/general_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:provider/provider.dart';

import '../../widgets/inputs/general_drop_down.dart';
import '../booking/booking_controller.dart';

// Widgets
part 'widgets/rain_probability.dart';

/// Pantalla para guardar una nueva reserva.
///
/// Esta pantalla permite al usuario ingresar la información necesaria
/// para crear una nueva reserva.
class SaveBookingScreen extends StatefulWidget {
  const SaveBookingScreen({super.key});

  @override
  State<SaveBookingScreen> createState() => _SaveBookingScreenState();
}

class _SaveBookingScreenState extends State<SaveBookingScreen> {
  // Key del formulario
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Fecha actual
  late final DateTime now;

  // Nombre de usuario
  late final TextEditingController usernameController;
  late final TextEditingController dateController;

  // Cancha seleccionada
  Court? courtSelected;

  // Horario seleccionado
  DateTime? scheduleDateSelected;
  List<TimeOfDay> schedulesTimes = [];
  TimeOfDay? scheduleTimeSelected;

  // Probabilidad de lluvia
  Weather? weather;

  List<TimeOfDay> _createTimeRanges() {
    List<TimeOfDay> timeRanges = [];
    for (int i = 0; i < 24; i += 2) {
      timeRanges.add(TimeOfDay(hour: i, minute: 0));
    }
    return timeRanges;
  }

  @override
  void initState() {
    now = DateTime.now();
    schedulesTimes = _createTimeRanges();

    usernameController = TextEditingController();
    dateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Crear reserva")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 10), child: Text("GENERAL")),

            // Nombre de usuario
            GeneralInput(
                validator: (v) {
                  if (v?.isEmpty ?? false) {
                    return "Por favor ingresa un nombre de usuario";
                  }
                },
                controller: usernameController,
                hintText: "Nombre de usuario"),

            const SizedBox(height: 20),

            // Seleccionar cancha
            GeneralDropDown(
                validator: (v) {
                  if (courtSelected == null) {
                    return "Por favor seleccione una cancha";
                  }
                },
                values: bookingProvider.courts,
                onChanged: (v) => courtSelected = v,
                labelText: "Selecciona una cancha",
                onText: (v) => "Cancha ${v.name}"),

            const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Text("HORARIO")),

            // Seleccionar una fecha
            GeneralInput(
                validator: (v) {
                  if (scheduleDateSelected == null) {
                    return "Por favor seleccione una fecha";
                  }
                },
                controller: dateController,
                hintText: "Selecciona una fecha",
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: now,
                    lastDate: now.add(const Duration(days: 7)),
                  );

                  if (date != null) {
                    dateController.text = date.ddMMMM;
                    scheduleDateSelected = date;
                    setState(() {});
                  }
                }),

            const SizedBox(height: 20),

            // Seleccionar un horario
            GeneralDropDown(
              validator: (v) {
                if (v == null) return "Por favor selecciione un horario";
              },
              values: schedulesTimes,
              onChanged: (v) => scheduleTimeSelected = v,
              labelText: "Selecciona un horario",
              onText: (v) => v.formatTimeRange(context),
            ),

            const SizedBox(height: 20),

            // Probabilidad de lluvia
            if (scheduleDateSelected != null)
              _RainProbability(
                  date: scheduleDateSelected!, callback: (v) => weather = v),

            const SizedBox(height: 20),

            CupertinoButton(
              color: Theme.of(context).colorScheme.primary,
              child: const Text("Guardar"),
              onPressed: () async {
                // Validar formulario
                final bool isValid = formKey.currentState?.validate() ?? false;
                if (!isValid) return;

                // Crear reserva
                try {
                  await bookingProvider
                      .saveBooking(
                        BookingModel(
                          id: "${DateTime.now().microsecondsSinceEpoch}",
                          court: courtSelected!,
                          date: scheduleDateSelected!.copyWith(
                              hour: scheduleTimeSelected!.hour, minute: 0),
                          userName: usernameController.text,
                          weather: weather!,
                        ),
                      )
                      .then((value) => Navigator.pop(context));
                } catch (e) {
                  log("$e");
                  if (!mounted) return;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$e")));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
