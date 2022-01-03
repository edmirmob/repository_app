import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repository/core/data/repositories.dart';
import 'package:repository/providers/repository_providers.dart';
import 'package:repository/providers/state/status.dart';
import 'package:repository/ui/repository_theme.dart';
import 'package:repository/ui/navigation/app_routes.dart';
import 'package:repository/ui/widgets/card_items.dart';
import 'package:repository/ui/widgets/info_indicator.dart';
import 'package:repository/util/Assets.dart';


final _padding = EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 16);

void _goToErrorScreen(BuildContext context) {
  Navigator.of(context).pushNamed(AppRoutes.error, arguments: () {
    context.read(repositoriesViewControllerProvider).fetchRepositories();
  });
}

void _goToRepositoryDetails(BuildContext context, Item item) {
  Navigator.of(context).pushNamed(AppRoutes.repositoryDetails, arguments: item);
}

class RepositoryScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final viewController = useProvider(repositoriesViewControllerProvider);
    final repositories = useProvider(repositoriesProvider).state;
    final status = useProvider(repositoriesStatusProvider).state;
    final updateTime = getSortByDate(repositories ?? []);

    final refresh = useMemoized(
      () => () => Future.microtask(() => viewController.fetchRepositories()),
      [viewController],
    );

    useEffect(() {
      refresh();
      return null;
    }, [refresh]);

    useEffect(() {
      Future.microtask(() => viewController.fetchRepositories());
      return null;
    }, []);

    useEffect(() {
      Future.microtask(
        () => status.when(
          rejected: () => _goToErrorScreen(
            context,
          ),
        ),
      );
      return null;
    }, [status]);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        top: true,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: RepositoryTheme.appBarRaisedElevation,
              floating: true,
              centerTitle: true,
              title: Text(
                "List repository",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            if (status == Status.Pending) _RepositoriesLoading(),
            if (status == Status.Fulfilled && repositories?.isNotEmpty != true)
              _RepositoriesEmpty(),
            if (status == Status.Fulfilled && repositories?.isNotEmpty == true)
              _RepositoriesList(repositories: repositories!, date: updateTime),
          ],
        ),
      ),
    );
  }
}

class _RepositoriesLoading extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RepositoriesEmpty extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Padding(
        padding: _padding.copyWith(top: 0),
        child: InfoIndicator(
          svgAsset: ImageAssets.achievement,
          textAlign: TextAlign.center,
          title: "Empty Repositories",
          content: Text(
            "Unfortunately Empty Repositories",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _RepositoriesList extends HookWidget {
  final List<Item> repositories;
  final List<String> date;

  _RepositoriesList({
    Key? key,
    required this.repositories,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final items = repositories[index];
          final datumi = date[index];
          return Padding(
            padding: _padding.copyWith(bottom: 12),
            child: _RepositoryItem(
              repositoryItem: items,
              updateTime: datumi,
            ),
          );
        },
        childCount: repositories.length,
      ),
    );
  }
}

class _RepositoryItem extends HookWidget {
  final Item repositoryItem;
  final String updateTime;

  _RepositoryItem(
      {Key? key, required this.repositoryItem, required this.updateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardItems(
      onTap: () => _goToRepositoryDetails(context, repositoryItem),
      assetImage: ImageAssets.landing_repository,
      lastUpdateTime: updateTime,
      title: repositoryItem.name.toString(),
    );
  }
}
