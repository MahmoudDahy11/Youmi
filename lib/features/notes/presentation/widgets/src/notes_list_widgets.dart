part of '../notes_view.dart';

class _NotesSearchHeader extends StatelessWidget {
  const _NotesSearchHeader({
    required this.controller,
    required this.count,
    required this.isDark,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  final TextEditingController controller;
  final int count;
  final bool isDark;
  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return Container(
      color: isDark ? Colors.grey.shade900 : Colors.grey.shade100,
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Notes',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Search notes...',
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: searchQuery.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      tooltip: 'Clear search',
                      onPressed: onClear,
                    ),
              isDense: true,
              filled: true,
              fillColor: isDark ? Colors.grey.shade800 : Colors.white,
              border: _inputBorder(borderColor),
              enabledBorder: _inputBorder(borderColor),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 14,
            ),
            textInputAction: TextInputAction.search,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}

class _NotesSectionLabel extends StatelessWidget {
  const _NotesSectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
