part of '../notes_view.dart';

MarkdownStyleSheet _markdownStyleSheet() {
  return MarkdownStyleSheet(
    p: const TextStyle(fontFamily: 'Cairo', fontSize: 16, height: 1.6),
    h1: const TextStyle(
      fontFamily: 'Cairo',
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
    h2: const TextStyle(
      fontFamily: 'Cairo',
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    h3: const TextStyle(
      fontFamily: 'Cairo',
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    h4: const TextStyle(fontFamily: 'Cairo'),
    h5: const TextStyle(fontFamily: 'Cairo'),
    h6: const TextStyle(fontFamily: 'Cairo'),
    code: const TextStyle(
      fontFamily: 'JetBrains Mono',
      fontSize: 13,
      backgroundColor: Color(0xFF2D2D2D),
      color: Color(0xFFCE9178),
    ),
    codeblockDecoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(6),
    ),
    blockquoteDecoration: BoxDecoration(
      border: Border(left: BorderSide(color: Colors.blue.shade300, width: 4)),
      color: Colors.blue.withValues(alpha: 0.05),
    ),
    blockquotePadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
  );
}
