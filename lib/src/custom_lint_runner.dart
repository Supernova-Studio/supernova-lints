import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/src/lint_violation_reporter.dart';
import 'package:supernova_lints/src/linter_visitor.dart';
import 'package:supernova_lints/src/rules/missing_this.dart';
import 'package:supernova_lints/src/rules/prefer_double_quotes_except_directives.dart';

const _lintRules = [
  MissingThisRule(),
  PreferDoubleQuotesExceptDirectives(),
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
