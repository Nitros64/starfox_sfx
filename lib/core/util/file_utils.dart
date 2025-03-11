
String cleanFileName(String filePath) {
  // Expresión regular para eliminar la ruta y la extensión
  final RegExp regex = RegExp(r'assets/audios/[^/]+/[^/]+/|\.ogg|\.mp3|\.wav');
  
  // Reemplaza las coincidencias con una cadena vacía
  return filePath.replaceAll(regex, '');
}

String getFileExtension(String filePath) {
  return filePath.split('.').last;
}

String getFileName(String filePath) {
  return filePath.split('/').last.split('.').first;
}

String removeUnderscore(String underscore){
  return underscore.replaceAll('_', ' ');
}

String getCleanName(String name){
  return removeUnderscore(name.split('/').last.split('.').first);
}