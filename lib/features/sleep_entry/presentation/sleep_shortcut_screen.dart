import 'dart:async';

import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/sleep_entry/domain/sleep_entry_repository.dart';
import 'package:assiette/features/sleep_entry/presentation/sleep_entry_controller.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SleepShortcutScreen extends ConsumerStatefulWidget {
  const SleepShortcutScreen({required this.startNight, super.key});

  final bool startNight;

  @override
  ConsumerState<SleepShortcutScreen> createState() =>
      _SleepShortcutScreenState();
}

class _SleepShortcutScreenState extends ConsumerState<SleepShortcutScreen> {
  bool _handled = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _runAction());
  }

  Future<void> _runAction() async {
    if (_handled) return;
    _handled = true;
    try {
      final now = DateTime.now();
      final repository = ref.read(sleepEntryRepositoryProvider);
      final night = widget.startNight
          ? await repository.startNight(now)
          : await repository.recordWake(now);
      if (!mounted) return;
      ref.invalidate(sleepEntryControllerProvider);
      ref.read(selectedDateProvider.notifier).select(night);
      if (widget.startNight) {
        context.goNamed(AppRouter.home.name);
      } else {
        context.goNamed(AppRouter.sleepEntry.name);
      }
    } on Exception {
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final label = widget.startNight
        ? s.sleepStartShortcutTitle
        : s.sleepWakeShortcutTitle;
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(
        child: _failed
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(s.errorGeneric),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        _failed = false;
                        _handled = false;
                      });
                      unawaited(_runAction());
                    },
                    child: Text(s.retryAction),
                  ),
                ],
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
