import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:mrce_test_app/uikit/uikit.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    required this.actions,
    super.key,
    this.title,
    this.content,
  });

  final List<AppAlertDialogAction> actions;
  final Widget? title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    // Build actions once to avoid rebuilding the list multiple times.
    final List<Widget> builtActions = actions.map((
      AppAlertDialogAction action,
    ) {
      return action.build(context);
    }).toList();

    // Do not use dart:io on web. This check is safe across all targets.
    final platform = Theme.of(context).platform;
    final bool shouldUseCupertino =
        !kIsWeb &&
        (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS);

    if (shouldUseCupertino) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: builtActions,
      );
    }

    return AlertDialog(title: title, content: content, actions: builtActions);
  }
}
