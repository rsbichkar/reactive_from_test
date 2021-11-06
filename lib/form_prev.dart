// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'person.dart';

// class PersonForm extends StatefulWidget {
//   // final Person person;
//   // final FormGroup form;
//   // const PersonForm({required this.person, required this.form, Key? key}) : super(key: key);
//   const PersonForm({Key? key}) : super(key: key);

//   @override
//   _PersonFormState createState() => _PersonFormState();
// }

// class _PersonFormState extends State<PersonForm> {
//   // FormGroup form = personForm(widget.person);
//   // ignore: prefer_final_fields
//   Person2? _person = Person2(
//     name: 'Rajan Bichkar',
//     emails: ['bichkar@gmail.com', 'bichkar@yahoo.com', 'rb@gmail.com', ''],
//   );

//   // FormGroup? form;
//   final form = FormGroup({
//     'name': FormControl(value: ''),
//     'emails': FormArray<String>([]),
//   });

//   FormArray<String> get emails => form.control('emails') as FormArray<String>;

//   @override
//   void initState() {
//     emails.addAll(
//       _person!.emails!
//           .map((email) => FormControl<String>(value: email, validators: [Validators.email]))
//           .toList(),
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ReactiveForm(
//       formGroup: form,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: <Widget>[
//             ReactiveTextField(
//               formControlName: 'name',
//               decoration: const InputDecoration(labelText: 'Person Name'),
//             ),

//             // print('Recreatinging the email control array...');
//             ReactiveFormConsumer(
//               builder: (context, form, child) {
//                 return Column(
//                   children: <Widget>[
//                     ReactiveFormArray<String>(
//                       formArrayName: 'emails',
//                       builder: (context, formArray, child) => Column(
//                         // children: _person!.emails!.map(arrayElemEmailTextField).toList(),
//                         children: [
//                           // for (String email in _person!.emails!)
//                           for (int i = 0; i < emails.value!.length; i++) arrayElemEmailTextField(i),
//                         ],
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: emails.value![emails.value!.length - 1]!.isNotEmpty &&
//                               emails.controls.last.valid
//                           ? _addEmail
//                           : null,
//                       child: const Text('Add Email'),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             ReactiveFormConsumer(
//               builder: (context, form, child) {
//                 return ElevatedButton(
//                   onPressed: form.valid ? _onSubmit : null,
//                   child: const Text('Submit'),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _onSubmit() {
//     print('====== Form submitted: ======\n${form.value}');
//   }

//   Widget arrayElemEmailTextField(int index) {
//     print('index: $index, current Emails: ${emails.value!}');

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: ReactiveTextField(
//             formControlName: index.toString(), //_person!.emails!.indexOf(email).toString(),
//             // decoration: const InputDecoration(labelText: ''),
//             keyboardType: TextInputType.emailAddress,
//           ),
//         ),
//         // const SizedBox(width: 10),
//         // if (_person!.emails!.length == 1 && index > 0 || _person!.emails!.length > 1)
//         if (emails.value!.length == 1 && index > 0 || emails.value!.length > 1)
//           IconButton(
//             icon: const Icon(Icons.remove_circle),
//             onPressed: () => _removeEmail(index),
//           )
//       ],
//     );
//   }

//   void _addEmail() {
//     // _person = _person!.copyWith(emails: [..._person!.emails. '']);
//     // _person!.emails.add('');
//     // print('Field: ${_persons.emails.value!.toString()}');
//     emails.value!.add('');
//     print('Field: ${emails.value!.toString()}');
//     // final formControl = FormControl<String>(value: '');
//     // form.controls['emails'] = [...form.controls['emails'], formControl];
//     FormControl<String> control = FormControl<String>(value: '', validators: [Validators.email]);
//     // emails.add(FormControl<String>(value: '', validators: [Validators.email]));
//     emails.add(control);
//     // emails.add(arrayElemEmailTextField('', _person!.emails.length));
//     print('Cotrol: ${emails.value}');
//   }

//   void _removeEmail(int index) {
//     // print('Old emails: ${_person!.emails.toString()}');
//     print('Old emails: ${emails.value!.toString()}');
//     print('removing control at: $index');

//     List<String>? newEmails = [
//       // for (String email in _person!.emails!)
//       //   if (email != emailToDelete) email,
//       for (int i = 0; i < _person!.emails!.length; i++)
//         if (i != index) _person!.emails![i],
//     ];

//     // // _person!.copyWith(emails: newEmails);
//     _person!.emails = newEmails;
//     print('New emails: ${_person!.emails!.toString()}');

//     // FormControl controlToDelete = emails.controls.
//     // print('Old control values: ${emails!.value}');
//     // emails!.removeAt(index);
//     // setState(() {});
//     setState(() {
//       emails.clear();
//       emails.addAll(
//         newEmails
//             .map((email) => FormControl<String>(value: email, validators: [Validators.email]))
//             .toList(),
//       );
//     });

//     print('New Control value (after removing email controller): ${emails.value}');
//     // emails.value!.removeAt(index);
//     // print('New Control value (after removing email value): ${emails.value}');

//     // emails = emails.value!
//     // .map((email) => FormControl<String>(value: email, validators: [Validators.email]));
//     // .toList(),
//     // emails.value!.removeAt(index);
//     // emails.controls.remove(FromControl<String>(value: emailToDelete));
//     // emails.addAll(
//     //   _person!.emails!.map((email) => FormControl<String>(value: email)).toList(),
//     // );
//     // emails.remove(FormControl<String>(value: emailToDelete));
//     // print('NewControl value: ${emails.value}');
//   }

//   // Widget arrayElementEmailTextField(List<String> emailList, String email) {
//   //   return arrayElementField(
//   //     field: ReactiveTextField(
//   //       formControlName: emailList.indexOf(email).toString(),
//   //       // decoration: const InputDecoration(labelText: ''),
//   //       keyboardType: TextInputType.emailAddress,
//   //     ),
//   //     onRemovePressed: () => _person!.emails!.remove(email),
//   //   );
//   // }

//   // Widget arrayElementField({required Widget field, required onRemovePressed}) {
//   //   return Row(
//   //     mainAxisSize: MainAxisSize.min,
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: [
//   //       Expanded(child: field),
//   //       const SizedBox(width: 10),
//   //       IconButton(
//   //         icon: const Icon(Icons.remove_circle_outline),
//   //         onPressed: onRemovePressed,
//   //       ),
//   //     ],
//   //   );
//   // }

//   // IconButton _iconButton(IconData icon, VoidCallback onPressed) {
//   //   return IconButton(
//   //     icon: Icon(icon),
//   //     onPressed: () => onPressed(),
//   //   );
//   // }
// }
