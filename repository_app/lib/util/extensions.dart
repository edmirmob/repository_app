import 'package:flutter_riverpod/flutter_riverpod.dart';

extension FutureExtensions<T> on Future<T> {
  Future<AsyncValue<T>> asyncData() async {
    try {
      final T data = await this;
      return AsyncValue.data(data);
    } catch (error, stack) {
      return AsyncValue.error(error, stack);
    }
  }
}

extension IterableExtensions<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    try {
      return firstWhere(test);
    } on StateError catch (_) {
     
      return null;
    }
  }
}
