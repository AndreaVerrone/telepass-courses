extension InterleaveList<T> on List<T> {
  /// Returns a new list where each element of this is interleaved by `element`
  List<T> interleave(T element) {
    if (isEmpty || length == 1) {
      return [...this];
    }
    List<T> newList = [];
    for (var i = 0; i < length; i++) {
      newList.add(this[i]);
      if (i < length - 1) {
        newList.add(element);
      }
    }
    return newList;
  }
}

extension InterleaveIterable<T> on Iterable<T> {
  /// Interleaves each element of this iterable with `element`, returning a new list
  List<T> interleave(T element) {
    return toList().interleave(element);
  }
}
