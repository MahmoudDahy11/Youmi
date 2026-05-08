part of '../notes_view.dart';

class _HintData {
  const _HintData(this.title, this.rows);

  final String title;
  final List<_HintRowData> rows;
}

class _HintRowData {
  const _HintRowData(this.syntax, this.result);

  final String syntax;
  final String result;
}

class _HintsTitle extends StatelessWidget {
  const _HintsTitle({required this.colors});

  final _HintColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.help_outline, size: 13, color: colors.header),
        const SizedBox(width: 5),
        Text(
          'Markdown Guide',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: colors.header,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _HintSectionHeader extends StatelessWidget {
  const _HintSectionHeader({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: color,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _HintSection extends StatelessWidget {
  const _HintSection({
    required this.title,
    required this.rows,
    required this.colors,
  });

  final String title;
  final List<_HintRowData> rows;
  final _HintColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HintSectionHeader(title: title, color: colors.header),
        const SizedBox(height: 5),
        for (final row in rows) _HintRow(row: row, colors: colors),
      ],
    );
  }
}

class _HintRow extends StatelessWidget {
  const _HintRow({required this.row, required this.colors});

  final _HintRowData row;
  final _HintColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          _CodeChip(label: row.syntax, colors: colors, useCodeColor: true),
          const SizedBox(width: 6),
          Text(
            '-> ${row.result}',
            style: TextStyle(fontSize: 14, color: colors.text),
          ),
        ],
      ),
    );
  }
}
