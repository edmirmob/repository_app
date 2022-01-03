import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repository/providers/state/status.dart';

final splashStatusProvider = StateProvider.autoDispose<Status>(
  (ref) {
    return Status.Idle;
  },
);

final splashViewController = Provider.autoDispose<SplashViewController>(
  (ref) => SplashViewController(ref),
);

class SplashViewController {
  final ProviderReference ref;

  SplashViewController(this.ref);

  Future<void> splash() => statefulAction(
        status: () => ref.read(splashStatusProvider),
        action: () => Future.wait(
          [
            Future.delayed(
              Duration(milliseconds: 4000),
            ),
          ],
        ),
      );
}
