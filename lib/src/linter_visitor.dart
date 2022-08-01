import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'lint_violation_reporter.dart';
import 'rules/lint_rule.dart';

/// Visitor that allows [LintRule] entities to subscribe to certain AST nodes.
class LinterVisitor extends RecursiveAstVisitor<void> {
  final Iterable<LintRule> rules;
  final LintViolationReporter _violationReporter;

  LinterVisitor(
    this.rules,
    this._violationReporter,
  );

  //
  /// Visit overrides
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  @override
  void visitMethodInvocation(MethodInvocation node) {
    for (final rule in rules) {
      rule.onMethodInvocation(node, _violationReporter);
    }

    super.visitMethodInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    for (final rule in rules) {
      rule.onPropertyAccess(node, _violationReporter);
    }

    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    for (final rule in rules) {
      rule.onPrefixedIdentifier(node, _violationReporter);
    }

    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    for (final rule in rules) {
      rule.onSimpleIdentifier(node, _violationReporter);
    }

    super.visitSimpleIdentifier(node);
  }
}
