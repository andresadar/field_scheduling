import 'package:flutter/material.dart';

/// Un widget de formulario que encapsula un [TextFormField] proporcionando
/// una interfaz simplificada para la entrada de texto.
///
/// [GeneralInput] proporciona una manera conveniente de crear un campo de texto
/// con validación, una pista de texto y un controlador para gestionar el texto.
class GeneralInput extends StatelessWidget {
  /// Constructor para [GeneralInput].
  ///
  /// [controller] es el [TextEditingController] que gestiona el texto del campo.
  /// [hintText] es la pista de texto que se muestra cuando el campo está vacío.
  /// [readOnly] determina si el campo de texto es de sólo lectura.
  /// [onTap] es una función de callback que se invoca cuando el campo de texto es tocado.
  /// [validator] es una función que proporciona validación del texto ingresado.
  const GeneralInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  /// El controlador que gestiona el texto del campo.
  final TextEditingController controller;

  /// La pista de texto mostrada dentro del campo cuando está vacío.
  final String hintText;

  /// Un booleano que determina si el campo de texto es de sólo lectura.
  final bool readOnly;

  /// Una función de callback que se invoca cuando el campo de texto es tocado.
  final void Function()? onTap;

  /// Una función que proporciona validación del texto ingresado.
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      /// Proporciona la validación del texto ingresado utilizando la función de validación proporcionada.
      validator: validator,

      /// Configura la capitalización del texto a capitalizar cada palabra.
      textCapitalization: TextCapitalization.words,

      /// Establece el controlador del texto del campo.
      controller: controller,

      /// Proporciona una función de callback para el evento onTap.
      onTap: onTap,

      /// Configura la apariencia del [TextFormField].
      decoration: InputDecoration(
        /// Configura el borde del campo con una esquina redondeada.
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        /// Establece la pista de texto del campo.
        hintText: hintText,
      ),
    );
  }
}
