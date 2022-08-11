import 'package:analyzer/dart/ast/ast.dart';

import '../lint_violation_reporter.dart';
import 'lint_rule.dart';

// TODO Readme
/// Requires double quotes for string literals.
///
/// Exception: directives (import/part/part of/export/library) can use single quotes.
class PreferDoubleQuotesExceptDirectives extends LintRule {
  const PreferDoubleQuotesExceptDirectives()
      : super(
          code: "prefer_double_quotes_except_directives",
          message: "Prefer double quotes",
        );

  //
  /// Overrides
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  @override
  void onSimpleStringLiteral(SimpleStringLiteral node, LintViolationReporter reporter) {
    _validate(node, reporter);
  }

  @override
  void onStringInterpolation(StringInterpolation node, LintViolationReporter reporter) {
    _validate(node, reporter);
  }

  //
  /// Validation
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  void _validate(
    SingleStringLiteral node,
    LintViolationReporter reporter,
  ) {
    if (_isIgnoredLiteral(node)) return;

    if (node.isSingleQuoted) {
      reporter.report(this, node);
    }
  }

  bool _isIgnoredLiteral(SingleStringLiteral node) {
    return node.parent is Directive;
  }
}
