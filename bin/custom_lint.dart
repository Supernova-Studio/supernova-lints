import 'dart:isolate';

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/src/custom_lint_runner.dart';

/// Entrypoint.
///
/// Path to the entrypoint is determined by the custom_lint package.
void main(List<String> args, SendPort sendPort) {
  startPlugin(sendPort, CustomLintRunner());
}
