import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'person.freezed.dart';

@freezed
class Person with _$Person {
  factory Person({
    required String name,
    List<String>? emails,
  }) = _Person;
}

// class Person {
//   String name;
//   List<String>? emails;

//   Person({this.name = '', this.emails});
// }

FormGroup personForm(Person person) {
  return FormGroup({
    'name': FormControl(value: person.name),
    // 'emails': FormArray<String>([]),
    'emails': FormArray<String>(
      person.emails!
          .map((email) => FormControl<String>(value: email, validators: [Validators.email]))
          .toList(),
    ),
  });
}
