import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';

Future<String?> showCustomCodeDialog({
  required BuildContext context,
  required String initialCode,
}) {
  String code = initialCode;
  final countryCodeRegex = RegExp(r'^\+[1-9]\d{0,3}$');

  final control = FTextFieldControl.managed(
    initial: TextEditingValue(text: initialCode),
    onChange: (v) => code = v.text,
  );

  void submit() {
    FocusScope.of(context).unfocus();
    final trimmedCode = code.trim();

    if (!countryCodeRegex.hasMatch(trimmedCode)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código inválido. Use o formato +XX')),
      );
      return;
    }

    Navigator.pop(context, trimmedCode);
  }

  return showFDialog<String>(
    context: context,
    builder: (context, style, animation) => FDialog(
      style: style.call,
      title: const Text('Código do país'),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Digite o código do seu país (ex: +44, +33, +81)'),
          const SizedBox(height: 16),
          FTextFormField(
            control: control,
            keyboardType: TextInputType.phone,
            autofocus: true,
            hint: '+00',
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
              LengthLimitingTextInputFormatter(5),
            ],
            style: (style) =>
                style.withBaseFontSize(typography: context.theme.typography),
            onSubmit: (_) => submit(),
          ),
        ],
      ),
      actions: [
        FButton(
          style: FButtonStyle.ghost(),
          onPress: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FButton(onPress: submit, child: const Text('Confirmar')),
      ],
    ),
  );
}
