import 'package:flutter/material.dart';

/// Un widget personalizado para una barra de aplicación (AppBar) con un botón de cancelar.
///
/// [AppBarBs] es una barra de aplicación personalizada que proporciona un título opcional
/// y un botón de cancelar que cierra la pantalla actual cuando se presiona.
class AppBarBs extends StatelessWidget {
  /// Constructor para [AppBarBs].
  ///
  /// [title] es el título opcional para mostrar en la barra de aplicación.
  const AppBarBs({super.key, this.title});

  /// El título opcional para mostrar en la barra de aplicación.
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      /// Si [title] no es null, crea un widget [Text] con [title] como contenido,
      /// de lo contrario, deja el título de la barra de aplicación como null.
      title: title != null ? Text(title!) : null,

      actions: [
        IconButton(
          /// Cierra la pantalla actual cuando se presiona el botón.
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.cancel_outlined),
        )
      ],
    );
  }
}
