import 'package:flutter/material.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/settings/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiToastListener(
      listeners: [
        ToastListener<SettingsCubit, SettingsState, SettingsState>(
          bloc: context.read<SettingsCubit>(),
          messageOf: (context, SettingsState state) =>
              AppExceptionsTranslator.translate(context, state.failure),
        ),
      ],
      child: child,
    );
  }
}
