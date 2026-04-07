import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mrce_test_app/app/app.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/saved_addresses/presentation/presentation.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class SaveAddressDialogContent extends StatefulWidget {
  const SaveAddressDialogContent({
    required this.geocodeState,
    required this.dialogContext,
    super.key,
  });

  final GeocodeLoadedState geocodeState;
  final BuildContext dialogContext;

  @override
  State<SaveAddressDialogContent> createState() =>
      _SaveAddressDialogContentState();
}

class _SaveAddressDialogContentState extends State<SaveAddressDialogContent> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _commitSave(String name) {
    widget.dialogContext.read<SavedAddressesCubit>().saveGeocodeResult(
      widget.geocodeState.result,
      name,
    );
    Navigator.of(widget.dialogContext).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isCupertino = Theme.of(context).platform == TargetPlatform.iOS ||
        Theme.of(context).platform == TargetPlatform.macOS;

    return BlocBuilder<AddressValidatorCubit, AddressValidatorState>(
      builder: (context, state) {
        final content = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCupertino)
              CupertinoTextField(
                controller: _nameController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                placeholder: 'Например: Дом, Работа',
                onChanged: context.read<AddressValidatorCubit>().validateName,
              )
            else
              TextField(
                controller: _nameController,
                autofocus: true,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Например: Дом, Работа',
                  errorText: state.errorText,
                ),
                onChanged: context.read<AddressValidatorCubit>().validateName,
              ),
            if (isCupertino && state.errorText != null) ...[
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: context.colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.geocodeState.result.address,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textScheme.bodySmall,
              ),
            ),
          ],
        );

        return AppAlertDialog(
          title: const Text('Сохранить адрес'),
          content: content,
          actions: [
            AppAlertDialogAction(
              onPressed: () => Navigator.of(widget.dialogContext).pop(),
              child: const Text('Отмена'),
            ),
            AppAlertDialogAction(
              onPressed: state.isValid ? () => _commitSave(state.name) : null,
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }
}
