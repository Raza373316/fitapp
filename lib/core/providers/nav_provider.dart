import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Which bottom-nav tab is active. Simple enough that a StateProvider (no
/// custom Notifier class needed) is the idiomatic Riverpod choice here.
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);
