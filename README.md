# Field Scheduling App

Una aplicación Flutter para gestionar agendamientos de canchas de fútbol. La aplicación permite agendar una cancha, visualizar los agendamientos existentes y eliminarlos. Esta aplicación está construida siguiendo los principios de la Clean Architecture, el patrón DDD (Domain Driven Design) y los principios SOLID, utilizando Provider para el manejo del estado.

## Características

1. Cada cancha puede ser agendada máximo tres veces en un día específico.
2. La información del agendamiento se almacena localmente en la aplicación. Si la aplicación es removida del celular, la información se pierde.
3. Las tres canchas que se pueden agendar son la A, B y C.
4. En la pantalla principal se muestran todos los agendamientos ordenados por fecha, donde el primero es el próximo agendamiento. La lista muestra el nombre de la cancha, la fecha y el nombre del usuario que realizó el agendamiento, así como el porcentaje de probabilidad de lluvia para ese día. Cada elemento de la lista tiene un botón para borrar el agendamiento, con una confirmación al hacer clic.
5. Existe un botón que permite agregar un agendamiento. La pantalla para agregar permite seleccionar la cancha, la fecha del agendamiento y el nombre de la persona que realiza el agendamiento, validando la disponibilidad de la cancha para esa fecha. Al seleccionar la fecha, se muestra el porcentaje de probabilidad de lluvia para ese día.
6. La aplicación está escrita en Dart y utiliza Provider para el manejo de estados entre widgets.
7. La arquitectura de desarrollo está basada en Clean Architecture.
8. Diseño simple y amigable.

## Capturas de Pantalla

| ![Screen1](https://i.ibb.co/SPc6WjV/Simulator-Screenshot-i-Phone-14-2023-10-30-at-20-09-55.png) | ![Screen2](https://i.ibb.co/RNXRjJv/Simulator-Screenshot-i-Phone-14-2023-10-30-at-20-10-52.png) |
| ----------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| ![Screen3](https://i.ibb.co/84pdtbZ/Simulator-Screenshot-i-Phone-14-2023-10-30-at-20-09-50.png) |

## Estructura de Carpetas y Modularidad

- lib (Capa de presentación)
  - Core
  - Screens (Pantallas de la app)
  - Routes (Rutas de la app)
  - Widgets (widgets globales)

- Packages
  - domain (Capa de dominio)
    - lib
      - booking (Reservas)
        - model
        - repository
        - use_case
        - exception
      - shared (Compartido en el dominio)
    ...

  - infrastructure (Capa de infraestructura)
    - lib
      - booking
        - model
        - repository_impl
        - service
    ...


La estructura de carpetas elegida para este proyecto se basa en el patrón Domain-Driven Design (DDD) y la arquitectura limpia (Clean Architecture), lo que permite una separación clara y una organización modular del código. Al agrupar el código en paquetes (`packages`), cada aspecto del dominio y la infraestructura puede ser manejado de manera independiente, facilitando la mantenibilidad, la extensibilidad y la prueba del código. La capa de dominio contiene toda la lógica de negocio, mientras que la capa de infraestructura maneja las operaciones de datos y servicios externos. La capa de presentación en `lib` contiene todo el código relacionado con la UI, y se beneficia de la modularidad y la separación de responsabilidades proporcionadas por las otras capas.

## Dependencias Principales

- Provider: Para el manejo del estado de la aplicación.
- Dio: Para las solicitudes de red.
- SharedPreferences: Para el almacenamiento local de datos.

## Cómo Correr el Proyecto

1. Asegúrate de tener Flutter instalado en tu máquina.
2. Clona el repositorio y navega a la carpeta del proyecto.
3. Ejecuta `flutter pub get` para instalar las dependencias.
4. Ejecuta `flutter run` para lanzar la aplicación en un emulador o dispositivo conectado.
