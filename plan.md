# Personal Productivity Desktop App
## Final Project Plan (Revised)

---

# 1. Project Goal

A personal offline-first desktop productivity application built with Flutter.

The application focuses on:
- Weekly task planning
- Daily execution
- Smart reminders
- Lightweight note-taking
- Fast and distraction-free workflow

The app is designed for personal use first, not as a commercial SaaS product.

---

# 2. Core Principles

## Main Philosophy

The system should be:
- Fast
- Minimal
- Offline-first
- Keyboard-friendly
- Easy to maintain
- Comfortable for long usage sessions
- any file under 120 line 

Avoid:
- Overengineering
- Complex enterprise patterns
- Excessive animations
- Gamification
- Unnecessary features

---

# 3. Tech Stack

## Framework
- Flutter Desktop

## Architecture
- Clean Architecture (lightweight/practical)

## State Management
- Cubit (flutter_bloc)

## Local State
- ValueNotifier for small UI states only

## Database
- Isar Database

## Dependency Injection
- get_it

## Navigation
- go_router 

## Notifications
- flutter_local_notifications

## Notes Rendering
- Markdown-based notes (flutter_markdown)

---

# 4. Coding Rules

## State Rules
- Do not use setState
- Use Cubit for business logic
- Use ValueNotifier only for simple UI state

---

## Validation Rules
Validation must be separated from UI.

```text
core/validation/
```

Validation should:
- Be reusable
- Be readable
- Return clear messages

---

## Code Style Rules

The code must:
- Be beginner-friendly
- Use clear naming
- Avoid advanced unnecessary abstractions
- Avoid overly clever code
- Keep widgets small
- Keep functions short
- Separate logic from UI

---

## Beginner-Friendly Readability Rules

الهدف إن أي حد يفتح الكود يفهمه من غير ما يحتاج يسأل.

### Naming

الأسماء لازم تشرح نفسها بدون comments:

```dart
// ❌ غلط
final d = DateTime.now();
bool chk(Task t) => t.status == 'done';
void upd(String id) { ... }

// ✅ صح
final today = DateTime.now();
bool isTaskCompleted(Task task) => task.status == TaskStatus.completed;
void updateTaskStatus(String taskId) { ... }
```

### Functions

كل function تعمل حاجة واحدة بس، واسمها يقول إيه هي:

```dart
// ❌ غلط — function بتعمل أكتر من حاجة
void handleTask(Task task) {
  task.status = 'done';
  _sendNotification(task);
  _updateDatabase(task);
}

// ✅ صح — كل حاجة لوحدها
void markTaskAsCompleted(Task task) { ... }
void sendCompletionNotification(Task task) { ... }
void saveTaskToDatabase(Task task) { ... }
```

### Widgets

كل widget صغير ومسؤول عن جزء واحد من الـ UI:

```dart
// ❌ غلط — widget ضخم بيعمل كل حاجة
class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 200 سطر كود هنا
      ],
    );
  }
}

// ✅ صح — مقسم لـ widgets صغيرة
class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodayHeader(),
        OverdueTasksList(),
        TodayTasksList(),
      ],
    );
  }
}
```

### No Magic Numbers

أي رقم في الكود لازم يكون ليه اسم:

```dart
// ❌ غلط
if (hour >= 21) { ... }
SizedBox(height: 16);

// ✅ صح
const int eveningReminderHour = 21;
if (hour >= eveningReminderHour) { ... }
SizedBox(height: AppSpacing.medium); // في core/constants/
```

### Comments

اكتب comment لما الـ "ليه" مش واضح — مش الـ "إيه":

```dart
// ❌ مش مفيد — بيقول إيه اللي الكود بيقوله أصلاً
// بنحدث الـ status
task.status = TaskStatus.completed;

// ✅ مفيد — بيشرح السبب
// Flexible tasks فقط تنتقل للغد — Hard tasks تفضل في يومها
if (task.isFlexible) {
  task.scheduledDate = tomorrow;
}
```

### Avoid Clever Code

الكود الواضح أهم من الكود القصير:

```dart
// ❌ clever لكن صعب القراءة
final tasks = allTasks.where((t) => t.scheduledDate.isSameDay(today) && t.status != TaskStatus.completed).toList()..sort((a, b) => a.isFlexible ? 1 : -1);

// ✅ واضح وسهل يتقرأ
final todayTasks = allTasks
    .where((task) => task.scheduledDate.isSameDay(today))
    .where((task) => task.status != TaskStatus.completed)
    .toList();

todayTasks.sort((a, b) => a.isFlexible ? 1 : -1);
```

---

# 5. Project Structure

```text
lib/
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   ├── validation/
│   ├── widgets/
│   ├── services/
│   └── di/
│       └── injection.dart          ← كل get_it registrations هنا
│
├── features/
│   │
│   ├── tasks/
│   │   ├── data/
│   │   │   ├── models/             ← Isar models (@Collection)
│   │   │   └── repositories/      ← TaskRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/           ← Pure Dart Task class
│   │   │   ├── repositories/       ← abstract TaskRepository
│   │   │   └── usecases/           ← GetTodayTasks, AddTask, UpdateTaskStatus ...
│   │   └── presentation/
│   │       ├── cubit/              ← TaskCubit + TaskState
│   │       └── screens/
│   │
│   ├── notes/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/           ← GetNotes, AddNote, UpdateNote, DeleteNote ...
│   │   └── presentation/
│   │       ├── cubit/
│   │       └── screens/
│   │
│   └── settings/
│       ├── data/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── cubit/
│           └── screens/
│
├── app/
│   └── app_router.dart             ← كل go_router routes هنا
│
└── main.dart
```

---

# 6. Navigation

## Router Setup

يتعمل ملف واحد `app_router.dart` جوه `app/`:

```dart
final appRouter = GoRouter(
  initialLocation: '/today',
  routes: [
    GoRoute(path: '/today',    builder: (_, __) => const TodayScreen()),
    GoRoute(path: '/weekly',   builder: (_, __) => const WeeklyScreen()),
    GoRoute(path: '/notes',    builder: (_, __) => const NotesScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
```

---

# 7. Features Overview

## Tasks System

### Home Screen
عند فتح الأب يعرض **مهام النهارده فقط**.

### Weekly Planning
المستخدم يضيف tasks للأسبوع كامل مسبقاً.
كل task بتتبع يوم معين.

---

### Task States

```text
Pending → InProgress → Completed
                     ↘ Overdue → Archived
```

---

### Flexible Tasks

Tasks ممكن تكون:
- **Hard Tasks** — لازم تتعمل في اليوم المحدد
- **Flexible Tasks** — تنتقل تلقائياً للـ next day

---

### Overdue System

**الـ trigger: منتصف الليل تلقائياً**

عند الـ 12:00 AM:
- كل Flexible Task لم تكتمل تصبح Overdue
- تنتقل تلقائياً ليوم الغد
- تظهر في أعلى قائمة الغد

Hard Tasks تصبح Overdue وتبقى في يومها الأصلي.

التنفيذ عبر:
```dart
// في main.dart أو عبر flutter_local_notifications scheduled task
_scheduleOverdueCheck(); // يشتغل عند بداية كل يوم
```

---

# 8. Reminder System

### Daily Reminder

الساعة 9:00 PM:
- الأب يبعت notification للـ evening review

---

### Evening Review

المستخدم يقدر:
- يعلم tasks كـ completed
- ينقل tasks للغد
- يعيد جدولة tasks
- يتجاهل

---

# 9. Notes System

### Philosophy

The notes system is:
- Lightweight
- Comfortable to read
- Fast to edit
- Markdown-based

---

### Features

- Create / Edit / Delete notes
- Search notes
- Pin notes
- Rich Markdown formatting
- Autosave بعد التعديل مباشرة (بدون save button)

---

### Markdown Support — Full Specification

الـ Note editor لازم يدعم الـ Markdown التالي بالكامل:

#### Structure (الهيكل)

```markdown
# عنوان رئيسي (H1)
## عنوان فرعي (H2)
### عنوان أصغر (H3)

وصف عادي تحت أي عنوان
```

#### Text Formatting (تنسيق النص)

```markdown
**نص بالبولد**
*نص مائل (italic)*
~~نص مشطوب~~
`كود inline`
==نص مظلل (highlight)==
```

> ملاحظة: الـ highlight `==text==` يحتاج package يدعمه مثل `flutter_markdown_selectionarea` أو custom extension.

#### Color Support (تلوين النص)

الـ standard Markdown مش بيدعم ألوان — الحل بـ HTML داخل الـ Markdown:

```markdown
<span style="color: red">نص أحمر</span>
<span style="color: #4A90E2">نص أزرق</span>
```

الـ `flutter_markdown` package بيدعم HTML محدود — لازم يتفعّل `selectable: true` وتتضاف `extensionSet` مناسبة، أو يتعمل custom `MarkdownElementBuilder` للـ `<span>`.

#### Lists (القوائم)

```markdown
- عنصر في قائمة
- عنصر تاني
  - قائمة متداخلة

1. عنصر مرقم
2. عنصر تاني
```

#### Code Blocks (الكود)

```markdown
`كود قصير inline`

```dart
// بلوك كود كامل مع تحديد اللغة
void main() {
  print('Hello Flutter');
}
```
```

الـ `flutter_markdown` بيدعم syntax highlighting عبر `flutter_highlight` أو `highlight` package.

#### Blockquote & Divider

```markdown
> ملاحظة مهمة أو اقتباس

---
```

#### Links & Images

```markdown
[نص الرابط](https://example.com)
![وصف الصورة](path/to/image.png)
```

---

### Editor Mode

الـ Note editor هيشتغل بـ **dual-pane أو toggle mode**:

```text
┌─────────────────────────────────────────────┐
│  [Edit]  [Preview]                          │  ← toggle buttons
├─────────────────────────────────────────────┤
│                                             │
│  Edit mode:    Raw Markdown text field      │
│  Preview mode: Rendered Markdown output     │
│                                             │
└─────────────────────────────────────────────┘
```

أو **split view** على الـ Desktop (editor على الشمال، preview على اليمين).

---

### Recommended Package

```yaml
dependencies:
  flutter_markdown: ^0.7.x      # الـ rendering الأساسي
  highlight:        ^0.7.x      # syntax highlighting للكود
```

لو محتاج color support أو highlight extension:
```yaml
  markdown: ^7.x                # Markdown parser للـ custom extensions
```

---

### Desktop Layout

```text
┌─────────────────┬──────────────────────────────────┐
│  Notes List     │  [Edit]  [Preview]               │
│  ─────────────  │  ──────────────────────────────  │
│  Search         │                                  │
│  Pinned         │  Note content here               │
│  All Notes      │  (Markdown rendered or editing)  │
└─────────────────┴──────────────────────────────────┘
```

---

# 10. UI/UX Principles

### Design Style

- Clean, Calm, Minimal
- Comfortable for the eyes
- Home screen = Today's tasks فقط

### Avoid

- Heavy gradients
- Excessive shadows
- Over-animated UI
- Cluttered layouts

### Recommended Fonts

- Inter
- IBM Plex Sans
- Cairo (للـ Arabic support)
- Noto Sans Arabic

---

# 11. Local Database Design

### Tasks Collection

```dart
@Collection()
class TaskModel {
  Id id = Isar.autoIncrement;
  late String title;
  String? description;
  late DateTime scheduledDate;
  late String status;      // pending | inProgress | completed | overdue | archived
  late bool isFlexible;
  late DateTime createdAt;
  DateTime? completedAt;
}
```

### Notes Collection

```dart
@Collection()
class NoteModel {
  Id id = Isar.autoIncrement;
  late String title;
  late String markdownContent;
  List<String> tags = [];
  late bool pinned;
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

### Settings Collection

```dart
@Collection()
class SettingsModel {
  Id id = Isar.autoIncrement;
  late int reminderHour;       // default: 21 (9 PM)
  late String themeMode;       // light | dark | system
  late int weeklyResetDay;     // 0=Monday ... 6=Sunday
}
```

---

# 12. Dependency Injection

كل الـ registrations في ملف واحد `core/di/injection.dart`:

```dart
final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  final isar = await Isar.open([...]);
  getIt.registerSingleton<Isar>(isar);

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<Isar>()),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetTodayTasksUseCase(getIt()));
  getIt.registerLazySingleton(() => AddTaskUseCase(getIt()));

  // Cubits
  getIt.registerFactory(() => TaskCubit(getIt(), getIt()));
}
```

---

# 13. Notifications

### Use Cases

- Evening review reminder (9:00 PM يومياً)
- Overdue task reminder (منتصف الليل)
- Important hard-task reminders

---

# 14. Future Features (Optional)

- Command Palette
- Keyboard shortcuts
- Export / Import
- Backup system
- Search improvements

---

# 15. Features NOT Included in v1

- Authentication
- Cloud sync
- Team collaboration
- AI integrations
- Firebase / Supabase
- Gamification

---

# 16. Development Priority Order

### Phase 1 — Foundation
- Project setup
- Architecture setup (Clean Architecture + get_it)
- `injection.dart`
- Theme
- Navigation (go_router + `app_router.dart`)
- Database setup (Isar)

### Phase 2 — Tasks System
- Task entity + model + repository
- Use cases (CRUD)
- TaskCubit
- Today's home screen
- Weekly planning screen

### Phase 3 — Overdue & Reminders
- Midnight overdue trigger
- Overdue display logic
- Evening review notification
- flutter_local_notifications setup

### Phase 4 — Notes System
- Note entity + model + repository
- Use cases
- NotesCubit
- Notes screen (split layout)
- Markdown rendering
- Search + Pin + Autosave

### Phase 5 — Settings & Polish
- Settings feature (full Clean Architecture)
- Theme switching
- Reminder time customization
- UX improvements

---

# 17. Final Goal

The final application should feel like:
- A personal productivity workspace
- Fast and distraction-free
- Built around real workflow
- Comfortable for daily long-term usage
