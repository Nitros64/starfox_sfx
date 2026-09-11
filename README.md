# starfox_sfx

Aplicación Flutter de sonidos de *Star Fox*. Los recursos necesarios para
compilar (`assets/` y `data/`) se mantienen localmente y no se versionan.

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
