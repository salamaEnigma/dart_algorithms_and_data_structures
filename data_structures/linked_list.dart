import 'package:test/test.dart';

class Node<T> {
  Node(this.value);

  T value;
  Node<T>? next;
}

class LinkedList<T> extends Iterable<T> {
  @override
  int length = 0;

  @override
  Iterator<T> get iterator => LinkedListIterator<T>(this._head);

  Node<T>? _head;
  Node<T>? _tail;

  /// Pseudocode:
  /// - This function should accept a value.
  /// - Create a new node using the value passed to the function.
  /// - If there is no head property on the list, set the head and tail to be the newly created node.
  /// - Otherwise set the next property on the tail to be the new node and set the tail property
  ///   on the list to be the newly created node.
  /// - Increment the length by one.
  /// - Return the linked list.
  LinkedList<T> push(T value) {
    final newNode = Node(value);
    if (_head == null) {
      _head = newNode;
      _tail = newNode;
    } else {
      _tail!.next = newNode;
      _tail = newNode;
    }
    length++;
    return this;
  }

  /// Pseudocode:
  /// - If there are no nodes in the list, return undefined.
  /// - Loop through the list until you reach the tail.
  /// - Set the next property of the 2nd to last node to be null.
  /// - Set the tail to be the 2nd to last node.
  /// - Decrement the length of the list by 1.
  /// - Return the value of the node removed.
  T? pop() {
    if (_head == null) return null;

    Node<T>? temp = _head;
    Node<T>? previousNode;

    while (temp?.next != null) {
      previousNode = temp;
      temp = temp?.next;
    }

    _tail = previousNode;
    _tail?.next = null;

    length--;
    // if there's no items in the list, reset the head to null too.
    if (length == 0) _head = null;
    return temp?.value;
  }

  /// Pseudocode:
  /// - If there are no nodes, return undefined.
  /// - Store the current head property in a variable.
  /// - Set the head property to be the current head's next property.
  /// - Decrement the length by 1.
  /// - Return the value of the node removed.
  T? shift() {
    if (_head == null) return null;

    Node<T>? temp = _head;
    _head = temp?.next;

    length--;
    // if there's no items in the list, reset the tail to null too.
    if (length == 0) _tail = null;
    return temp?.value;
  }

  /// Pseudocode:
  /// - This function should accept a value.
  /// - Create a new node using the value passed to the function.
  /// - If there is no head property on the list, set the head and tail to be the newly created node.
  /// - Otherwise set the newly created node's next property to be the current head property on the list.
  /// - Set the head property on the list to be that newly created node.
  /// - Increment the length of the list by 1.
  /// - Return the linked list.
  LinkedList<T> unShift(T value) {
    final newNode = Node(value);
    if (_head == null) {
      _head = newNode;
      _tail = newNode;
    } else {
      newNode.next = _head;
      _head = newNode;
    }
    length++;
    return this;
  }

  /// Pseudocode:
  /// - This function should accept an index.
  /// - If the index is less than zero or greater than or equal to the length of the list, return null.
  /// - Loop through the list until you reach the index and return the node at that specific index.
  T? get(int index) {
    return _getNodeAtIndex(index)?.value;
  }

  Node<T>? _getNodeAtIndex(int index) {
    if (index < 0 || index >= length) return null;

    Node<T>? current = _head;
    for (int i = 0; i < index; i++) {
      current = current?.next;
    }
    return current;
  }

  /// Pseudocode:
  /// - This function should accept a value and an index.
  /// - Use your get function to find the specific node.
  /// - If the node is not found, return false.
  /// - If the node is found, set the value of that node to be the value passed to the function and return true.
  bool set(int index, T value) {
    final node = _getNodeAtIndex(index);
    if (node != null) {
      node.value = value;
      return true;
    }
    return false;
  }

  /// Pseudocode:
  /// - If the index is less than zero or greater than the length, return false.
  /// - If the index is the same as the length, push a new node to the end of the list.
  /// - If the index is 0, unshift a new node to the start of the list.
  /// - Otherwise, using the get method, access the node at the index - 1.
  /// - Set the next property on that node to be the new node.
  /// - Set the next property on the new node to be the previous next.
  /// - Increment the length.
  /// - Return true.
  bool insert(int index, T value) {
    if (index < 0 || index > length) return false;

    if (index == length) {
      push(value);
    } else if (index == 0) {
      unShift(value);
    } else {
      final newNode = Node(value);
      final previousNode = _getNodeAtIndex(index - 1)!;
      newNode.next = previousNode.next;
      previousNode.next = newNode;
      length++;
    }
    return true;
  }

  /// Pseudocode:
  /// - If the index is less than zero or greater than or equal to the length, return undefined.
  /// - If the index is the same as the length-1, pop.
  /// - If the index is 0, shift.
  /// - Otherwise, using the get method, access the node at the index - 1.
  /// - Set the next property on that node to be the next of the next node.
  /// - Decrement the length.
  /// - Return the value of the node removed.
  T? remove(int index) {
    if (index < 0 || index >= length) return null;

    if (index == length - 1) return pop();
    if (index == 0) return shift();

    final removedNode = _getNodeAtIndex(index)!;
    final previousNode = _getNodeAtIndex(index - 1)!;
    previousNode.next = removedNode.next;
    length--;
    return removedNode.value;
  }

  /// Pseudocode:
  /// - Swap the head and tail.
  /// - Create a variable called next.
  /// - Create a variable called prev.
  /// - Create a variable called node and initialize it to the head property.
  /// - Loop through the list.
  /// - Set next to be the next property on whatever node is.
  /// - Set the next property on the node to be whatever prev is.
  /// - Set prev to be the value of the node variable.
  /// - Set the node variable to be the value of the next variable.
  /// - Once you have finished looping, return the list.
  LinkedList<T> reverse() {
    if (length <= 1) return this;

    Node<T>? currentNode = _head;
    _head = _tail;
    _tail = currentNode;

    Node<T>? tempNext;
    Node<T>? tempPrevious;
    for (int i = 0; i < length; i++) {
      tempNext = currentNode?.next;
      currentNode?.next = tempPrevious;
      tempPrevious = currentNode;
      currentNode = tempNext;
    }

    return this;
  }

  @override
  String toString() {
    List<T> values = [];
    Node<T>? currentNode = _head;
    while (currentNode != null) {
      values.add(currentNode.value);
      currentNode = currentNode.next;
    }
    return values.toString();
  }
}

class LinkedListIterator<T> extends Iterator<T> {
  Node<T>? _current;

  @override
  bool moveNext() => _current != null;

  @override
  T get current {
    T currentValue = this._current!.value;

    this._current = this._current!.next;

    return currentValue;
  }

  LinkedListIterator(this._current);
}

void main() {
  group('push', () {
    test('should push items in order', () {
      final linkedList = LinkedList<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList, [1, 2, 3]);
      expect(linkedList.length, 3);
      expect(linkedList._head, isA<Node>().having((p) => p.value, 'value', 1));
      expect(linkedList._tail, isA<Node>().having((p) => p.value, 'value', 3));
    });
  });

  group('pop', () {
    test('should pop and return the tail', () {
      final linkedList = LinkedList<int>();
      linkedList.push(1);
      linkedList.push(2);
      linkedList.push(3);

      expect(linkedList.pop(), 3);
      expect(linkedList, [1, 2]);
      expect(linkedList.length, 2);
      expect(linkedList._tail, isA<Node>().having((p) => p.value, 'value', 2));
    });

    test('should return null if the list is empty', () {
      final linkedList = LinkedList<int>();

      expect(linkedList.pop(), isNull);
      expect(linkedList, equals([]));
    });
  });

  //TODO: Test the rest of the methods.
}