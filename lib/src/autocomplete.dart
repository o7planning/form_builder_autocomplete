import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// An advanced Autocomplete input extension widget for the [FormBuilder] ecosystem.
///
/// Seamlessly wires Flutter's native asynchronous [Autocomplete] capabilities
/// directly into the form state registry.
class FormBuilderAutocomplete<E extends Object> extends StatelessWidget {
  /// The explicit semantic identifier token bound to the parent form map.
  final String name;

  /// Translates the complex selected object entity into a readable display string.
  final AutocompleteOptionToString<E> displayStringForOption;

  /// Asynchronous query callback to retrieve filtered suggestions matching user text.
  final Future<List<E>> Function(String searchText) searchItems;

  /// Triggers immediately when a matching predictive suggestion item is chosen.
  final void Function(E)? onSelected;

  /// Custom floating options view window compiler hook override.
  final Widget Function(BuildContext, void Function(E), Iterable<E>)?
  optionsViewBuilder;

  /// Floating popup expansion vector orientation.
  final OptionsViewOpenDirection optionsViewOpenDirection;

  /// The baseline initial object entity injected into the workspace.
  final E? initialValue;

  /// Evaluates and constraints data state validation logic rules.
  final FormFieldValidator<E>? validator;

  /// Defines the keyboard focus loop mechanics for this form control component.
  final FocusNode? focusNode;

  /// The structural layout envelope framing the input viewport box.
  final InputDecoration decoration;

  /// Custom typography styling to apply to the typed search input text.
  final TextStyle? style;

  /// The type of digital action button to map onto the system virtual keyboard.
  final TextInputAction? textInputAction;

  /// Disables input entry interactions and locks editing capabilities if false.
  final bool enabled;

  const FormBuilderAutocomplete({
    super.key,
    required this.name,
    required this.displayStringForOption,
    required this.searchItems,
    this.onSelected,
    this.initialValue,
    this.optionsViewBuilder,
    this.optionsViewOpenDirection = OptionsViewOpenDirection.down,
    this.decoration = const InputDecoration(),
    this.style,
    this.textInputAction,
    this.focusNode,
    this.validator,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<E>(
      name: name,
      initialValue: initialValue,
      focusNode: focusNode,
      validator: validator,
      enabled: enabled,
      builder: (FormFieldState<E> fields) {
        final E? value = fields.value;
        final String initString =
            value == null ? "" : displayStringForOption(value);

        return Autocomplete<E>(
          key: Key("Autocomplete-$initString"),
          displayStringForOption: displayStringForOption,
          optionsViewBuilder: optionsViewBuilder,
          optionsViewOpenDirection: optionsViewOpenDirection,
          initialValue: TextEditingValue(text: initString),
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return Iterable<E>.empty();
            }
            return await searchItems(textEditingValue.text);
          },
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController textEditingController,
            FocusNode effectiveFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            // Smart UX Synchronization Hook:
            textEditingController.addListener(() {
              if (textEditingController.text.isEmpty && fields.value != null) {
                fields.didChange(null);
              }
            });

            return TextFormField(
              controller: textEditingController,
              focusNode: effectiveFocusNode,
              decoration: decoration.copyWith(errorText: fields.errorText),
              style: style,
              textInputAction: textInputAction,
              enabled: enabled,
              readOnly: !enabled,
              minLines: 1,
              maxLines: 1,
              onFieldSubmitted: (String _) => onFieldSubmitted(),
            );
          },
          onSelected: (E selection) {
            fields.didChange(selection);
            if (onSelected != null) {
              onSelected!(selection);
            }
          },
        );
      },
    );
  }
}
