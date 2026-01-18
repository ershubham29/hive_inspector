# Hive Inspector

Hive Inspector is a lightweight Flutter **DevTool** that helps developers
inspect, search, and debug **Hive / hive_ce boxes** at runtime.
It is designed for **debug and development builds** to quickly view local
database data without creating custom UI.

## ✨ Features

- 📂 View all opened Hive boxes
- 🔍 Search keys and values inside a box
- 🗑 Delete individual entries
- 📊 View box metadata (name & item count)
- ⚡ Works with `hive_ce`
- 🧪 Safe for debug builds
- 🧩 Simple plug-and-play widget

## 📦 Installation

Add this to your `pubspec.yaml`:

```
dependencies:
hive_inspector: ^1.0.0
```

Then Run

`flutter pub get`

## ⚙️ Requirements

* Flutter 3.x+
* `hive_ce`
* `hive_ce_flutter` (for Flutter apps)

## 🚀 Usage (Basic)

### 1️⃣ Initialize Hive

```
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
}
```

### 2️⃣ Open boxes using `HiveService`

> ❗ Important:
> **Inspector can only see boxes opened via `HiveService.openBox()`**

```
import 'package:hive_inspector/src/services/hive_service.dart';
final demoBox = await HiveService.openBox('demoBox');
demoBox.put('name', 'Bookz');
demoBox.put('count', 5);
```

### 3️⃣ Launch Hive Inspector

<pre class="overflow-visible! px-0!" data-start="1685" data-end="1781"><div class="contain-inline-size rounded-2xl corner-superellipse/1.1 relative bg-token-sidebar-surface-primary"><div class="sticky top-[calc(--spacing(9)+var(--header-height))] @w-xl/main:top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-dart"><span>import 'package:hive_inspector/hive_inspector.dart';

runApp(const HiveInspector());</span></code></div></div></pre>

## 🧪 Full Example App

This is exactly how the **example app** inside the package works.

### `example/lib/main.dart`

```
import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:hive_inspector/hive_inspector.dart';
import 'package:hive_inspector/src/services/hive_service.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Hive.initFlutter();
final demoBox = await HiveService.openBox('demoBox');
await HiveService.openBox('userBox');
demoBox.put('name', 'Bookz');
demoBox.put('count', 5);
demoBox.put('data', {'a': 1, 'b': true});
runApp(const HiveInspector());
}
```

Run example:

`flutter run`

## 🔐 Debug-Only Usage (Recommended)

Do **not** ship inspector in production builds.

```
import 'package:flutter/foundation.dart';
if (kDebugMode) {
runApp(const HiveInspector());
}
```

## ⚠️ Important Notes

* Hive does **not** provide a public API to list all boxes
* This package tracks boxes opened via `HiveService`
* Avoid using in release builds
* Do not store secrets in Hive during debugging

## ❌ Limitations

* Closed boxes are not auto-discovered
* Editing values is not supported (yet)
* Read-only debugging tool (safe by design)

## 🧭 Roadmap

* ✏️ Edit values
* 📤 Export box to JSON
* ➕ Open box by name from UI
* 🔒 Password-protected inspector
* 🧩 Flutter DevTools extension

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!
Feel free to open a PR or issue.

## 📄 License

MIT License © 2026
Free to use in personal and commercial projects.

## ⭐ Support

If you find this package useful, please give it a ⭐ on GitHub
and share feedback to help improve it.
