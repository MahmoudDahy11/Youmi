part of '../notes_view.dart';

class _CodeChip extends StatelessWidget {
  const _CodeChip({
    required this.label,
    required this.colors,
    this.useCodeColor = false,
  });

  final String label;
  final _HintColors colors;
  final bool useCodeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: colors.codeBg,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'JetBrains Mono',
          color: useCodeColor ? colors.code : colors.text,
        ),
      ),
    );
  }
}

class _CodeBlockHint extends StatelessWidget {
  const _CodeBlockHint({required this.colors, required this.isDark});

  final _HintColors colors;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDark ? const Color(0xFF3C3C3C) : const Color(0xFFCCCCCC),
        ),
      ),
      child: Text(
        '#dart\nvoid main() {}\n##',
        style: TextStyle(
          fontSize: 11,
          fontFamily: 'JetBrains Mono',
          color: colors.code,
          height: 1.6,
        ),
      ),
    );
  }
}
