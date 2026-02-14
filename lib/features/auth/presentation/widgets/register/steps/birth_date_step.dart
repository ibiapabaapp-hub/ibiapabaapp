import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/shared/ui/native_date_input.dart';
import 'package:intl/intl.dart';

class BirthDateStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onNext;

  const BirthDateStep({
    super.key,
    required this.controller,
    required this.onNext,
  });

  @override
  State<BirthDateStep> createState() => _BirthDateStepState();
}

class _BirthDateStepState extends State<BirthDateStep> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.controller.formData.birthDate != null) {
      _dateController.text = DateFormat(
        'dd/MM/yyyy',
      ).format(widget.controller.formData.birthDate!);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (widget.controller.formData.birthDate == null) return;

    FocusScope.of(context).unfocus();
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Quando você nasceu?',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            NativeDateInput(
              controller: _dateController,
              onDateChanged: (date) {
                setState(() {
                  widget.controller.setBirthDate(date!);
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: _submit,
                child: const Text(
                  'Continuar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
