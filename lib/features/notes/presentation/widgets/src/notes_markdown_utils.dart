part of '../notes_view.dart';

String _preserveLineBreaks(String text) {
  final buffer = StringBuffer();
  final lines = text.split('\n');
  var inCodeBlock = false;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    final trimmed = line.trim();
    if (trimmed.startsWith('```')) inCodeBlock = !inCodeBlock;

    buffer.write(line);
    if (i == lines.length - 1) continue;

    final nextLine = lines[i + 1].trim();
    final hasBlankLine = trimmed.isEmpty || nextLine.isEmpty;
    buffer.write(inCodeBlock || hasBlankLine ? '\n' : '\n\n');
  }

  return buffer.toString();
}

String _convertCustomSyntax(String text) {
  final openReg = RegExp(r'^#([a-zA-Z][a-zA-Z0-9_]*)$');
  final buffer = StringBuffer();

  for (final line in text.split('\n')) {
    final trimmed = line.trim();
    final openMatch = openReg.firstMatch(trimmed);

    if (openMatch != null) {
      buffer.writeln('```${openMatch.group(1)}');
    } else if (trimmed == '##') {
      buffer.writeln('```');
    } else {
      buffer.writeln(line);
    }
  }

  return buffer.toString();
}

TextDirection _detectTextDirection(String text) {
  if (text.trim().isEmpty) return TextDirection.ltr;

  final codeUnit = text.trimLeft()[0].codeUnitAt(0);
  final isArabic = (codeUnit >= 0x0600 && codeUnit <= 0x06FF) ||
      (codeUnit >= 0x0750 && codeUnit <= 0x077F);
  return isArabic ? TextDirection.rtl : TextDirection.ltr;
}
