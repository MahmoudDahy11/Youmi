part of '../notes_view.dart';

class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final rawLang = element.attributes['class'] ?? '';
    final language = rawLang.startsWith('language-')
        ? rawLang.substring('language-'.length)
        : rawLang.isEmpty
            ? 'plaintext'
            : rawLang;
    final isBlock = rawLang.isNotEmpty || element.textContent.contains('\n');
    if (!isBlock) return null;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF3C3C3C)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CodeTitleBar(language: language),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: HighlightView(
              element.textContent.trimRight(),
              language: language,
              theme: vs2015Theme,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CodeTitleBar extends StatelessWidget {
  const _CodeTitleBar({required this.language});

  final String language;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: const BoxDecoration(
        color: Color(0xFF2D2D2D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _langColor(language),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            language,
            style: const TextStyle(
              color: Color(0xFF858585),
              fontSize: 12,
              fontFamily: 'JetBrains Mono',
            ),
          ),
        ],
      ),
    );
  }
}
