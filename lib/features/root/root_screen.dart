import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_app_template/features/settings/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ToastListener<SettingsCubit, SettingsState, SettingsLoadedState>(
      bloc: context.read<SettingsCubit>(),
      messageOf: (SettingsLoadedState state) => state.message,
      child: child,
    );
  }
}
