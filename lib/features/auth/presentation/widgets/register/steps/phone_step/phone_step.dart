import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:ibiapabaapp/app/theme/theme.dart';
import 'package:ibiapabaapp/features/auth/presentation/controllers/register_controller.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/phone_step/country_code_config.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/phone_step/country_picker_sheet.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/phone_step/custom_code_dialog.dart';

class PhoneStep extends StatefulWidget {
  final RegisterController controller;
  final VoidCallback onNext;

  const PhoneStep({super.key, required this.controller, required this.onNext});

  @override
  State<PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<PhoneStep> {
  final _formKey = GlobalKey<FormState>();
  late final FTextFieldControl _phoneControl;

  String _digits = '';
  String _countryCode = '+55';
  bool _isCustomCountry = false;

  Timer? _debounce;
  bool _isChecking = false;
  bool? _isAvailable;
  String? _apiError;
  String? _successText;

  static final _e164Regex = RegExp(r'^\+[1-9]\d{1,14}$');

  bool get _canContinue =>
      _isAvailable == true &&
      !_isChecking &&
      _apiError == null &&
      _digits.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _phoneControl = FTextFieldControl.managed(
      onChange: (v) {
        setState(() {
          _digits = v.text.replaceAll(RegExp(r'\D'), '');
          _apiError = null;
          _isAvailable = null;
        });
        _onPhoneChanged();
      },
    );
  }

  void _onPhoneChanged() {
    _debounce?.cancel();

    setState(() {
      _isAvailable = null;
      _apiError = null;
      _successText = null;
    });

    final fullNumber = '$_countryCode$_digits';

    if (_countryCode == '+55' && _digits.length != 11) {
      return;
    }

    if (_countryCode != '+55' && _digits.length < _currentCountry.minDigits) {
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 600), () {
      _checkPhoneAvailability(fullNumber);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _checkPhoneAvailability(String phone) async {
    setState(() {
      _isChecking = true;
    });

    final available = await widget.controller.checkPhone(phone);

    if (!mounted) return;

    setState(() {
      _isChecking = false;
      _isAvailable = available;

      final fieldError = widget.controller.getError('phone_number');
      if (fieldError != null) {
        _apiError = fieldError;
      } else if (!available) {
        _apiError = 'Este telefone já está vinculado a outra conta.';
      } else {
        _successText = 'Telefone disponível!';
      }
    });

    _formKey.currentState?.validate();
  }

  CountryPhoneConfig get _currentCountry =>
      _isCustomCountry ? CountryPhoneConfig.custom : CountryPhoneConfig.brazil;

  List<TextInputFormatter> get _inputFormatters {
    if (!_isCustomCountry && _countryCode == '+55') {
      return [FilteringTextInputFormatter.digitsOnly, TelefoneInputFormatter()];
    }
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(_currentCountry.maxDigits),
    ];
  }

  String? _validate(String? v) {
    if (_digits.isEmpty) return 'Digite seu telefone';

    if (_countryCode == '+55') {
      if (_digits.length < 11) return 'Informe DDD + número';
    } else {
      if (_digits.length < _currentCountry.minDigits) {
        return 'Número muito curto';
      }
    }

    final fullNumber = '$_countryCode$_digits';
    if (!_e164Regex.hasMatch(fullNumber)) {
      return 'Formato de telefone inválido';
    }

    if (_apiError != null) return _apiError;
    return null;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;
    if (_isAvailable != true) return;
    widget.controller.setPhone('$_countryCode$_digits');
    widget.onNext();
  }

  Widget _buildSuffix(BuildContext context) {
    if (_isChecking) {
      return const Padding(
        padding: EdgeInsets.all(12),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }
    if (_isAvailable == true) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(
          Icons.check_circle_outline,
          color: context.theme.colors.primary,
        ),
      );
    }
    if (_isAvailable == false) {
      return Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(Icons.error_outline, color: context.theme.colors.error),
      );
    }
    return const SizedBox.shrink();
  }

  void _showCountryPicker() async {
    final result = await showCountryPickerSheet(
      context: context,
      currentCode: _countryCode,
      isCustomCountry: _isCustomCountry,
    );

    if (result == null) return;

    if (result.isCustom) {
      _showCustomCodeDialog();
    } else {
      setState(() {
        _isCustomCountry = false;
        _countryCode = result.code;
        _digits = '';
      });
    }
  }

  void _showCustomCodeDialog() async {
    final code = await showCustomCodeDialog(
      context: context,
      initialCode: _isCustomCountry ? _countryCode : '+',
    );

    if (code != null) {
      setState(() {
        _isCustomCountry = true;
        _countryCode = code;
        _digits = '';
      });
    }
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
              'Qual é o seu telefone?',
              style: context.theme.typography.xl2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: _showCountryPicker,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.theme.colors.border),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _currentCountry.flag,
                          style: context.theme.typography.base,
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          color: context.theme.colors.foreground,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FTextFormField(
                    control: _phoneControl,
                    suffixBuilder: (context, style, states) =>
                        _buildSuffix(context),
                    keyboardType: TextInputType.phone,
                    hint: _currentCountry.example,
                    inputFormatters: _inputFormatters,
                    style: (style) => style.withBaseFontSize(
                      typography: context.theme.typography,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _validate,
                    onSubmit: (_) => _canContinue ? _submit() : null,
                  ),
                ),
              ],
            ),

            if (_successText != null && _apiError == null && !_isChecking)
              Text(
                _successText!,
                style: context.theme.typography.sm.copyWith(
                  color: context.theme.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: FButton(
                onPress: _canContinue ? _submit : null,
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
