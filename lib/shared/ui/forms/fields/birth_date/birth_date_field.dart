// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:forui/forui.dart';
// import 'package:ibivibe/features/auth/register_viewmodel.dart';
// import 'package:ibivibe/features/auth/validation/auth_validator.dart';
// import 'package:ibivibe/shared/ui/fragments/inputs/native_date_input.dart';
// import 'package:intl/intl.dart';

// class BirthDateStep extends ConsumerStatefulWidget {
//   final VoidCallback onNext;

//   const BirthDateStep({
//     super.key,
//     required this.onNext,
//   });

//   @override
//   ConsumerState<BirthDateStep> createState() => _BirthDateStepState();
// }

// class _BirthDateStepState extends ConsumerState<BirthDateStep> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _dateController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     final birthDate = ref.read(registerViewModelProvider).formData.birthDate;
//     if (birthDate != null) {
//       _dateController.text = DateFormat(
//         'dd/MM/yyyy',
//       ).format(birthDate);
//     }
//     _dateController.addListener(() => setState(() {}));
//   }

//   @override
//   void dispose() {
//     _dateController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authValidator = ref.watch(authValidatorProvider);
//     final isFieldValid = authValidator.isFieldValid(
//       AuthFields.birthDate,
//       _dateController.text,
//     );

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           spacing: 16,
//           children: [
//             Text(
//               'Quando você nasceu?',
//               style: context.theme.typography.xl2.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             NativeDateInput(
//               controller: _dateController,
//               onDateChanged: (date) {
//                 if (date != null) {
//                   ref.read(registerViewModelProvider.notifier).setBirthDate(date);
//                   setState(() {});
//                 }
//               },
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: FButton(
//                 onPress: isFieldValid ? _submit : null,
//                 child: const Text(
//                   'Continuar',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
