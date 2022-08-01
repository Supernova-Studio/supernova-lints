import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';

// ignore: implementation_imports
import 'package:analyzer/src/dart/element/member.dart';

import '../lint_violation_reporter.dart';
import 'lint_rule.dart';

//todo comment - ignored cases
class MissingThisRule extends LintRule {
  const MissingThisRule()
      : super(
          code: "missing_this",
          message: "Obligatory [this] prefix is missing",
        );

  //
  /// Overrides
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  @override
  void onSimpleIdentifier(
      SimpleIdentifier node, LintViolationReporter reporter) {
    _validate(node, reporter);
  }

  //
  /// Validation
  // --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

  void _validate(
    SimpleIdentifier node,
    LintViolationReporter reporter,
  ) {
    final element = node.staticElement;

    final isIgnoredElement =
        element != null ? _isIgnoredElement(element) : false;
    if (isIgnoredElement) return;

    final callsTopLevelMember =
        (element is ExecutableElement) ? element.isStatic : false;
    final callsLocalVariable = element is LocalVariableElement;
    final callsNestedFunction = (element is FunctionElement)
        ? element.declaration.enclosingElement2 == element.enclosingElement2
        : false;

    final hasThis = node.staticType == null;
    final isInvocation = !node.isQualified;
    final isParameter =
        element is ParameterElement || element is TypeParameterElement;
    final isClass = element is ClassElement;

    if (isInvocation &&
        !hasThis &&
        !callsTopLevelMember &&
        !callsLocalVariable &&
        !isParameter &&
        !isClass &&
        !callsNestedFunction) {
      reporter.report(
        this,
        node,
        quickFixName: "Add this.",
        quickFixBuilder: (builder) {
          builder.addInsertion(node.offset, (editBuilder) {
            editBuilder.write("this.");
          });
        },
      );
    }
  }

  bool _isIgnoredElement(Element element) {
    if (element is PropertyAccessorElement) {
      return element.type.returnType.getDisplayString(withNullability: false) ==
          "BuildContext";
    }

    if (element is MethodMember) {
      return element.name == "setState" &&
          element.enclosingElement2.displayName == "State";
    }

    return false;
  }
}
