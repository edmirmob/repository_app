import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<T> useGlobalKey<T extends State<StatefulWidget>>(
    {String? debugLabel}) {
  return use(_GlobalKeyHook<T>(debugLabel: debugLabel));
}

class _GlobalKeyHook<T extends State<StatefulWidget>>
    extends Hook<GlobalKey<T>> {
  final String? debugLabel;

  const _GlobalKeyHook({
    this.debugLabel,
    List<Object>? keys,
  }) : super(keys: keys);

  @override
  HookState<GlobalKey<T>, Hook<GlobalKey<T>>> createState() =>
      _GlobalKeyHookState();
}

class _GlobalKeyHookState<T extends State<StatefulWidget>>
    extends HookState<GlobalKey<T>, _GlobalKeyHook<T>> {
  late GlobalKey<T> key;

  @override
  void initHook() {
    key = GlobalKey();
  }

  @override
  GlobalKey<T> build(BuildContext context) => key;

  @override
  String? get debugLabel => hook.debugLabel;
}
