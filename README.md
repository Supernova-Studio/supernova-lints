<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Features

Provides custom lint rules broadly used in [supernova.io](https://supernova.io/).

List of currently implemented rules:

- [missing_this](#missing_this)

#### [missing_this]

Requires `this` expression to be placed in all possible cases.

Exception: usages of [State.context](https://api.flutter.dev/flutter/widgets/State/context.html) and [State.setState](https://api.flutter.dev/flutter/widgets/State/setState.html) don't require `this` expression.

GOOD:

```dart
class Model {
  String? property;
  
  String? get getter => this.property;
  
  String? method() {
    return this.property;  
  }
}
```

BAD:

```dart
class Model {
  String? property;
  
  String? get getter => property;

  String? method() {
    return property;
  }
}
```

## Usage

1. Add the following to your `pubspec.yaml` file:

```
dev_dependencies:
  supernova_lints: ^0.0.1
```

2. Add the following to your `analysis_options.yaml` file:

```
analyzer:
  plugins:
    - custom_lint
```

3. Restart your IDE

## Additional information

Feedback and contribution are always welcome on the [GitHub repo](https://github.com/Supernova-Studio/supernova-lints).
