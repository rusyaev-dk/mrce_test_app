import 'package:flutter/material.dart';
import 'package:mrce_test_app/app/app.dart';

class OfflineWarning extends StatelessWidget {
  const OfflineWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 48,
                color: context.colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                'Вы оффлайн',
                style: context.textScheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                'Проверьте подключение к интернету. Карта появится автоматически после восстановления сети.',
                style: context.textScheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
