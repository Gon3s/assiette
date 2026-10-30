import 'package:assiette/features/coffee/domain/coffee_entry.dart';
import 'package:assiette/features/coffee/domain/coffee_repository.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> addCoffee(BuildContext context, WidgetRef ref) async {
  final s = AppStrings.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final repository = ref.read(coffeeRepositoryProvider);
  try {
    final id = await repository.add(DateTime.now());
    if (!context.mounted) return;
    ref.read(selectedDateProvider.notifier).goToToday();
    if (!messenger.mounted) return;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(s.coffeeAdded),
          action: SnackBarAction(
            label: s.undoAction,
            onPressed: () => repository.setDeleted(id, deleted: true),
          ),
        ),
      );
  } on Exception {
    if (messenger.mounted) {
      messenger.showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }
}

Future<void> editCoffee(
  BuildContext context,
  WidgetRef ref, {
  required DateTime date,
  CoffeeEntry? entry,
}) async {
  final s = AppStrings.of(context);
  final repository = ref.read(coffeeRepositoryProvider);
  final messenger = ScaffoldMessenger.of(context);
  final initial = entry?.timestamp.toLocal() ?? date;
  final day = await showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2000),
    lastDate: DateTime.now(),
  );
  if (day == null || !context.mounted) return;
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(
      entry?.timestamp.toLocal() ?? DateTime.now(),
    ),
  );
  if (time == null || !context.mounted) return;
  final timestamp = DateTime(
    day.year,
    day.month,
    day.day,
    time.hour,
    time.minute,
  );
  try {
    if (entry == null) {
      await repository.add(timestamp);
    } else {
      await repository.update(entry.copyWith(timestamp: timestamp));
    }
  } on Exception {
    if (messenger.mounted) {
      messenger.showSnackBar(SnackBar(content: Text(s.errorGeneric)));
    }
  }
}

class CoffeeSummary extends ConsumerWidget {
  const CoffeeSummary({required this.date, super.key});
  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final entries = ref.watch(coffeeDayProvider(date));
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.coffee_outlined),
        title: entries.when(
          data: (rows) => Text(s.coffeeCount(rows.length)),
          error: (_, _) => Text(s.errorGeneric),
          loading: () => Text(s.coffeeTitle),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.add),
          tooltip: s.coffeeManualAdd,
          onPressed: () => editCoffee(
            context,
            ref,
            date: date.isAfter(DateTime.now()) ? DateTime.now() : date,
          ),
        ),
      ),
    );
  }
}

class CoffeeTimelineTile extends ConsumerWidget {
  const CoffeeTimelineTile({required this.entry, super.key});
  final CoffeeEntry entry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    return ListTile(
      leading: const CircleAvatar(child: Icon(Icons.coffee_outlined)),
      title: Text(s.coffeeTitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            MaterialLocalizations.of(context).formatTimeOfDay(
              TimeOfDay.fromDateTime(entry.timestamp.toLocal()),
              alwaysUse24HourFormat: MediaQuery.alwaysUse24HourFormatOf(
                context,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: s.deleteAction,
            onPressed: () async {
              final repository = ref.read(coffeeRepositoryProvider);
              final messenger = ScaffoldMessenger.of(context);
              try {
                await repository.setDeleted(entry.id, deleted: true);
                if (!messenger.mounted) return;
                messenger
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(s.entryDeleted),
                      action: SnackBarAction(
                        label: s.undoAction,
                        onPressed: () =>
                            repository.setDeleted(entry.id, deleted: false),
                      ),
                    ),
                  );
              } on Exception {
                if (messenger.mounted) {
                  messenger.showSnackBar(
                    SnackBar(content: Text(s.errorGeneric)),
                  );
                }
              }
            },
          ),
        ],
      ),
      onTap: () => editCoffee(
        context,
        ref,
        date: entry.timestamp.toLocal(),
        entry: entry,
      ),
    );
  }
}
