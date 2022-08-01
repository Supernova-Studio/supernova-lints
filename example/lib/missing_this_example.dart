import 'package:flutter/widgets.dart';

part 'missing_this_example.g.dart';

//
/// Basic cases
// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

class Model {
  final String property;

  String get getter => property + this.property;

  Model({
    required this.property,
  });

  String method1() {
    return property + this.property;
  }

  String method2() {
    return getter + this.getter;
  }

  String method3() {
    return method1() + this.method1();
  }

  String method4(String? arg1, String arg2) {
    return (arg1 ?? "") + arg2;
  }

  bool method5(Type type) {
    return type == String;
  }

  bool method6<T>() {
    return T == String;
  }
}

class WrappingModel {
  final Model model;

  WrappingModel(this.model);

  String method1() {
    return model.property + topLevelMember + topLevelFunction();
  }

  String method2() {
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
/// Ignores [setState] and [context]
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
