import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mrce_test_app/core/core.dart';
import 'package:mrce_test_app/features/map/presentation/presentation.dart';
import 'package:mrce_test_app/features/saved_addresses/presentation/presentation.dart';

class SavedAddressesScreen extends StatefulWidget {
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedAddressesCubit>().getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isCupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    return Scaffold(
      appBar: AppBar(title: const Text('Сохраненные адреса')),
      body: BlocBuilder<SavedAddressesCubit, SavedAddressesState>(
        builder: (context, state) {
          return switch (state) {
            SavedAddressesInitialState() => const Center(
              child: CircularProgressIndicator(),
            ),
            SavedAddressesLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            SavedAddressesFailureState() => const Center(
              child: Text('Не удалось загрузить сохраненные адреса'),
            ),
            SavedAddressesLoadedState(:final addresses) =>
              addresses.isEmpty
                  ? const Center(
                      child: Text(
                        'Сохраненных адресов пока нет',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final address = addresses[index];

                        void goToMap() {
                          context.read<MapCubit>().onCameraIdle(address.point);
                          context.go(AppRoutes.map);
                        }

                        if (isCupertino) {
                          return Dismissible(
                            key: ValueKey(address.id),
                            direction: DismissDirection.endToStart,
                            dismissThresholds: const {
                              DismissDirection.endToStart: 0.28,
                            },
                            movementDuration: const Duration(milliseconds: 190),
                            resizeDuration: const Duration(milliseconds: 170),
                            background: const SizedBox.shrink(),
                            secondaryBackground: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.systemRed.resolveFrom(
                                  context,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 18),
                              child: const Icon(
                                CupertinoIcons.delete_solid,
                                size: 20,
                                color: CupertinoColors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              HapticFeedback.mediumImpact();
                              context.read<SavedAddressesCubit>().deleteAddress(
                                address.id,
                              );
                            },
                            child: SavedAddressCard(
                              address: address,
                              onTap: goToMap,
                            ),
                          );
                        }

                        return SavedAddressCard(
                          address: address,
                          onTap: goToMap,
                          onDeletePressed: () {
                            context.read<SavedAddressesCubit>().deleteAddress(
                              address.id,
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, _) =>
                          const SizedBox(height: 10),
                    ),
          };
        },
      ),
    );
  }
}
