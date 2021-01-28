# Time Button
[![Pub](https://img.shields.io/pub/v/flutter_time_button?include_prereleases)](https://pub.dev/packages/flutter_time_button)

A new Flutter timer button widget. 

## Getting Started

### Installation
Add to `pubspec.yaml` in `dependencies`

```
time_button: ^1.0.0
```

### Usage

```dart

import 'package:time_button/flutter_time_button.dart';

TimeButton(
    label: 'Click me',
    timeout: 30,
    toastMessage: 'Click!',
    onPressed: () => print('Click!'),
  );
```

