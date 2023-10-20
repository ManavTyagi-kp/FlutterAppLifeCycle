import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider =
    StateNotifierProvider<TimeProvider, AsyncValue<int>>((ref) {
  // int index = ref.watch(todoProvider.notifier).getIndex(ind);
  return TimeProvider(const AsyncValue.data(0));
});

class TimeProvider extends StateNotifier<AsyncValue<int>> {
  late StreamSubscription<int> _subscription;

  TimeProvider(super.state);

  Stream<int> countdownStream(int time) {
    print('time: $time');
    return Stream.periodic(
        const Duration(seconds: 1), (count) => (time - count)).take(time);
  }

  void start(int time) {
    print('start called with time: $time');
    // state = AsyncValue.data(time / 1);

    _subscription = countdownStream(time).listen((countdown) {
      // print('countdown $index: $countdown');
      // print(countdown);
      if (countdown >= 0) {
        state = AsyncValue.data(countdown);
      } else {
        state = const AsyncValue.data(0);
      }
    });
  }

  void pauseStream() {
    _subscription.pause();
  }

  void resumeStream() {
    _subscription.resume();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
