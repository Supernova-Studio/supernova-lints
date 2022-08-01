import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/rules/missing_this.dart';

import 'lint_violation_reporter.dart';
import 'linter_visitor.dart';

final _lintRules = const [
  MissingThisRule(),
];

class CustomLintRunner extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult resolvedUnitResult) async* {
    final unit = resolvedUnitResult.unit;
    final fullPath = resolvedUnitResult.path;

    // Generated files are ignored
    if (fullPath.endsWith(".g.dart") || fullPath.endsWith("_mock.dart")) return;

    // Dependencies are ignored
    if (fullPath.contains("/.symlinks/plugins")) return;

    final violationReporter = LintViolationReporter(resolvedUnitResult);
    unit.accept(LinterVisitor(_lintRules, violationReporter));

    for (final reportedViolation in violationReporter.reportedViolations) {
      yield reportedViolation;
    }
  }
}
