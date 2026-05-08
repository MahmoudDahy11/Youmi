part of '../notes_view.dart';

class _MarkdownHintsPanel extends StatelessWidget {
  const _MarkdownHintsPanel({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = _HintColors(isDark);

    return SizedBox(
      width: 220,
      child: ColoredBox(
        color: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF8F8F8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HintsTitle(colors: colors),
              const SizedBox(height: 12),
              for (final section in _hintSections) ...[
                _HintSection(
                  title: section.title,
                  rows: section.rows,
                  colors: colors,
                ),
                const SizedBox(height: 12),
              ],
              _HintSectionHeader(title: 'CODE BLOCKS', color: colors.header),
              const SizedBox(height: 6),
              _CodeBlockHint(colors: colors, isDark: isDark),
              const SizedBox(height: 10),
              _SupportedLanguages(colors: colors),
            ],
          ),
        ),
      ),
    );
  }
}

const _hintSections = [
  _HintData('TEXT', [
    _HintRowData('**text**', 'bold'),
    _HintRowData('*text*', 'italic'),
    _HintRowData('~~text~~', 'strikethrough'),
    _HintRowData('`code`', 'inline code'),
  ]),
  _HintData('HEADINGS', [
    _HintRowData('# H1', 'Heading 1'),
    _HintRowData('## H2', 'Heading 2'),
    _HintRowData('### H3', 'Heading 3'),
  ]),
  _HintData('LISTS', [
    _HintRowData('- item', 'bullet'),
    _HintRowData('1. item', 'numbered'),
    _HintRowData('> text', 'quote'),
  ]),
  _HintData('LINKS', [_HintRowData('[text](url)', 'link')]),
];

const _supportedLanguages = [
  'dart',
  'python',
  'js',
  'ts',
  'kotlin',
  'swift',
  'java',
  'cpp',
  'go',
  'rust',
  'bash',
  'html',
  'css',
  'sql',
  'json',
  'yaml',
];

class _HintColors {
  _HintColors(bool isDark)
      : header = isDark ? Colors.grey.shade500 : Colors.grey.shade600,
        text = isDark ? Colors.grey.shade400 : Colors.grey.shade700,
        code = isDark ? const Color(0xFFCE9178) : const Color(0xFFAF4F1F),
        codeBg = isDark ? const Color(0xFF2D2D2D) : const Color(0xFFEEEEEE);

  final Color header;
  final Color text;
  final Color code;
  final Color codeBg;
}
