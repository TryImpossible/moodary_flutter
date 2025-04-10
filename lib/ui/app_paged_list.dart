import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'state_loader/app_state_loader.dart';

typedef PagedIndexedWidgetBuilder<T> = Widget Function(
    BuildContext context, int index, T data);

typedef PagedDataSourceProvider<T> = Future<AppPagedDataEntity<T>?> Function(
    int pageIndex);

/// 初始页码
const int kInitialPageIndex = 1;

class AppPagedDataEntity<T> {
  AppPagedDataEntity({
    int? totalCount,
    List<T>? datasource,
  })  : totalCount = totalCount ?? 0,
        datasource = datasource ?? <T>[];

  AppPagedDataEntity.empty()
      : totalCount = 0,
        datasource = <T>[];

  final int totalCount;
  final List<T> datasource;
}

class AppPagedController<T> {
  AppPagedController({bool isAutoLoad = true})
      : _isAutoLoad = isAutoLoad,
        _stateLoaderController = AppStateLoaderController(),
        _refreshController = RefreshController();

  /// 是否自动加载
  final bool _isAutoLoad;

  /// 加载状态控制器
  final AppStateLoaderController _stateLoaderController;

  /// 刷新控制器
  final RefreshController _refreshController;

  /// 页码
  int _pageIndex = kInitialPageIndex;

  /// 总条数
  int _totalCount = 0;

  /// 数据
  List<T> get datasource => _datasourceNotifier.value;

  final ValueNotifier<List<T>> _datasourceNotifier = ValueNotifier<List<T>>([]);

  PagedDataSourceProvider<T>? _datasourceProvider;

  RefreshController get refreshController => _refreshController;

  void setDataSourceProvider(PagedDataSourceProvider<T> provider) {
    _datasourceProvider = provider;
    Future<void>.sync(() {
      if (_isAutoLoad) {
        refresh(isPullDown: false);
      }
    });
  }

  /// 处理数据源
  Future<void> getDataSource({
    int pageIndex = kInitialPageIndex,
  }) async {
    if (_datasourceProvider == null) {
      return;
    }
    try {
      final AppPagedDataEntity<T>? result =
          await _datasourceProvider!(pageIndex);
      if (result == null) {
        return;
      }
      if (pageIndex == kInitialPageIndex) {
        if (result.datasource.isEmpty) {
          _stateLoaderController.showEmpty();
        } else {
          _stateLoaderController.showSuccess();
        }
        _totalCount = result.totalCount;
        _datasourceNotifier.value = result.datasource;
      } else {
        _totalCount = result.totalCount;
        _datasourceNotifier.value = List<T>.from(datasource)
          ..addAll(result.datasource);
      }

      // 直接完成下拉刷新和上拉加载
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
      if (datasource.length == _totalCount) {
        _refreshController.loadNoData();
      } else {
        _refreshController.resetNoData();
      }
    } catch (err, stack) {
      debugPrint('=== paged_list_err ===');
      debugPrint(err.toString());
      debugPrint(stack.toString());
      if (pageIndex == kInitialPageIndex) {
        _refreshController.refreshFailed();
        _stateLoaderController.showError();
      } else {
        _refreshController.loadFailed();
      }
    }
  }

  void refresh({isPullDown = true}) {
    if (isPullDown) {
      _refreshController.requestRefresh();
    } else {
      _stateLoaderController.showLoading();
      getDataSource();
    }
  }

  void loadMore() {
    _refreshController.requestLoading();
  }

  Future<void> _onRefresh() async {
    if ((_refreshController.position?.pixels ?? 0) > 0) {
      _refreshController.position?.jumpTo(0);
    }
    await getDataSource(pageIndex: kInitialPageIndex);
  }

  Future<void> _onLoadMore() async {
    if (datasource.length < _totalCount) {
      await getDataSource(pageIndex: ++_pageIndex);
    }
  }

  Future<void> update(int index, T data) async {
    final List<T> newDatasource = List.from(_datasourceNotifier.value);
    newDatasource[index] = data;
    _datasourceNotifier.value = newDatasource;
  }

  Future<void> add(T data) async {
    final List<T> newDatasource = List.from(_datasourceNotifier.value);
    newDatasource.add(data);
    _datasourceNotifier.value = newDatasource;
  }

  Future<void> remove(int index) async {
    final List<T> newDatasource = List.from(_datasourceNotifier.value);
    newDatasource.removeAt(index);
    _datasourceNotifier.value = newDatasource;
  }
}

sealed class _AppPagedScrollView<T> extends StatelessWidget {
  const _AppPagedScrollView({
    super.key,
    required this.controller,
    this.loading,
    this.empty,
    this.error,
    this.refresherHeader,
    this.refresherFooter,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.scrollPhysics,
    this.scrollHeader,
    this.scrollFooter,
  });

  final AppPagedController<T> controller;

  final Widget? loading;
  final Widget? empty;
  final Widget? error;

  final Widget? refresherHeader;
  final Widget? refresherFooter;
  final bool enablePullDown;
  final bool enablePullUp;

  final ScrollController? scrollController;
  final Axis scrollDirection;
  final ScrollPhysics? scrollPhysics;
  final Widget? scrollHeader;
  final Widget? scrollFooter;

  @override
  Widget build(BuildContext context) {
    Widget current = CustomScrollView(
      controller: scrollController,
      scrollDirection: scrollDirection,
      physics: scrollPhysics,
      slivers: <Widget>[
        if (scrollHeader != null) scrollHeader!,
        ListenableBuilder(
          listenable: controller._datasourceNotifier,
          builder: (BuildContext context, Widget? child) {
            if (controller._stateLoaderController.status.isSuccess) {
              return buildScrollChild();
            } else {
              return SliverFillRemaining(
                child: AppStateLoader(
                  controller: controller._stateLoaderController,
                  loading: loading,
                  empty: empty,
                  error: error,
                  onRetry: () => controller.refresh(isPullDown: false),
                  child: const SizedBox.shrink(),
                ),
              );
            }
          },
        ),
        if (scrollFooter != null) scrollFooter!,
      ],
    );
    if (enablePullDown || enablePullUp) {
      current = SmartRefresher(
        controller: controller._refreshController,
        header: refresherHeader,
        footer: refresherFooter,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        onRefresh: controller._onRefresh,
        onLoading: controller._onLoadMore,
        child: current,
      );
    }
    return current;
  }

  Widget buildScrollChild();
}

class AppPagedListView<T> extends _AppPagedScrollView<T> {
  const AppPagedListView({
    super.key,
    required super.controller,
    super.loading,
    super.empty,
    super.error,
    super.refresherHeader,
    super.refresherFooter,
    super.enablePullDown,
    super.enablePullUp,
    super.scrollController,
    super.scrollDirection,
    super.scrollPhysics,
    super.scrollHeader,
    super.scrollFooter,
    this.listPadding,
    required this.itemBuilder,
    this.separatorBuilder,
  });

  final EdgeInsets? listPadding;
  final NullableIndexedWidgetBuilder itemBuilder;
  final NullableIndexedWidgetBuilder? separatorBuilder;

  @override
  Widget buildScrollChild() {
    Widget current = SliverList.separated(
      itemBuilder: (BuildContext context, int index) {
        return itemBuilder(context, index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorBuilder?.call(context, index);
      },
      itemCount: controller._datasourceNotifier.value.length,
    );
    if (listPadding != null) {
      current = SliverPadding(padding: listPadding!, sliver: current);
    }
    return current;
  }
}

class AppPagedGridView<T> extends _AppPagedScrollView<T> {
  const AppPagedGridView({
    super.key,
    required super.controller,
    super.loading,
    super.empty,
    super.error,
    super.refresherHeader,
    super.refresherFooter,
    super.enablePullDown,
    super.enablePullUp,
    super.scrollController,
    super.scrollDirection,
    super.scrollPhysics,
    super.scrollHeader,
    super.scrollFooter,
    this.gridPadding,
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.childAspectRatio = 1.0,
    this.mainAxisExtent,
    required this.itemBuilder,
  });

  final EdgeInsets? gridPadding;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final double? mainAxisExtent;
  final NullableIndexedWidgetBuilder itemBuilder;

  @override
  Widget buildScrollChild() {
    Widget current = SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
        mainAxisExtent: mainAxisExtent,
      ),
      itemBuilder: (BuildContext context, int index) {
        return itemBuilder.call(context, index);
      },
      itemCount: controller._datasourceNotifier.value.length,
    );
    if (gridPadding != null) {
      current = SliverPadding(padding: gridPadding!, sliver: current);
    }
    return current;
  }
}
