import 'package:field_scheduling/routes/pages.dart';
import 'package:field_scheduling/routes/routes.dart';
import 'package:flutter/material.dart';

/// La clase `MyApp` es el widget raíz de la aplicación.
///
/// Esta clase extiende `StatelessWidget` ya que no mantiene ningún estado interno.
/// El método `build` devuelve un `MaterialApp` que es el punto de entrada para
/// la estructura visual y de navegación de la aplicación.
class MyApp extends StatelessWidget {
  /// Constructor de la clase `MyApp`.
  ///
  /// Se le puede pasar una [Key] como parámetro opcional.
  const MyApp({super.key});

  /// Método que se encarga de construir el widget.
  ///
  /// Este método retorna un `MaterialApp` que define la configuración inicial
  /// de la aplicación como el título, la ruta inicial, las rutas de las páginas,
  /// y el tema oscuro.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Field scheduling', // Título de la aplicación.
      initialRoute: MyRoutes
          .home, // Ruta inicial que se mostrará al iniciar la aplicación.
      routes: MyPages.routes, // Definición de las rutas de la aplicación.
      darkTheme: ThemeData.dark(), // Tema oscuro de la aplicación.
      themeMode: ThemeMode.dark, // Modo del tema, en este caso, oscuro.
    );
  }
}
