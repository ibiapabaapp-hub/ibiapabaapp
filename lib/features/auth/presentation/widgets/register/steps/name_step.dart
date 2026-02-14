import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';

class NameStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onNext;

  const NameStep({super.key, required this.controller, required this.onNext});

  @override
  State<NameStep> createState() => _NameStepState();
}

class _NameStepState extends State<NameStep> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  late final FTextFieldControl _nameControl;

  @override
  void initState() {
    super.initState();
    _name = widget.controller.formData.name;
    _nameControl = FTextFieldControl.managed(onChange: (v) => _name = v.text);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    widget.controller.setName(_name);
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
              'Como você se chama?',
              style: context.theme.typography.xl2.copyWith(fontWeight: .w600),
            ),

            FTextFormField(
              control: _nameControl,
              style: (style) =>
                  style.withBaseFontSize(typography: context.theme.typography),
              hint: 'Seu nome e sobrenome',
              autovalidateMode: AutovalidateMode.onUnfocus,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Informe seu nome';
                }
                if (v.trim().split(' ').length < 2) {
                  return 'Informe nome e sobrenome';
                }
                return null;
              },
              onSubmit: (_) => _submit(),
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
