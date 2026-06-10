import 'package:mocktail/mocktail.dart';

// A generic Listener class, used to track when a provider notifies its listeners.
class Listener<T> extends Mock {
  void call(T? previous, T next);
}
