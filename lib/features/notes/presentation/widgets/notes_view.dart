import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/vs2015.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:markdown/markdown.dart' as md;

import '../../domain/entities/note.dart';
import '../cubit/notes_cubit.dart';

part 'src/code_block_builder.dart';
part 'src/code_language_color.dart';
part 'src/editor_toolbar.dart';
part 'src/empty_preview_hint.dart';
part 'src/markdown_hints_panel.dart';
part 'src/markdown_hints_support.dart';
part 'src/markdown_hints_widgets.dart';
part 'src/markdown_languages.dart';
part 'src/markdown_preview.dart';
part 'src/markdown_styles.dart';
part 'src/note_editor_panel.dart';
part 'src/notes_list_panel.dart';
part 'src/notes_list_tiles.dart';
part 'src/notes_list_widgets.dart';
part 'src/notes_markdown_utils.dart';
part 'src/notes_view_layout.dart';
