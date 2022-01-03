import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Status {
  Idle,
  Pending,
  Rejected,
  Fulfilled,
}

extension StatusExtension on Status {
  void when({
    Function()? idle,
    Function()? pending,
    Function()? rejected,
    Function()? fulfilled,
  }) {
    switch (this) {
      case Status.Idle:
        idle?.call();
        break;
      case Status.Pending:
        pending?.call();
        break;
      case Status.Rejected:
        rejected?.call();
        break;
      case Status.Fulfilled:
        fulfilled?.call();
        break;
    }
  }

  T? map<T>({
    T Function()? idle,
    T Function()? pending,
    T Function()? rejected,
    T Function()? fulfilled,
  }) {
    switch (this) {
      case Status.Idle:
        return idle?.call();
      case Status.Pending:
        return pending?.call();
      case Status.Rejected:
        return rejected?.call();
      case Status.Fulfilled:
        return fulfilled?.call();
      default:
        return null;
    }
  }

  T? mapMaybe<T>({
    required T Function() orElse,
    T Function()? idle,
    T Function()? pending,
    T Function()? rejected,
    T Function()? fulfilled,
  }) {
    return this.map(
            idle: idle,
            pending: pending,
            rejected: rejected,
            fulfilled: fulfilled) ??
        orElse();
  }
}

Future<void> statefulAction({
  required StateController<Status> Function() status,
  StateController<dynamic> Function()? error,
  required Future Function() action,
}) async {
  status().state = Status.Pending;
  try {
    await action();
    error?.call().state = null;
    status().state = Status.Fulfilled;
  } catch (e) {
    error?.call().state = e;
    status().state = Status.Rejected;
  }
}

Future<void> statefulFetch<T>({
  required StateController<Status> Function() status,
  required StateController<T> Function() data,
  StateController<dynamic> Function()? error,
  required Future Function() fetch,
}) async {
  status().state = Status.Pending;
  try {
    data().state = await fetch();
    error?.call().state = null;
    status().state = Status.Fulfilled;
  } catch (e) {
    error?.call().state = e;
    status().state = Status.Rejected;
  }
}
