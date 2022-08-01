import 'package:flutter/widgets.dart';

part 'missing_this_example.g.dart';

//
/// Basic cases
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

class Model {
  final String property1;
  final String property2;

  String get property1Getter => property1;

  String get property2Getter => this.property2;

  Model({
    required this.property1,
    required this.property2,
  });

  String firstMethod() {
    return property1 + this.property2;
  }

  String secondMethod() {
    return property1Getter + this.property2Getter;
  }

  String thirdMethod() {
    return firstMethod() + this.firstMethod();
  }

  String fourthMethod(String? arg1, String arg2) {
    return (arg1 ?? "") + arg2;
  }

  bool fifthMethod(Type type) {
    return type == String;
  }

  bool sixthMethod<T>() {
    return T == String;
  }
}

class WrappingModel {
  final Model model;

  WrappingModel(this.model);

  String someMethod1() {
    return model.property1 + topLevelMember + topLevelFunction();
  }

  String someMethod2() {
    final paint = StringBuffer();
    paint
      ..write("test1")
      ..write("test2");
    return paint.toString();
  }
}

String topLevelMember = "";

String topLevelFunction() {
  return topLevelMember;
}

//
/// Inheritance
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

abstract class ParentModel {
  final String parentProperty;

  String get parentGetter;

  ParentModel(this.parentProperty);
}

class ChildModel extends ParentModel {
  @override
  String get parentGetter => parentProperty + this.parentProperty;

  String get childGetter => parentGetter + this.parentGetter;

  ChildModel(super.parentProperty);
}

//
/// Extension
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

class ModelWithExtension {
  String property;

  ModelWithExtension(this.property);

  String member() {
    return extensionProperty + this.extensionProperty;
  }
}

extension ExtendedModelExtendion on ModelWithExtension {
  String get extensionProperty => property + this.property;
}

//
/// Mixin
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

class ModelWithMixin with ModelMixin {
  String property;

  ModelWithMixin(this.property);

  String member() {
    return mixinProperty + this.mixinProperty;
  }
}

mixin ModelMixin on Object {
  String get mixinProperty => toString() + this.toString();
}

//
/// Ignore: setState and context
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void someCallback() {
    context;
    this.context;

    setState(() {});
    this.setState(() {});
  }
}

//
/// Nested function
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

void functionWithNested() {
  void nestedFunction() {}

  nestedFunction();
}
