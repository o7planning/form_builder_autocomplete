import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_autocomplete/form_builder_autocomplete.dart';

void main() {
  runApp(const FaAutocompleteExampleApp());
}

class FaAutocompleteExampleApp extends StatelessWidget {
  const FaAutocompleteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormBuilder Autocomplete Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const AutocompletePlaygroundPortal(),
    );
  }
}

/// A clean enterprise mock data structure representing a user profile object entity
class UserAccount {
  final String uid;
  final String fullName;
  final String department;

  const UserAccount({
    required this.uid,
    required this.fullName,
    required this.department,
  });
}

class AutocompletePlaygroundPortal extends StatefulWidget {
  const AutocompletePlaygroundPortal({super.key});

  @override
  State<AutocompletePlaygroundPortal> createState() =>
      _AutocompletePlaygroundPortalState();
}

class _AutocompletePlaygroundPortalState
    extends State<AutocompletePlaygroundPortal> {
  final _formKey = GlobalKey<FormBuilderState>();

  // High-volume mock repository for strict local predictable filtering
  final List<String> _globalCountriesDatabase = [
    'Argentina',
    'Australia',
    'Brazil',
    'Canada',
    'Denmark',
    'Egypt',
    'France',
    'Germany',
    'India',
    'Indonesia',
    'Japan',
    'Malaysia',
    'Mexico',
    'Netherlands',
    'Philippines',
    'Singapore',
    'South Korea',
    'Thailand',
    'United Kingdom',
    'United States',
    'Vietnam',
    'Zimbabwe',
  ];

  Map<String, dynamic>? _submittedDataSnapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predictive Input Form Portal'),
        centerTitle: true,
        backgroundColor: Colors.teal.withValues(alpha: 0.1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DEMO 1: LOCAL TEXT FILTERING (SIMPLE STRING)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Example 1: Local predictive search returning simple Strings
                      FormBuilderAutocomplete<String>(
                        name: 'target_country',
                        decoration: const InputDecoration(
                          labelText: 'Select Country Region',
                          hintText: 'Type to search (e.g., Viet, United...)',
                          prefixIcon: Icon(Icons.public_outlined),
                          border: OutlineInputBorder(),
                        ),
                        displayStringForOption: (option) => option,
                        searchItems: (String searchText) async {
                          // Immediate inline local computation mapping
                          return _globalCountriesDatabase
                              .where(
                                (country) => country.toLowerCase().contains(
                                  searchText.toLowerCase(),
                                ),
                              )
                              .toList();
                        },
                      ),

                      const SizedBox(height: 32),
                      const Text(
                        'DEMO 2: ASYNC REMOTE QUERY (COMPLEX OBJECT ENTITY)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Example 2: Delayed query mapping complex runtime Entities
                      FormBuilderAutocomplete<UserAccount>(
                        name: 'assigned_manager',
                        decoration: const InputDecoration(
                          labelText: 'Assign Project Manager Account',
                          hintText: 'Type employee name (e.g., Alex, Sam...)',
                          prefixIcon: Icon(Icons.badge_outlined),
                          border: OutlineInputBorder(),
                        ),
                        displayStringForOption:
                            (user) => '${user.fullName} (${user.department})',

                        // Customizes the prediction drop-down list UI elements beautifully
                        optionsViewBuilder: (context, onSelected, options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(8.0),
                              child: SizedBox(
                                width: 500,
                                height: 250,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    final UserAccount option = options
                                        .elementAt(index);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.teal.withValues(
                                          alpha: 0.2,
                                        ),
                                        child: Text(option.fullName[0]),
                                      ),
                                      title: Text(
                                        option.fullName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'ID: ${option.uid} • Dept: ${option.department}',
                                      ),
                                      onTap: () => onSelected(option),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        searchItems: (String searchText) async {
                          // Simulate dynamic background engine latency delay network pipeline
                          await Future.delayed(
                            const Duration(milliseconds: 400),
                          );

                          final List<UserAccount> mockServerDatabase = [
                            const UserAccount(
                              uid: 'USR-701',
                              fullName: 'Alex Mercer',
                              department: 'Cyber Security',
                            ),
                            const UserAccount(
                              uid: 'USR-702',
                              fullName: 'Alexander Pierce',
                              department: 'R&D Lab',
                            ),
                            const UserAccount(
                              uid: 'USR-804',
                              fullName: 'Samantha Green',
                              department: 'Product Operations',
                            ),
                            const UserAccount(
                              uid: 'USR-911',
                              fullName: 'Samuel Jackson',
                              department: 'Executive Hub',
                            ),
                            const UserAccount(
                              uid: 'USR-952',
                              fullName: 'Victoria Sterling',
                              department: 'UI/UX Guild',
                            ),
                          ];

                          return mockServerDatabase
                              .where(
                                (user) => user.fullName.toLowerCase().contains(
                                  searchText.toLowerCase(),
                                ),
                              )
                              .toList();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Operational Portal Action Trigger Bar
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.cloud_upload_outlined),
                        label: const Text('Save & Extract Form Data'),
                        onPressed: () {
                          if (_formKey.currentState?.saveAndValidate() ??
                              false) {
                            setState(() {
                              _submittedDataSnapshot =
                                  _formKey.currentState!.value;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        _formKey.currentState?.reset();
                        setState(() {
                          _submittedDataSnapshot = null;
                        });
                      },
                      child: const Text('Reset Form'),
                    ),
                  ],
                ),

                // Structural Result Trace Monitor Panel
                if (_submittedDataSnapshot != null) ...[
                  const SizedBox(height: 28),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.teal.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'EXTRACTED TYPE-SAFE OBJECT REGISTRY:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Output 1: String
                        Text(
                          '1. Country Selected: "${_submittedDataSnapshot!['target_country'] ?? 'None'}"',
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Output 2: Complex Class Object properties
                        Builder(
                          builder: (context) {
                            final manager =
                                _submittedDataSnapshot!['assigned_manager'];
                            if (manager == null) {
                              return const Text(
                                '2. Manager Selected: Null Object',
                              );
                            }
                            final UserAccount account = manager as UserAccount;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '2. Manager Locked Instance Object Details:',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    top: 4.0,
                                  ),
                                  child: Text(
                                    '• Object Type: ${account.runtimeType}\n'
                                    '• Full Name: ${account.fullName}\n'
                                    '• Unique UID: ${account.uid}\n'
                                    '• Division: ${account.department}',
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 13,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
