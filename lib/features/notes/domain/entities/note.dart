class Note {
  final int id;
  final String title;
  final String markdownContent;
  final List<String> tags;
  final bool pinned;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.markdownContent,
    required this.tags,
    required this.pinned,
    required this.createdAt,
    required this.updatedAt,
  });

  Note copyWith({
    int? id,
    String? title,
    String? markdownContent,
    List<String>? tags,
    bool? pinned,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      markdownContent: markdownContent ?? this.markdownContent,
      tags: tags ?? this.tags,
      pinned: pinned ?? this.pinned,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
