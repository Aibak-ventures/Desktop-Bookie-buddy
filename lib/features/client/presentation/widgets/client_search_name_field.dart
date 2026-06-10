import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_shimmer_box.dart';
import 'package:bookie_buddy_web/features/client/domain/entities/client_entity/client_entity.dart';
import 'package:bookie_buddy_web/features/client/presentation/bloc/client_cubit/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ClientSearchNameField extends StatefulWidget {
  const ClientSearchNameField({
    super.key,
    required this.nameController,
    this.scrollController,
    this.onClear,
    this.hitText = 'Client Name',
    this.isSearchEnabled = true,
    this.focusNode,
    this.errorText,
    this.onClientSelected,
  });

  final TextEditingController nameController;
  final ScrollController? scrollController;
  final VoidCallback? onClear;
  final String hitText;
  final bool isSearchEnabled;
  final FocusNode? focusNode;
  final String? errorText;
  final ValueChanged<ClientEntity>? onClientSelected;

  @override
  State<ClientSearchNameField> createState() => _ClientSearchNameFieldState();
}

class _ClientSearchNameFieldState extends State<ClientSearchNameField> {
  late final SuggestionsController<ClientEntity> _suggestionsController;
  int _highlightedIndex = -1;
  List<ClientEntity> _currentSuggestions = [];

  @override
  void initState() {
    super.initState();
    _suggestionsController = SuggestionsController<ClientEntity>();
  }

  @override
  void dispose() {
    _suggestionsController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
        event.logicalKey == LogicalKeyboardKey.numpad2) {
      if (_suggestionsController.isOpen) {
        setState(() {
          if (_highlightedIndex < _currentSuggestions.length - 1) {
            _highlightedIndex++;
          }
        });
      } else {
        _suggestionsController.open();
      }
    } else if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
        event.logicalKey == LogicalKeyboardKey.numpad8) {
      if (_suggestionsController.isOpen) {
        setState(() {
          if (_highlightedIndex > 0) {
            _highlightedIndex--;
          }
        });
      }
    } else if (event.logicalKey == LogicalKeyboardKey.enter ||
        event.logicalKey == LogicalKeyboardKey.numpadEnter) {
      if (_suggestionsController.isOpen &&
          _highlightedIndex >= 0 &&
          _highlightedIndex < _currentSuggestions.length) {
        final client = _currentSuggestions[_highlightedIndex];
        if (client.id != -1) {
          context.read<ClientCubit>().selectClient(client);
          widget.onClientSelected?.call(client);
          _suggestionsController.close();
          setState(() {
            _highlightedIndex = -1;
          });
        }
      }
    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
      _suggestionsController.close();
      setState(() {
        _highlightedIndex = -1;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Focus(
        skipTraversal: true,
        canRequestFocus: false,
        onFocusChange: (_) {},
        onKeyEvent: (_, event) {
          if (event is! KeyDownEvent) return KeyEventResult.ignored;
          final key = event.logicalKey;
          final isHandled =
              key == LogicalKeyboardKey.arrowDown ||
              key == LogicalKeyboardKey.arrowUp ||
              key == LogicalKeyboardKey.escape ||
              (key == LogicalKeyboardKey.enter &&
                  _suggestionsController.isOpen &&
                  _highlightedIndex >= 0) ||
              (key == LogicalKeyboardKey.numpadEnter &&
                  _suggestionsController.isOpen &&
                  _highlightedIndex >= 0);
          if (isHandled) _handleKeyEvent(event);
          return isHandled ? KeyEventResult.handled : KeyEventResult.ignored;
        },
        child: TypeAheadField<ClientEntity>(
          controller: widget.nameController,
          focusNode: widget.focusNode,
          suggestionsController: _suggestionsController,
          scrollController: widget.scrollController,
          debounceDuration: const Duration(milliseconds: 300),
          hideOnEmpty: true,
          hideWithKeyboard: false,
          hideOnUnfocus: true,
          hideOnSelect: true,
          builder: (context, controller, focusNode) => Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: widget.errorText != null
                    ? Colors.red.shade400
                    : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  size: 16,
                  color: widget.errorText != null
                      ? Colors.red.shade400
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: controller,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hitText,
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, searchValue, child) =>
                      searchValue.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            controller.clear();
                            context.read<ClientCubit>().clearSelected(
                              widget.onClear,
                            );
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ],
            ),
          ),
          itemBuilder: (context, client) {
            final index = _currentSuggestions.indexOf(client);
            if (client.id == -1) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: const Text(
                  'No client found',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              );
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _highlightedIndex == index
                    ? AppColors.purple.withValues(alpha: 0.1)
                    : Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    client.phone1E164 ??
                        (client.phone1 > 0 ? client.phone1.toString() : ''),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
          suggestionsCallback: (query) async {
            if (!widget.isSearchEnabled) return [];

            final selected = context.read<ClientCubit>().state.selectedClient;
            if (selected != null && query == selected.name) return null;

            if (query.isEmpty) {
              final results = await context.read<ClientCubit>().searchClient(
                '',
              );
              _currentSuggestions = results.isEmpty
                  ? [
                      const ClientEntity(
                        id: -1,
                        name: 'No client found',
                        phone1: 0,
                      ),
                    ]
                  : results;
              return _currentSuggestions;
            }

            final results = await context.read<ClientCubit>().searchClient(
              query,
            );
            _currentSuggestions = results.isEmpty
                ? [
                    const ClientEntity(
                      id: -1,
                      name: 'No client found',
                      phone1: 0,
                    ),
                  ]
                : results;
            return _currentSuggestions;
          },
          onSelected: (client) {
            if (client.id == -1) return;
            setState(() {
              _highlightedIndex = -1;
            });
            context.read<ClientCubit>().selectClient(client);
            widget.onClientSelected?.call(client);
          },
          emptyBuilder: (context) => const SizedBox(
            height: 100,
            child: Center(child: Text('No client found')),
          ),
          errorBuilder: (context, error) => SizedBox(
            height: 100,
            child: Center(child: Text(error.toString())),
          ),
          loadingBuilder: (context) => ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              title: Row(
                children: [CustomShimmerBox(width: 0.11.widthR, height: 20)],
              ),
              subtitle: Row(
                children: [CustomShimmerBox(width: 0.12.widthR, height: 15)],
              ),
            ),
          ),
        ),
      ),
      if (widget.errorText != null) ...[
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            widget.errorText!,
            style: TextStyle(
              fontSize: 11,
              color: Colors.red.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ],
  );
}
