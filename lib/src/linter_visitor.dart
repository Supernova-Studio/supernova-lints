import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:supernova_lints/src/lint_violation_reporter.dart';
import 'package:supernova_lints/src/rules/lint_rule.dart';

/// Visitor that allows [LintRule] entities to subscribe to certain AST nodes.
class LinterVisitor extends RecursiveAstVisitor<void> {
  final Iterable<LintRule> _rules;
  final LintViolationReporter _violationReporter;

  LinterVisitor(
    this._rules,
    this._violationReporter,
  );

  //
  /// Visit overrides
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  @override
  void visitMethodInvocation(MethodInvocation node) {
    for (final rule in _rules) {
      rule.onMethodInvocation(node, _violationReporter);
    }

    super.visitMethodInvocation(node);
  }

  @override
  void visitPropertyAccess(PropertyAccess node) {
    for (final rule in _rules) {
      rule.onPropertyAccess(node, _violationReporter);
    }

    super.visitPropertyAccess(node);
  }

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    for (final rule in _rules) {
      rule.onPrefixedIdentifier(node, _violationReporter);
    }

    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    for (final rule in _rules) {
      rule.onSimpleIdentifier(node, _violationReporter);
    }

    super.visitSimpleIdentifier(node);
  }

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    for (final rule in _rules) {
      rule.onSimpleStringLiteral(node, _violationReporter);
    }

    super.visitSimpleStringLiteral(node);
  }

  @override
  void visitStringInterpolation(StringInterpolation node) {
    for (final rule in _rules) {
      rule.onStringInterpolation(node, _violationReporter);
    }

    super.visitStringInterpolation(node);
  }
}
