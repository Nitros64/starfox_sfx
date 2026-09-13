# starfox_sfx

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-API%2029%2B-3DDC84?logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-15.0%2B-000000?logo=ios&logoColor=white)
![macOS](https://img.shields.io/badge/macOS-12.0%2B-000000?logo=apple&logoColor=white)
![Bloc](https://img.shields.io/badge/State%20Management-Bloc-blue)
![Audio](https://img.shields.io/badge/Audio-just%5Faudio-green)
![3D](https://img.shields.io/badge/3D-model%5Fviewer%5Fplus-orange)

Aplicación Flutter de sonidos de *Star Fox*. Los recursos necesarios para
compilar (`assets/` y `data/`) se mantienen localmente y no se versionan.

## Capturas de pantalla

![Captura de pantalla 2025-03-11 013616](https://github.com/user-attachments/assets/87e9c87c-4c25-4f08-88be-063140ce289e)
![Captura de pantalla 2025-03-11 015852](https://github.com/user-attachments/assets/409c39bf-60a5-4fcd-a4a3-8ff655ce7d94)
![Captura de pantalla 2025-03-11 015954](https://github.com/user-attachments/assets/ac6faf2b-bc7a-40a9-b3f4-f1a3c1b4604c)

## Preparar una Mac nueva

Instala estos componentes:

- Flutter estable (este proyecto se comprobó con Flutter 3.47.3 / Dart 3.13.3).
- Xcode completo, no solo Command Line Tools. Ábrelo una vez y acepta la
  licencia; después ejecuta `sudo xcodebuild -runFirstLaunch`.
- CocoaPods: `sudo gem install cocoapods` o `brew install cocoapods`.
- Un runtime de simulador iOS desde Xcode, si se usará el simulador.

Verifica la instalación con:

```bash
flutter doctor
```

En un clon nuevo, desde la raíz del proyecto:

```bash
flutter pub get
```

## Compilar

Generar la aplicación para macOS:

```bash
flutter build macos --release
```

El resultado queda en `build/macos/Build/Products/Release/starfox_sfx.app`.

Generar una aplicación para el simulador de iOS:

```bash
flutter build ios --simulator
```

En Android, la aplicación requiere Android 10 (API 29) o posterior. Cuando el
SDK de Android esté instalado, genera el APK con:

```bash
flutter build apk --release
```

Para ejecutarla en un simulador ya iniciado:

```bash
flutter run -d "nombre-o-id-del-simulador"
```

Para compilar en un iPhone físico o distribuir en TestFlight/App Store, abre
`ios/Runner.xcworkspace` en Xcode y configura un equipo de firma de Apple.

## Recursos de audio

Las voces se distribuyen como M4A/AAC para que funcionen en macOS e iOS. No se
incluyen OGG, porque iOS no los reproduce de forma nativa.

## Notas

- Mantén el proyecto fuera de carpetas sincronizadas con iCloud, Dropbox o
  Escritorio si Xcode presenta errores de firma por atributos de Finder.
- Consulta [CORRECCIONES_MACOS.md](CORRECCIONES_MACOS.md) para el historial de
  compatibilidad y una guía reutilizable.
