
# form_builder_autocomplete

A highly optimized, type-safe asynchronous predictive input extension widget for the `flutter_form_builder` ecosystem.

This package simplifies complex predictive text filtering by binding Flutter's native `Autocomplete` architecture directly into the form control state registries, eliminating manual state synchronization and text controller management boilerplate.

---

##  Key Functional Features

* **Type-Safe Object Mapping:** Manages complex object structures natively, binding data entity objects directly into the parent `FormBuilder` state index.
* **Smart State Invalidation:** Automatically detects manual field erasure and clears the underlying form control state values when the text input is blanked.
* **Debounced Async Pipelines:** Seamlessly handles remote API endpoints or local high-volume list searching queries via an intuitive asynchronous data fetch callback protocol.
* **Polished Decorator Overlay:** Inherits total visual control from standard FormField fields, supporting complete `InputDecoration` custom styling wrappers.

---

## 里 Basic Usage Implementation

Define your data model and pass your lookup logic directly through the `searchItems` channel:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_autocomplete/form_builder_autocomplete.dart';

// Sample enterprise mock data object entity
class UserProfile {
  final String id;
  final String fullName;
  const UserProfile({required this.id, required this.fullName});
}

Widget buildUserSearchField(BuildContext context) {
  return FormBuilderAutocomplete<UserProfile>(
    name: 'assigned_operator',
    decoration: const InputDecoration(
      labelText: "Search Operator Account",
      border: OutlineInputBorder(),
    ),
    displayStringForOption: (user) => user.fullName,
    searchItems: (searchText) async {
      // Simulate remote network data compiler delays or localized criteria filtering
      await Future.delayed(const Duration(milliseconds: 300));
      final List<UserProfile> mockDatabase = [
        const UserProfile(id: '01', fullName: 'Alex Mercer'),
        const UserProfile(id: '02', fullName: 'Samantha Green'),
      ];
      
      return mockDatabase
          .where((user) => user.fullName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    },
    onSelected: (user) {
      print("Focal entity locked: ${user.id} - ${user.fullName}");
    },
  );
}

```

---

##  Installation Manifest

Add this configuration segment directly into your project's `pubspec.yaml` tracking descriptor:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_form_builder: ^latest_version
  form_builder_autocomplete: ^latest_version

``` 