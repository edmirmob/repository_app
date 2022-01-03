import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:repository/core/data/repositories.dart';
import 'package:repository/providers/di/network_providers.dart';
import 'package:repository/providers/state/status.dart';
import 'package:repository/util/extensions.dart';

final repositoriesStatusProvider = StateProvider.autoDispose<Status>(
  (ref) {
    ref.maintainState = true;
    return Status.Idle;
  },
);

final repositoriesErrorProvider = StateProvider.autoDispose<dynamic>(
  (ref) {
    ref.maintainState = true;
    return null;
  },
);
final List<String> itemData = [];
List<String> getSortByDate(List<Item> listItem) {
  listItem.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt as DateTime));
  for (var item in listItem) {
    var formats = DateFormat('dd-MM-yyyy HH:mm');

    itemData.add(formats.format(item.updatedAt as DateTime));
  }
  return itemData;
}

final repositoriesProvider = StateProvider.autoDispose<List<Item>?>(
  (ref) {
    ref.maintainState = true;

    return null;
  },
);

final repositoryStatusProvider = StateProvider.autoDispose.family<Status, int>(
  (ref, id) {
    ref.maintainState = true;
    return ref.watch(repositoriesStatusProvider).state;
  },
);

final repositoryProvider = Provider.autoDispose.family<Item?, int>(
  (ref, id) {
    ref.maintainState = true;
    return ref
        .watch(repositoriesProvider)
        .state
        ?.firstWhereOrNull((item) => item.id == id);
  },
);


final repositoriesViewControllerProvider = Provider.autoDispose(
  (ref) => RepositoriesViewController(ref),
);

class RepositoriesViewController {
  final ProviderReference ref;

  RepositoriesViewController(this.ref);

  Future<void> fetchRepositories() {
    return statefulFetch(
      status: () => ref.read(repositoriesStatusProvider),
      data: () => ref.read(repositoriesProvider),
      error: () => ref.read(repositoriesErrorProvider),
      fetch: () => ref.read(repositoryAPIProvider).getRepository(),
    );
  }
}
