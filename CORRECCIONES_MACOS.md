# Correcciones para compilar `starfox_sfx` en macOS

Este documento describe los cambios necesarios para generar la aplicación de macOS con Flutter 3.47 y Xcode 26.

## Entorno que se dejó funcionando

- Flutter 3.47.3 con Dart 3.13.3.
- Xcode 26.6 completo, seleccionado con `xcode-select` y con sus componentes iniciales instalados.
- CocoaPods 1.17.0.
- Compilación de producción mediante `flutter build macos --release`.

Las Command Line Tools de Xcode por sí solas no bastan para compilar aplicaciones Flutter para macOS. Se necesita Xcode completo.

## Recursos que faltaban del repositorio

El repositorio excluye `assets/` y `data/` mediante `.gitignore`, así que un clon normal no puede compilar. Los recursos se recuperaron desde `Downloads/starfox_sfx.rar` y se ubicaron en la raíz del proyecto:

```text
starfox_sfx/
├── assets/
│   ├── 3d/
│   ├── audios/
│   ├── fonts/
│   └── images/
└── data/
    ├── characters.json
    └── characters_secrets.json
```

El archivo RAR usa un formato que `7zz` puede listar pero no extraer. En esta máquina se instaló `unar` con Homebrew y se usó para extraerlo. Hay que comprobar que `assets/` y `data/` queden directamente en la raíz del proyecto, no dentro de una carpeta intermedia creada por el extractor.

La carpeta intermedia `starfox_sfx/` que dejó esa extracción está excluida de Git. Los recursos usados por la aplicación son exclusivamente `assets/` y `data/` de la raíz; se mantienen de forma local y Git los ignora.

## Cambio de compatibilidad de Flutter

Flutter actual ya no genera `AssetManifest.json`; genera `AssetManifest.bin`. El archivo `lib/core/util/character_audio_provider.dart` intentaba leer el manifiesto antiguo y por eso la aplicación mostraba el error de que no encontraba `AssetManifest.json`.

Se reemplazó la lectura manual de JSON por la API actual:

```dart
import 'package:flutter/services.dart' show AssetManifest, rootBundle;

final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
return assetManifest
    .listAssets()
    .where((path) => path.startsWith(directoryPath))
    .toList();
```

También se aplicó `dart format` al archivo.

## Audio en iPhone y iPad

Los diálogos de personajes estaban codificados principalmente como OGG/Vorbis. El reproductor nativo de iOS no reproduce ese formato, por lo que los botones de voz no emitían sonido en el simulador ni en un iPhone.

Se generaron 276 archivos M4A/AAC dentro de las mismas carpetas de `assets/audios/` y se eliminaron sus 276 OGG de origen. `character_audio_provider.dart` solo expone al reproductor extensiones reproducibles en Apple (`.m4a`, `.mp3`, `.aiff` y `.wav`).

La aplicación debe ejecutarse desde la copia local en `~/Developer/starfox_sfx`, fuera de Escritorio/iCloud, para evitar que los metadatos de sincronización rompan el firmado de iOS.

## Visor 3D en iPhone y iPad

`model3d_rotating.dart` iniciaba un temporizador al crear el WebView y ejecutaba JavaScript cada 50 ms para rotar el Arwing. En iOS, el paquete entrega ese controlador antes de que cargue la página que contiene `model-viewer`; por eso aparecía repetidamente `FWFEvaluateJavaScriptError` y el visor podía quedar sin cargar correctamente.

Se eliminó ese temporizador y se usa la rotación nativa de `model-viewer` (`autoRotate`, sin espera y a 30 grados por segundo). También se añadió `io.flutter.embedded_views_preview` en `ios/Runner/Info.plist`, requerido para vistas embebidas en iOS. Este cambio elimina las evaluaciones JavaScript prematuras.

## Android

La aplicación requiere Android 10 (API 29) o posterior. Este mínimo evita los
WebView y dispositivos muy antiguos, sin limitar la aplicación a versiones
recientes de Android. Para compilar se necesita Android Studio con el Android
SDK instalado. Con Flutter 3.47, el wrapper de Gradle debe ser 9.1 o superior,
el Android Gradle Plugin debe ser 9.0.1 o superior y Kotlin debe ser 2.2.20 o
superior. Se actualizaron esas tres herramientas para compatibilidad de
compilación. Los plugins usados requieren NDK 28.2.13676358, por lo que el
proyecto se configura con esa versión en lugar de NDK 27.

## Ajuste de macOS

Flutter/Xcode actualizó el objetivo mínimo de macOS de `10.14` a `12.0` en `macos/Runner.xcodeproj/project.pbxproj`. Este cambio es necesario para compilar con el Xcode instalado.

Flutter también añadió una acción previa en `macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme` para preparar el framework de Flutter antes de compilar mediante Swift Package Manager. Se debe conservar esa acción generada por Flutter.

## Problema de metadatos en carpetas sincronizadas

Cuando el proyecto se compila dentro de Escritorio sincronizado con iCloud u otro proveedor de archivos, macOS puede añadir atributos `com.apple.FinderInfo` a los archivos generados. Xcode rechaza esos atributos durante el firmado y muestra este error:

```text
resource fork, Finder information, or similar detritus not allowed
```

La solución aplicada fue compilar una copia temporal fuera de la carpeta sincronizada, limpiar atributos extendidos con `xattr -cr` y guardar la aplicación final en `~/Applications`. La aplicación resultante se verificó con:

```bash
codesign --verify --deep --strict ~/Applications/starfox_sfx.app
```

La aplicación se firma localmente (ad hoc). Para distribuirla a otros Macs sin avisos de Gatekeeper se requiere un certificado de Apple Developer y notarización.

## Resultado actual

La aplicación corregida está en:

```text
/Users/luisgonzalez/Applications/starfox_sfx.app
```

Se conservó la compilación anterior como respaldo:

```text
/Users/luisgonzalez/Applications/starfox_sfx-before-manifest-fix.app
```

## Prompt reutilizable para otra máquina

Usa este prompt con un agente de código en otra Mac:

```text
Prepara y compila este proyecto Flutter para macOS en modo release, sin ejecutar la aplicación.

1. Inspecciona primero el repositorio y conserva los cambios existentes del usuario.
2. Comprueba que estén instalados Flutter, Xcode completo y CocoaPods. Las Command Line Tools no son suficientes. Si falta Xcode, instala/configura Xcode completo, selecciona /Applications/Xcode.app/Contents/Developer con xcode-select y completa xcodebuild -runFirstLaunch y la licencia.
3. Antes de compilar, verifica que existan en la raíz del proyecto las carpetas assets/ y data/. Si proceden de un RAR, extráelas con una herramienta compatible con RAR5, como unar, y asegúrate de que queden en la raíz. Estos recursos se conservan localmente y Git los ignora.
4. Actualiza lib/core/util/character_audio_provider.dart para no cargar AssetManifest.json. Debe usar AssetManifest.loadFromAssetBundle(rootBundle) y listAssets(), porque las versiones actuales de Flutter generan AssetManifest.bin.
5. Para iOS, inspecciona los formatos de audio. Si las voces son OGG/Vorbis, conviértelas a M4A/AAC con ffmpeg y filtra la lista de voces para usar `.m4a`, `.mp3`, `.aiff` y `.wav`; iOS no reproduce OGG/Vorbis de forma nativa. Elimina los OGG solo después de comprobar que cada uno tiene su M4A equivalente.
6. En iOS, evita ejecutar JavaScript desde `onWebViewCreated` para manipular `model-viewer`: el WebView todavía no ha cargado el documento. Para rotar el modelo usa `autoRotate: true`, `autoRotateDelay: 0` y `rotationPerSecond: '30deg'` de `model_viewer_plus`. Añade `<key>io.flutter.embedded_views_preview</key><true/>` a `ios/Runner/Info.plist`.
7. Ejecuta dart format sobre los archivos Dart modificados.
8. Si Flutter/Xcode exige elevar MACOSX_DEPLOYMENT_TARGET a 12.0, aplica el cambio necesario en el proyecto macOS.
9. Ejecuta flutter pub get y flutter build macos --release. No ejecutes flutter run salvo que se solicite probar el simulador.
10. Si el firmado falla con “resource fork, Finder information, or similar detritus not allowed”, el proyecto está en una carpeta sincronizada. Copia el proyecto a una carpeta temporal local fuera de iCloud/Dropbox/Escritorio sincronizado, usa xattr -cr en esa copia, compila allí y conserva la aplicación final en ~/Applications. Verifica la firma con codesign --verify --deep --strict.
11. Informa la ruta exacta de la aplicación generada, los archivos modificados y cualquier limitación pendiente. No borres archivos del usuario ni sobrescribas una compilación existente sin conservar un respaldo.
```
