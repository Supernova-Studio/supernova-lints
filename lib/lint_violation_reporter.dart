import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/rules/lint_rule.dart';

class LintViolationReporter {
  final ResolvedUnitResult _resolvedUnitResult;
  final List<Lint> _reportedViolations = [];

  List<Lint> get reportedViolations => List.unmodifiable(_reportedViolations);

  LintViolationReporter(this._resolvedUnitResult);

  void report(
    LintRule rule,
    AstNode node, {
    String? quickFixName,
    void Function(DartFileEditBuilder builder)? quickFixBuilder,
  }) {
    if (node.isSynthetic) {
      // Synthetic nodes are ignored
      return;
    }

    _reportedViolations.add(
      Lint(
          code: rule.code,
          message: rule.message,
          location: _resolvedUnitResult.lintLocationFromOffset(
            node.offset,
            length: node.length,
          ),
          getAnalysisErrorFixes: quickFixBuilder == null
              ? null
              : (Lint lint) {
                  return _errorFixesStream(
                    lint,
                    quickFixName: "",
                    quickFixBuilder: quickFixBuilder,
                  );
                }),
    );
  }

  Stream<AnalysisErrorFixes> _errorFixesStream(
    Lint lint, {
    String? quickFixName,
    required void Function(DartFileEditBuilder builder) quickFixBuilder,
  }) async* {
    final changeBuilder = ChangeBuilder(session: _resolvedUnitResult.session);
    await changeBuilder.addDartFileEdit(_resolvedUnitResult.path, (builder) {
      quickFixBuilder(builder);
    });

    yield AnalysisErrorFixes(
      lint.asAnalysisError(),
      fixes: [
        PrioritizedSourceChange(
          0,
          changeBuilder.sourceChange..message = quickFixName ?? "Fix",
        ),
      ],
    );
  }
}
