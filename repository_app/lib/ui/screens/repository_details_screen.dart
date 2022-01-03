import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:repository/providers/repository_providers.dart';
import 'package:repository/providers/state/status.dart';
import 'package:repository/ui/repository_theme.dart';
import 'package:repository/ui/widgets/description_body.dart';
import 'package:repository/ui/widgets/details.dart';
import 'package:repository/util/Assets.dart';

final _padding = EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0);

class RepositoryDetailsScreen extends HookWidget {
  final int id;

  const RepositoryDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final viewController = useProvider(repositoriesViewControllerProvider);
    final status = useProvider(repositoryStatusProvider(id)).state;
    final items = useProvider(repositoryProvider(id));

    final isScrolling = useState<bool>(false);


    final isLoading = useMemoized(
      () => status == Status.Pending && items == null,
      [status, items],
    );

    final refresh = useMemoized(
      () => () => Future.microtask(() => viewController.fetchRepositories()),
      [viewController],
    );

    useEffect(() {
      scrollController.addListener(() {
        final isNowScrolling = scrollController.offset > 1;
        if (isScrolling.value != isNowScrolling) {
          isScrolling.value = isNowScrolling;
        }
      });
      return null;
    }, [scrollController]);

    useEffect(() {
      Future.microtask(() {
        refresh();
      });
      return null;
    }, [viewController]);
 final dateFormatter = DateFormat('dd-MM-yyyy HH:mm');
    final dateString = dateFormatter.format(items?.updatedAt as DateTime);

   
    return Scaffold(
      backgroundColor: RepositoryTheme.backgroundGrey,
      appBar:  AppBar(
             automaticallyImplyLeading: false,
              elevation: RepositoryTheme.appBarRaisedElevation,
              centerTitle: true,
              title: Text(
                  "Details repository",
                  style: Theme.of(context).textTheme.headline1,
                ),
              leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios_new, color: Colors.white,))
            ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Padding(
          padding: _padding.copyWith(bottom: 20),
          child: Card(
            child: CustomScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
               
                if (isLoading) _PostLoading(),
                
                if (items != null) ...[
                  SliverPadding(
                    padding: _padding,
                    sliver: SliverToBoxAdapter(
                      child: Details(assetImage: ImageAssets.details,
                      repositoryName: items.name,
                      ownerName: items.owner!.login,
                      lastUpdateTime: dateString,
                      )
                    ),
                  ),
                  if(items.description == null)
                     SliverSafeArea(
                      bottom: true,
                      minimum: _padding.copyWith(top: 12, bottom: 48),
                      sliver: SliverToBoxAdapter(
                        child: DescriptionBody(content: 'Description data is empty'),
                      ),
                    ),
                  if (items.description != null)
                    SliverSafeArea(
                      bottom: true,
                      minimum: _padding.copyWith(top: 12, bottom: 48),
                      sliver: SliverToBoxAdapter(
                        child: DescriptionBody(content: items.description!),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PostLoading extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}