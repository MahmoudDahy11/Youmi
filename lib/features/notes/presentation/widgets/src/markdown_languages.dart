part of '../notes_view.dart';

class _SupportedLanguages extends StatelessWidget {
  const _SupportedLanguages({required this.colors});

  final _HintColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Supported languages:',
          style: TextStyle(
            fontSize: 10,
            color: colors.header,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            for (final lang in _supportedLanguages)
              _CodeChip(label: lang, colors: colors),
          ],
        ),
      ],
    );
  }
}
