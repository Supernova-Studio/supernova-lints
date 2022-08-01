import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_core.dart';
import 'package:analyzer_plugin/utilities/change_builder/change_builder_dart.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:supernova_lints/rules/lint_rule.dart';

//todo rename to storage?
class LintViolationReporter {
  final ResolvedUnitResult resolvedUnitResult;
  final List<Lint> _reportedViolations = [];

  List<Lint> get reportedViolations => List.unmodifiable(_reportedViolations);

  LintViolationReporter(this.resolvedUnitResult);

  void report(
    LintRule rule,
    SyntacticEntity entity, {
    String? quickFixName,
    void Function(DartFileEditBuilder builder)? quickFixBuilder,
  }) {
    //todo ignore sinthetic
    _reportedViolations.add(
      Lint(
          code: rule.code,
          message: rule.message,
          location: resolvedUnitResult.lintLocationFromOffset(
            entity.offset,
            length: entity.length,
          ),
          //todo extract
          getAnalysisErrorFixes: quickFixBuilder == null
              ? null
              : (Lint lint) async* {
                  final changeBuilder =
                      ChangeBuilder(session: resolvedUnitResult.session);
                  await changeBuilder.addDartFileEdit(resolvedUnitResult.path,
                      (builder) {
                    quickFixBuilder(builder);
                  });

                  yield AnalysisErrorFixes(
                    lint.asAnalysisError(),
                    fixes: [
                      PrioritizedSourceChange(
                        0,
                        changeBuilder.sourceChange
                          ..message = quickFixName ?? "",
                      ),
                    ],
                  );
                }),
    );
  }
}
