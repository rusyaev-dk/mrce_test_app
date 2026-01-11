# Flutter App Template

Production-ready Flutter application template built with Clean Architecture and a modular, feature-oriented structure.

---

## Architecture

The project follows Clean Architecture with a clear separation of responsibilities:

```
PRESENTATION
Widgets, BLoC / Cubit

DOMAIN
Entities, Interactors (Use Cases)

DATA
Repositories, DTOs
```

- Interactors (use cases) are located in the `domain` layer  
- All state management logic lives in the `presentation` layer  
- Strict dependency direction between layers

---

## Key Features

- Modular, feature-based project structure
- Environment support (dev / stage / prod)
- Declarative navigation using `go_router`
- State management with `flutter_bloc` and `bloc_concurrency`
- Localization support (`intl`, `flutter_localizations`)
- Secure and shared storage
- Centralized logging with Talker
- Provider-based dependency injection
- Mobile and Web support

---

## Tech Stack

### State & Architecture
- flutter_bloc / bloc  
- equatable  
- provider  

### Networking & Storage
- dio  
- shared_preferences  
- flutter_secure_storage  

### Routing
- go_router  

### UI & Assets
- flutter_svg  
- lottie  
- flutter_animate  
- cached_network_image  
- google_maps_flutter  

### Configuration & Tooling
- flutter_dotenv  
- uuid  
- talker_flutter  
- talker_dio_logger  
- talker_bloc_logger  

### Code Generation & Testing
- build_runner  
- flutter_gen  
- intl_utils  
- bloc_test  
- mocktail  

---

## Getting Started

Install dependencies and generate code:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

Run the application by environment:

```bash
flutter run --target lib/targets/dev.dart
flutter run --target lib/targets/stage.dart
flutter run --target lib/targets/prod.dart
```

---

## Environments

Environment configuration files are stored in the `env/` directory:

- `.env.dev`
- `.env.stage`
- `.env.prod`

They are loaded using `flutter_dotenv`.

---

## Localization & Assets

```bash
flutter gen-l10n
flutter pub run flutter_gen
```

---

## Debug & Logging

- Built-in debug screen
- Environment, theme, and locale switching
- HTTP, Bloc, and application logs
- Talker used as a centralized logging solution

---

## License

MIT License
