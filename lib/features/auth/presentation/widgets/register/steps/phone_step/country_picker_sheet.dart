import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibiapabaapp/features/auth/presentation/widgets/register/steps/phone_step/country_code_config.dart';

class CountryPickerResult {
  final String code;
  final bool isCustom;

  const CountryPickerResult({required this.code, this.isCustom = false});
}

Future<CountryPickerResult?> showCountryPickerSheet({
  required BuildContext context,
  required String currentCode,
  required bool isCustomCountry,
}) {
  return showModalBottomSheet<CountryPickerResult>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Selecione o país',
              style: context.theme.typography.lg.copyWith(fontWeight: .w600),
            ),
          ),
          const Divider(height: 1),

          // Brasil
          ListTile(
            minTileHeight: 64,
            leading: Text(
              CountryPhoneConfig.brazil.flag,
              style: const TextStyle(fontSize: 24),
            ),
            title: Text(CountryPhoneConfig.brazil.name),
            trailing: !isCustomCountry
                ? Icon(Icons.check_circle, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.pop(
              context,
              CountryPickerResult(code: CountryPhoneConfig.brazil.code),
            ),
          ),

          const Divider(height: 1),

          // Código personalizado
          ListTile(
            minTileHeight: 64,
            leading: const Text('🌏', style: TextStyle(fontSize: 24)),
            title: const Text('Código personalizado'),
            trailing: isCustomCountry
                ? Icon(Icons.check_circle, color: context.theme.colors.primary)
                : null,
            onTap: () => Navigator.pop(
              context,
              const CountryPickerResult(code: '', isCustom: true),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
