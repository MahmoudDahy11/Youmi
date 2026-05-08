part of '../notes_view.dart';

class _EditorBody extends StatelessWidget {
  const _EditorBody({
    required this.controller,
    required this.isMobile,
    required this.isDark,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isMobile;
  final bool isDark;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(
              fontSize: isMobile ? 14 : 15,
              fontFamily: 'JetBrains Mono',
              color: isDark ? Colors.white : Colors.black,
              height: 1.6,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(isMobile ? 12 : 16),
              hintText: 'Start writing...',
              hintStyle: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 14,
                color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        if (!isMobile) ...[
          VerticalDivider(
            width: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade300,
          ),
          _MarkdownHintsPanel(isDark: isDark),
        ],
      ],
    );
  }
}

class _MarkdownPreview extends StatelessWidget {
  const _MarkdownPreview({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (content.trim().isEmpty) return _EmptyPreviewHint(isDark: isDark);

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      child: Directionality(
        textDirection: _detectTextDirection(content),
        child: MarkdownBody(
          data: _preserveLineBreaks(_convertCustomSyntax(content)),
          selectable: true,
          softLineBreak: true,
          fitContent: false,
          styleSheet: _markdownStyleSheet(),
          builders: {'code': CodeBlockBuilder()},
          extensionSet: md.ExtensionSet.gitHubFlavored,
        ),
      ),
    );
  }
}
