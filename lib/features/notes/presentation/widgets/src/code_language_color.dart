part of '../notes_view.dart';

Color _langColor(String lang) {
  switch (lang.toLowerCase()) {
    case 'dart':
      return const Color(0xFF00B4AB);
    case 'python':
      return const Color(0xFF3572A5);
    case 'javascript':
    case 'js':
      return const Color(0xFFF1E05A);
    case 'typescript':
    case 'ts':
      return const Color(0xFF2B7489);
    case 'kotlin':
      return const Color(0xFFA97BFF);
    case 'swift':
      return const Color(0xFFFFAC45);
    case 'java':
      return const Color(0xFFB07219);
    case 'cpp':
    case 'c':
      return const Color(0xFF555555);
    case 'bash':
    case 'sh':
      return const Color(0xFF89E051);
    case 'html':
      return const Color(0xFFE44B23);
    case 'css':
      return const Color(0xFF563D7C);
    case 'go':
      return const Color(0xFF00ADD8);
    case 'rust':
      return const Color(0xFFDEA584);
    case 'json':
    case 'yaml':
    case 'xml':
      return const Color(0xFF888888);
    default:
      return const Color(0xFF858585);
  }
}
