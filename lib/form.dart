// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'person.dart';

class PersonReactiveForm extends HookWidget {
  final Person person;
  final FormGroup form;
  const PersonReactiveForm(this.person, this.form, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailControls = useState(form.control('emails') as FormArray<String>);
    final _person = useState(person);

    useEffect(() {
      print('=============== Recreate form controls ==============');
      _emailControls.value.clear();
      _emailControls.value.addAll(
        _person.value.emails!
            .map((email) => FormControl<String>(value: email, validators: [Validators.email]))
            .toList(),
      );
    }, [
      //_person, _emailControls,
      _person.value.emails.toString(), _emailControls.value.value!.toString()
    ]);

    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ReactiveTextField(
              formControlName: 'name',
              decoration: const InputDecoration(labelText: 'Person Name'),
            ),
            Column(
              children: <Widget>[
                ReactiveFormArray<String>(
                  formArrayName: 'emails',
                  builder: (context, formArray, child) => Column(
                    children: [
                      for (int i = 0; i < _person.value.emails!.length; i++)
                        arrayElementEmailTextField(i, _person, _emailControls),
                    ],
                  ),
                ),
                ReactiveFormConsumer(
                  builder: (context, form, child) {
                    return ElevatedButton(
                      // enable 'Add Email' button only if no email field is empty or
                      // all fields have valid email values
                      onPressed: _person.value.emails!.any((email) => email.isNotEmpty) &&
                              _emailControls.value.controls.every((control) => control.valid)
                          ? () => _addEmail(_person, _emailControls)
                          : null,
                      child: const Text('Add Email'),
                    );
                  },
                ),
              ],
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: form.valid ? _onSubmit : null,
                  child: const Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget arrayElementEmailTextField(
      int index, ValueNotifier<Person> _person, ValueNotifier<FormArray<String>> _emailControls) {
    // print('index: $index, Add email control: ${_person.value.emails![index]}');
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ReactiveTextField(
            formControlName: index.toString(),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        const SizedBox(width: 10),

        // display email deletion icon only if we have more than 1 emails
        if (_person.value.emails!.length > 1)
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () => _removeEmail(index, _person, _emailControls),
          )
      ],
    );
  }

  void _addEmail(ValueNotifier<Person> _person, ValueNotifier<FormArray<String>> _emailControls) {
    // print('----- adding email control -----');
    // print('Email Values before add: ${_person.value.emails!}');
    _person.value.emails!.add('');
    _emailControls.value.add(FormControl<String>(value: '', validators: [Validators.email]));
    // print('Email Values after add: ${_person.value.emails!}');
  }

  void _removeEmail(
      int index, ValueNotifier<Person> _person, ValueNotifier<FormArray<String>> _emailControls) {
    // print('===== removing control at: $index =====');
    // print('Old values: ${_person.value.emails!}');
    _person.value.emails!.removeAt(index);
    _emailControls.value.removeAt(index);
    // print('New values: ${_person.value.emails!}');
  }

  _onSubmit() {
    print('====== Form submitted: ======\n${form.value}');
  }

  // Widget arrayElementEmailTextField(List<String> emailList, String email) {
  //   return arrayElementField(
  //     field: ReactiveTextField(
  //       formControlName: emailList.indexOf(email).toString(),
  //       // decoration: const InputDecoration(labelText: ''),
  //       keyboardType: TextInputType.emailAddress,
  //     ),
  //     onRemovePressed: () => _person!._emailControls!.remove(email),
  //   );
  // }

  // Widget arrayElementField({required Widget field, required onRemovePressed}) {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(child: field),
  //       const SizedBox(width: 10),
  //       IconButton(
  //         icon: const Icon(Icons.remove_circle_outline),
  //         onPressed: onRemovePressed,
  //       ),
  //     ],
  //   );
  // }

  // IconButton _iconButton(IconData icon, VoidCallback onPressed) {
  //   return IconButton(
  //     icon: Icon(icon),
  //     onPressed: () => onPressed(),
  //   );
  // }
}
