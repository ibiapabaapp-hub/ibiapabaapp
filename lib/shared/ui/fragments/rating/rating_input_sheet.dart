import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:ibivibe/shared/ui/fragments/toast/show_app_toast.dart';
import 'package:ibivibe/shared/ui/layout/sheet_drag_indicator.dart';

const commentMaxLength = 300;

void showRatingInputSheet({required BuildContext context}) {
  final double screenHeight = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    barrierColor: Colors.black45,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
    builder: (context) => SizedBox(
      height: screenHeight * 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [_Header(), _Form()],
            ),
          ),
        ),
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      // Garante que os textos e o rating fiquem no meio
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SheetDragIndicator(),
        const SizedBox(height: 24),

        const Text(
          'Avaliar',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        Text(
          'Conte-nos sobre sua experiência e ajude outras pessoas',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: context.theme.colors.mutedForeground,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();

  double _rating = 0.0;

  late final FTextFieldControl _textControl;

  @override
  void initState() {
    super.initState();
    _textControl = const FTextFieldControl.managed();
    // widget.controller.addListener(_controllerListener);
  }

  @override
  void dispose() {
    // widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    showAppToast(
      context: context,
      duration: const Duration(seconds: 3),
      alignment: .bottomCenter,
      title: 'TODO: Falta implementar controller e comunicação com backend',
    );
    // widget.controller.login(email: _email, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    // final isLoading = widget.controller.state is LoginLoading;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16),

          Text(
            _rating.toStringAsFixed(1),
            style: TextStyle(
              color: context.theme.colors.foreground,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: UnconstrainedBox(
              child: Center(
                child: EasyStarsRating(
                  allowClear: true,
                  allowHalfRating: true,
                  initialRating: 0.0,
                  maxRating: 5,
                  minRating: 0,
                  emptyColor: context.theme.colors.mutedForeground,
                  starSize: 36,
                  filledColor: context.theme.colors.primary,
                  onRatingChanged: (value) {
                    setState(() {
                      _rating = value;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          FTextFormField.multiline(
            control: _textControl,
            maxLengthEnforcement: .enforced,
            maxLength: commentMaxLength,
            autovalidateMode: .always,
            onSubmit: (_) => _submit(),
            validator: (v) {
              if (v!.length == commentMaxLength) {
                return 'Limite de tamanho do comentário atingido';
              }
              return null;
            },
            style: (style) => style.copyWith(
              border: FWidgetStateMap.all(
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: context.theme.colors.border),
                ),
              ),
            ),
            hint: 'Deixe um comentário',
          ),
          const SizedBox(height: 24),

          FButton(onPress: _submit, child: const Text('Enviar avaliação')),
        ],
      ),
    );
  }
}
