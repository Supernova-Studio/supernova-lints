import 'package:analyzer/dart/ast/ast.dart';
import 'package:supernova_lints/src/lint_violation_reporter.dart';

abstract class LintRule {
  final String code;
  final String message;

  const LintRule({
    required this.code,
    required this.message,
  });

  //
  /// Visit callbacks
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  void onMethodInvocation(MethodInvocation node, LintViolationReporter reporter) {}

  void onPropertyAccess(PropertyAccess node, LintViolationReporter reporter) {}

  void onPrefixedIdentifier(PrefixedIdentifier node, LintViolationReporter reporter) {}

  void onSimpleIdentifier(SimpleIdentifier node, LintViolationReporter reporter) {}

  void onSimpleStringLiteral(SimpleStringLiteral node, LintViolationReporter reporter) {}

  void onStringInterpolation(StringInterpolation node, LintViolationReporter reporter) {}
}
