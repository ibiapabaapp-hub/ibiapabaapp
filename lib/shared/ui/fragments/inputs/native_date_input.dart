import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:ibiapabaapp/features/auth/validation/auth_validator.dart';
import 'package:intl/intl.dart';

class NativeDateInput extends ConsumerStatefulWidget {
  final TextEditingController controller;
  final Function(DateTime?) onDateChanged;

  const NativeDateInput({
    super.key,
    required this.controller,
    required this.onDateChanged,
  });

  @override
  ConsumerState<NativeDateInput> createState() => _NativeDateInputState();
}

class _NativeDateInputState extends ConsumerState<NativeDateInput> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now().subtract(
      const Duration(days: 365 * 16),
    );
    try {
      if (widget.controller.text.length == 10) {
        initialDate = DateFormat(
          'dd/MM/yyyy',
        ).parseStrict(widget.controller.text);
      }
    } catch (_) {}

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Selecione seu nascimento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
    );

    if (picked != null) {
      final formatted = DateFormat('dd/MM/yyyy').format(picked);
      widget.controller.text = formatted;
      widget.onDateChanged(picked);
      if (context.mounted) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authValidator = ref.watch(authValidatorProvider);
    final theme = context.theme;

    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Data de Nascimento',
            style: theme.typography.sm.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colors.foreground,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            style: theme.typography.sm.copyWith(color: theme.colors.foreground),
            validator: (v) =>
                authValidator.validateField(AuthFields.birthDate, v),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DataInputFormatter(),
            ],
            onTap: () {
              _selectDate(context);
            },
            decoration: InputDecoration(
              hintText: 'dd/mm/aaaa',
              hintStyle: theme.typography.sm.copyWith(
                color: theme.colors.mutedForeground,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colors.border),
                borderRadius: const BorderRadius.all(.circular(16)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colors.primary, width: 2),
                borderRadius: const BorderRadius.all(.circular(16)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colors.error),
                borderRadius: const BorderRadius.all(.circular(16)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: theme.colors.error, width: 2),
                borderRadius: const BorderRadius.all(.circular(16)),
              ),

              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: theme.colors.foreground,
                ),
                onPressed: () => _selectDate(context),
              ),
            ),
            onChanged: (value) {
              if (value.length == 10) {
                try {
                  final date = DateFormat('dd/MM/yyyy').parseStrict(value);
                  widget.onDateChanged(date);
                } catch (_) {
                  widget.onDateChanged(null);
                }
              } else {
                widget.onDateChanged(null);
              }
            },
          ),
        ],
      ),
    );
  }
}
