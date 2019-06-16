import 'package:dynamic_forms/dynamic_forms.dart';
import 'package:dynamic_forms/src/form_elements/form_elements.dart';
import 'package:dynamic_forms/src/form_manager/form_item_value.dart';
import 'package:dynamic_forms/src/iterators/form_element_iterator.dart';
import 'package:dynamic_forms/src/iterators/form_element_value_iterator.dart';
import 'package:expression_language/expression_language.dart';

class FormManager {
  Form form;

  Map<String, FormElement> formElementMap;

  Map<String, Validation> formValidations;

  List<PrimitiveMutableElementValue> primitiveMutableValues;

  FormManager(this.form, this.formElementMap, this.formValidations,
      this.primitiveMutableValues);

  bool get isFormValid {
    return formValidations.values.every((v) => (v.isValid.value));
  }

  List<FormItemValue> getFormData() {
    List<FormItemValue> result = List<FormItemValue>();
    var formElements = getFormElementIterator<FormElement>(form).toList();

    print("Form result:");

    formElements.forEach((fe) {
      var properties = fe.getProperties();
      properties.forEach((name, propVal) {
        if (propVal is PrimitiveMutableElementValue &&
            !(propVal is ElementValue<ExpressionProviderElement>) &&
            !(propVal is ElementValue<List<ExpressionProviderElement>>)) {
          result.add(FormItemValue(fe.id, name, propVal.value.toString()));
          print("${fe.id} ${name} ${propVal.value.toString()}");
        }
      });
    });

    return result;
  }

  void resetForm() {
    primitiveMutableValues.forEach((pmv) => pmv.resetValue());
  }

  void changeValue<T>(T value, String formElementId, [String propertyName]) {
    if (!formElementMap.containsKey(formElementId)) {
      print(
          "Value cannot be changed because element $formElementId is not present");
      return;
    }
    var formElement = formElementMap[formElementId];
    var elementValue = formElement.getElementValue(propertyName);
    var mutableValue = elementValue as PrimitiveMutableElementValue<T>;
    if (mutableValue == null) {
      print(
          "Value cannot be changed because element $formElementId is not mutable");
      return;
    }
    mutableValue.setValue(value);

    return;
  }

  void _buildCloneableExpressions(
      Form form, Map<String, FormElement> expressionProviderElementMap) {
    var formElementExpressions =
        getFormElementValueIterator<CloneableExpressionElementValue>(form);

    for (var expressionValue in formElementExpressions) {
      expressionValue.buildExpression(expressionProviderElementMap);
    }
  }
}