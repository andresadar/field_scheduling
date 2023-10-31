import 'package:flutter/material.dart';

/// Un widget de formulario que muestra una lista desplegable (dropdown) de valores.
///
/// [GeneralDropDown] es un widget personalizado que encapsula un [DropdownButtonFormField]
/// para proporcionar una interfaz uniforme para mostrar una lista desplegable de valores.
/// También proporciona validación y un método de retorno de llamada para manejar
/// el cambio de valor seleccionado.
class GeneralDropDown<T> extends StatefulWidget {
  /// El valor inicial que debe estar seleccionado en la lista desplegable.
  final T? initialValue;

  /// La lista de valores que se mostrarán en la lista desplegable.
  final List<T> values;

  /// Una función de retorno de llamada que se invoca cuando se selecciona un nuevo valor.
  final Function(T)? onChanged;

  /// El texto que se mostrará como etiqueta del campo de formulario.
  final String labelText;

  /// El color de fondo del campo de formulario.
  final Color? fillColor;

  /// Una función que proporciona la representación de texto de un valor.
  final String Function(T) onText;

  /// Una función que proporciona la validación del valor seleccionado.
  final String? Function(T?)? validator;

  /// Constructor para [GeneralDropDown].
  const GeneralDropDown({
    super.key,
    this.initialValue,
    required this.values,
    required this.onChanged,
    required this.labelText,
    this.fillColor,
    required this.onText,
    this.validator,
  });

  @override
  State<GeneralDropDown<T>> createState() => _GeneralDropDownState<T>();
}

class _GeneralDropDownState<T> extends State<GeneralDropDown<T>> {
  /// El valor actualmente seleccionado en la lista desplegable.
  T? _currentValue;

  @override
  void initState() {
    /// Inicializa el valor actual con el valor inicial proporcionado.
    _currentValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      /// Permite que el [DropdownButtonFormField] se expanda para llenar el espacio disponible.
      isExpanded: true,

      /// Proporciona la validación del valor seleccionado utilizando la función de validación proporcionada.
      validator: widget.validator,

      /// Configura la apariencia del [DropdownButtonFormField].
      decoration: InputDecoration(
        labelText: widget.labelText,
        fillColor: widget.fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),

      /// Establece el valor actualmente seleccionado.
      value: _currentValue,

      /// Genera los elementos de la lista desplegable a partir de la lista de valores proporcionada.
      items: widget.values.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
            value: value,
            child: Text(widget.onText(value),
                style: Theme.of(context).textTheme.bodySmall));
      }).toList(),

      /// Maneja el cambio de valor seleccionado.
      onChanged: widget.onChanged == null
          ? null
          : (T? newValue) {
              if (newValue != null) {
                /// Actualiza el estado con el nuevo valor seleccionado y
                /// invoca la función de retorno de llamada proporcionada.
                setState(() => _currentValue = newValue);
                widget.onChanged!(newValue);
              }
            },
    );
  }
}
