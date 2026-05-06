import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

mixin SearchOverlayKeyboardNavigator<T> {
  final FocusNode _overlayFocusNode = FocusNode();
  int _highlightedIndex = -1;

  void disposeOverlayFocus() {
    _overlayFocusNode.dispose();
  }

  void resetHighlight() {
    _highlightedIndex = -1;
  }

  Widget wrapWithKeyboardNavigation({
    required BuildContext context,
    required SuggestionsController<T> controller,
    required Widget child,
    required List<T> Function() getItems,
    required void Function(T item) onSelected,
  }) {
    return Focus(
      skipTraversal: true,
      canRequestFocus: false,
      onKeyEvent: (_, event) {
        if (event is! KeyDownEvent) return KeyEventResult.ignored;

        if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
            event.logicalKey == LogicalKeyboardKey.numpad2) {
          if (controller.isOpen) {
            _navigateDown(getItems(), onSelected);
            return KeyEventResult.handled;
          } else {
            controller.open();
            return KeyEventResult.handled;
          }
        }

        if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
            event.logicalKey == LogicalKeyboardKey.numpad8) {
          if (controller.isOpen) {
            _navigateUp(getItems(), onSelected);
            return KeyEventResult.handled;
          }
        }

        if (event.logicalKey == LogicalKeyboardKey.enter ||
            event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          if (controller.isOpen && _highlightedIndex >= 0) {
            final items = getItems();
            if (_highlightedIndex < items.length) {
              onSelected(items[_highlightedIndex]);
              controller.close();
              resetHighlight();
              return KeyEventResult.handled;
            }
          }
        }

        if (event.logicalKey == LogicalKeyboardKey.escape) {
          controller.close();
          resetHighlight();
          return KeyEventResult.handled;
        }

        return KeyEventResult.ignored;
      },
      child: child,
    );
  }

  void _navigateDown(List<dynamic> items, void Function(T item) onSelected) {
    if (items.isEmpty) return;
    _highlightedIndex = (_highlightedIndex + 1).clamp(0, items.length - 1);
  }

  void _navigateUp(List<dynamic> items, void Function(T item) onSelected) {
    if (items.isEmpty) return;
    if (_highlightedIndex <= 0) {
      _highlightedIndex = -1;
    } else {
      _highlightedIndex--;
    }
  }

  Color? getItemColor(int index, BuildContext context) {
    if (index == _highlightedIndex) {
      return Theme.of(context).colorScheme.primary.withValues(alpha: 0.1);
    }
    return null;
  }

  bool isItemHighlighted(int index) => index == _highlightedIndex;
}
