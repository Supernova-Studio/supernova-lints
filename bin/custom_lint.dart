import 'dart:isolate';

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/custom_lint_runner.dart';

void main(List<String> args, SendPort sendPort) {
  startPlugin(sendPort, CustomLintRunner());
}
