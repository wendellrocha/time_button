# Time Button
[![Pub](https://img.shields.io/pub/v/time_button?include_prereleases)](https://pub.dev/packages/date_range_dropdown)

A new Flutter timer button widget. 

## Getting Started

### Installation
Add to `pubspec.yaml` in `dependencies`

```
time_button: ^1.0.0
```

### Usage

```dart

import 'package:time_button/time_button.dart';

TimeButton(
    label: 'Click me',
    timeout: 30,
    toastMessage: 'Click!',
    onPressed: () => print('Click!'),
  );
```

