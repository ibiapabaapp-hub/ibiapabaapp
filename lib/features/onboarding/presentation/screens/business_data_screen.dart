import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibivibe/shared/models/city.dart';
import 'package:ibivibe/features/onboarding/presentation/controllers/business_data_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BusinessDataScreen extends ConsumerStatefulWidget {
  const BusinessDataScreen({super.key, this.onComplete});
  final VoidCallback? onComplete;

  @override
  ConsumerState<BusinessDataScreen> createState() => _BusinessDataScreenState();
}

class _BusinessDataScreenState extends ConsumerState<BusinessDataScreen> {
  // bool _isLoading = false;

  // TODO: terminar envio do form
  // void _handleComplete() async {
  //   setState(() => _isLoading = true);
  //   try {
  //     await ref.read(businessDataControllerProvider.notifier).submit();

  //     if (mounted) context.push('/app/home');
  //   } finally {
  //     if (mounted) setState(() => _isLoading = false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FScaffold(
        header: FHeader.nested(
          prefixes: [
            FButton.icon(
              style: FButtonStyle.ghost(),
              onPress: () => context.pop(),
              child: const Icon(Icons.arrow_back),
            ),
          ],
        ),
        footer: Padding(
          padding: const EdgeInsets.all(16),
          child: FButton(
            onPress: widget.onComplete,
            child: const Text('Concluir'),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  Text(
                    'Dados da Empresa',
                    style: context.theme.typography.xl2.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Preencha dados básicos sobre seu empreendimento',
                    style: context.theme.typography.base,
                  ),
                  const SizedBox(height: 32),
                  _CompanyForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum CompanyLocationType { onlyHeadquarter, haveBranches }

class _CompanyForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CompanyForm> createState() => _CompanyFormState();
}

class _CompanyFormState extends ConsumerState<_CompanyForm> {
  final _formKey = GlobalKey<FormState>();
  final _locationType = ValueNotifier(CompanyLocationType.onlyHeadquarter);

  @override
  void dispose() {
    _locationType.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(businessDataControllerProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 16,
        children: [
          const FTextFormField(
            control: FTextFieldControl.managed(),
            label: FLabel(axis: Axis.vertical, child: Text('Nome da empresa')),
            hint: 'Nome fantasia',
            autovalidateMode: AutovalidateMode.onUnfocus,
            // validator: (v) => authValidator.validateField(.name, v),
            // onSubmit: (_) => _submit(),
          ),

          FSelectGroup<CompanyLocationType>(
            control: FMultiValueControl.managedRadio(
              controller: FMultiValueNotifier.radio(
                CompanyLocationType.onlyHeadquarter,
              ),
              onChange: (value) {
                _locationType.value = value.isNotEmpty
                    ? value.first
                    : CompanyLocationType.onlyHeadquarter;
              },
            ),
            label: const Text('A empresa possui filiais?'),
            children: [
              .radio(
                value: CompanyLocationType.onlyHeadquarter,
                label: Text('Não', style: context.theme.typography.base),
              ),
              .radio(
                value: CompanyLocationType.haveBranches,
                label: Text('Sim', style: context.theme.typography.base),
              ),
            ],
          ),

          state.when(
            data: (data) =>
                _CompanyHeadquarterLocationField(cities: data.cities),
            error: (_, stack) => Text('error $stack'),
            loading: () => const Skeletonizer(
              child: _CompanyHeadquarterLocationField(cities: []),
            ),
          ),
          // _CompanyBranchesLocationField(
          //   cities: state,
          //   locationType: _locationType,
          // ),
        ],
      ),
    );
  }
}

class _CompanyHeadquarterLocationField extends StatefulWidget {
  final List<City> cities;
  const _CompanyHeadquarterLocationField({required this.cities});

  @override
  State<_CompanyHeadquarterLocationField> createState() =>
      __CompanyHeadquarterLocationFieldState();
}

class __CompanyHeadquarterLocationFieldState
    extends State<_CompanyHeadquarterLocationField> {
  @override
  Widget build(BuildContext context) {
    return FSelect<String>.searchBuilder(
      hint: 'Escolha uma cidade',
      label: const FLabel(axis: Axis.vertical, child: Text('Cidade da matriz')),
      format: (s) => s,
      clearable: true,
      filter: (query) => query.isEmpty
          ? widget.cities.map((c) => c.name)
          : widget.cities
                .where(
                  (c) => c.name.toLowerCase().startsWith(query.toLowerCase()),
                )
                .map((c) => c.name),
      contentBuilder: (context, _, cities) => [
        for (final city in cities)
          .item(
            title: Text(city, style: context.theme.typography.sm),
            value: city,
          ),
      ],
    );
  }
}

class _CompanyBranchesLocationField extends ConsumerStatefulWidget {
  final ValueNotifier locationType;
  final List<City> cities;

  const _CompanyBranchesLocationField({
    required this.locationType,
    required this.cities,
  });

  @override
  ConsumerState<_CompanyBranchesLocationField> createState() =>
      _CompanyBranchesLocationFieldState();
}

class _CompanyBranchesLocationFieldState
    extends ConsumerState<_CompanyBranchesLocationField> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.locationType,
      builder: (context, type, _) => type == CompanyLocationType.haveBranches
          ? FMultiSelect<String>.searchBuilder(
              hint: const Text('Selecione uma ou mais cidades'),
              label: const FLabel(
                axis: Axis.vertical,
                child: Text('Cidades com filiais'),
              ),
              format: Text.new,
              filter: (query) => query.isEmpty
                  ? widget.cities.map((c) => c.name)
                  : widget.cities
                        .where(
                          (c) => c.name.toLowerCase().startsWith(
                            query.toLowerCase(),
                          ),
                        )
                        .map((c) => c.name),
              contentBuilder: (context, _, cities) => [
                for (final city in cities)
                  .item(
                    title: Text(city, style: context.theme.typography.sm),
                    value: city,
                  ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
