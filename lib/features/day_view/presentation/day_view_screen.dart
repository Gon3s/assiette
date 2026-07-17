import 'package:assiette/constants/app_sizes.dart';
import 'package:assiette/features/day_view/presentation/day_view_providers.dart';
import 'package:assiette/features/day_view/presentation/selected_date_provider.dart';
import 'package:assiette/features/day_view/presentation/widgets/day_header.dart';
import 'package:assiette/features/day_view/presentation/widgets/sleep_card.dart';
import 'package:assiette/features/day_view/presentation/widgets/timeline_tile.dart';
import 'package:assiette/features/favorites/presentation/widgets/favorites_row.dart';
import 'package:assiette/localization/app_strings.dart';
import 'package:assiette/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Reference date for day 0 of the day-navigation [PageView].
///
/// Kept in UTC so [_pageForDate] never crosses a local DST boundary: a
/// local-time diff between a winter epoch and a summer "today" loses an
/// hour to the clock shift, and [Duration.inDays] truncates that into an
/// off-by-one page.
final _epoch = DateTime.utc(2000);

/// Number of days reachable by swiping around [_epoch] (~135 years).
const _pageCount = 50000;

int _pageForDate(DateTime date) =>
    DateTime.utc(date.year, date.month, date.day).difference(_epoch).inDays;

DateTime _dateForPage(int page) {
  final utc = _epoch.add(Duration(days: page));
  return DateTime(utc.year, utc.month, utc.day);
}

/// Home screen: everything logged for the selected day, as a timeline.
///
/// Wraps the day content in a [PageView] so the user can swipe between
/// days; a date picker and a "today" shortcut are also offered in the
/// app bar (US-11).
class DayViewScreen extends ConsumerStatefulWidget {
  /// Creates a [DayViewScreen].
  const DayViewScreen({super.key});

  @override
  ConsumerState<DayViewScreen> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends ConsumerState<DayViewScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _pageForDate(ref.read(selectedDateProvider)),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    ref.read(selectedDateProvider.notifier).select(_dateForPage(page));
  }

  Future<void> _pickDate(DateTime current) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: _epoch,
      lastDate: _dateForPage(_pageCount - 1),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).select(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final date = ref.watch(selectedDateProvider);

    // Keep the PageView in sync when the date changes from outside a
    // swipe (the "today" shortcut or the date picker).
    ref.listen(selectedDateProvider, (previous, next) {
      final targetPage = _pageForDate(next);
      if (_pageController.hasClients &&
          _pageController.page?.round() != targetPage) {
        _pageController.jumpToPage(targetPage);
      }
    });

    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    final title = isToday ? s.today : DateFormat.MMMMEEEEd(locale).format(date);

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _pickDate(date),
          child: Text(title),
        ),
        actions: [
          if (!isToday)
            IconButton(
              icon: const Icon(Icons.today),
              tooltip: s.today,
              onPressed: () =>
                  ref.read(selectedDateProvider.notifier).goToToday(),
            ),
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => _pickDate(date),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => context.pushNamed(AppRouter.settings.name),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _pageCount,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, page) => const _DayViewBody(),
      ),
    );
  }
}

class _DayViewBody extends ConsumerWidget {
  const _DayViewBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = AppStrings.of(context);
    final timeline = ref.watch(dayTimelineProvider);

    return Column(
      children: [
        const DayHeader(),
        const SleepCard(),
        gapH8,
        const FavoritesRow(),
        gapH8,
        Expanded(
          child: switch (timeline) {
            AsyncData(:final value) when value.isEmpty => Center(
              child: Text(
                s.emptyDayMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            AsyncData(:final value) => ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) =>
                  TimelineTile(item: value[index]),
            ),
            AsyncError() => Center(child: Text(s.emptyDayMessage)),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
        _ActionBar(s: s),
      ],
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.s});

  final AppStrings s;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: () => context.pushNamed(AppRouter.mealEntry.name),
                icon: const Icon(Icons.photo_camera),
                label: Text(s.logMealAction),
              ),
            ),
            gapW16,
            Expanded(
              child: FilledButton.tonalIcon(
                onPressed: () => context.pushNamed(AppRouter.symptomEntry.name),
                icon: const Icon(Icons.healing),
                label: Text(s.logSymptomAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
