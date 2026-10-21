import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurement_rules.dart';
import 'package:bookie_buddy_shared/core/core/constants/measurement_constants.dart';
import 'package:bookie_buddy_web/core/common/widgets/custom_textfield.dart';
import 'package:bookie_buddy_web/core/common/widgets/dialogs/show_discard_dialog.dart';
import 'package:bookie_buddy_shared/core/core/constants/enums/gender_type_enums.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/measurement_value_entity/measurement_value_entity.dart';
import 'package:bookie_buddy_shared/core/features/booking/domain/entities/person_measurements_entity/person_measurements_entity.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/helpers/booking_product_helpers.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/models/measurement_field_form_state.dart';
import 'package:bookie_buddy_web/features/booking/presentation/common/widgets/person_measurements_panel.dart';
import 'package:bookie_buddy_web/features/product/domain/entities/product_selected_entity/product_selected_entity.dart';
import 'package:bookie_buddy_web/utils/app_input_validators.dart';
import 'package:bookie_buddy_web/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:bookie_buddy_web/core/theme/app_colors.dart';

class ProductCustomizationWidget extends StatefulWidget {
  const ProductCustomizationWidget({
    super.key,
    required this.onBack,
    required this.onSaveForProduct,
    required this.selectedProducts,
  });

  final VoidCallback onBack;
  final Function(
    ProductSelectedEntity product,
    List<PersonMeasurementsEntity> peopleMeasurements,
  )
  onSaveForProduct;
  final List<ProductSelectedEntity> selectedProducts;

  @override
  State<ProductCustomizationWidget> createState() =>
      _ProductCustomizationWidgetState();
}

class _ProductCustomizationWidgetState
    extends State<ProductCustomizationWidget> {
  final ValueNotifier<List<MeasurementFieldFormState>> measurementsNotifier =
      ValueNotifier([]);
  final customCustomizationController = TextEditingController();
  final genderNotifier = ValueNotifier<GenderType>(GenderType.male);
  final formKey = GlobalKey<FormState>();

  // Currently selected product for customization
  ProductSelectedEntity? selectedProduct;
  int? selectedProductIndex;

  final nameController = TextEditingController();

  /// The people of [selectedProduct] being edited, saved together.
  List<PersonMeasurementsEntity> _people = [];

  /// Index in [_people] of the person whose form is open, or `null` while the
  /// people list is showing.
  int? _editingIndex;

  /// A line with one unit and at most one person has no people list: the form
  /// is the whole editor, as before per-person measurements existed.
  bool _singleMode = true;

  /// What the people list / the form held when it was opened or last saved.
  String _peopleBaseline = '';
  String _formBaseline = '';

  bool get _isEditingPerson => _editingIndex != null;

  /// The form shows a name field only when editing one of several people.
  bool get _showsNameField => _isEditingPerson && !_singleMode;

  @override
  void initState() {
    super.initState();
    // Auto-select first product without measurements
    _selectFirstProductWithoutMeasurements();
  }

  void _selectFirstProductWithoutMeasurements() {
    for (int i = 0; i < widget.selectedProducts.length; i++) {
      if (widget.selectedProducts[i].peopleMeasurements.isEmpty) {
        setState(() {
          selectedProduct = widget.selectedProducts[i];
          selectedProductIndex = i;
        });
        _loadSelectedProduct();
        return;
      }
    }
    // If all products have measurements, select the first one
    if (widget.selectedProducts.isNotEmpty) {
      setState(() {
        selectedProduct = widget.selectedProducts.first;
        selectedProductIndex = 0;
      });
      _loadSelectedProduct();
    }
  }

  @override
  void didUpdateWidget(covariant ProductCustomizationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // After a save the parent hands over the updated lines; follow the one
    // being edited without touching the form.
    final current = selectedProduct;
    if (current == null) return;
    final key = BookingProductHelpers.productKey(current);
    final updated = widget.selectedProducts
        .where((p) => BookingProductHelpers.productKey(p) == key)
        .firstOrNull;
    if (updated != null && updated != current) {
      selectedProduct = updated;
    }
  }

  /// Opens the editor for [selectedProduct]: straight to the form for a plain
  /// one-person line, otherwise the people list.
  void _loadSelectedProduct() {
    final product = selectedProduct;
    if (product == null) {
      _people = [];
      _editingIndex = null;
      _singleMode = true;
      _initializeMeasurements(const []);
      return;
    }
    final saved = product.peopleMeasurements;
    _singleMode = PersonMeasurementRules.usesSinglePersonForm(
      saved.length,
      product.quantity,
    );
    if (_singleMode) {
      _people = saved;
      _openPerson(0, saved.isEmpty ? const [] : saved.first.measurements);
    } else {
      _people = saved.isEmpty
          ? [const PersonMeasurementsEntity(name: '')]
          : saved;
      _editingIndex = null;
      _initializeMeasurements(const []);
      nameController.clear();
      _formBaseline = '';
    }
    _peopleBaseline = _people.fingerprint;
  }

  /// Fills the form with person [index]'s [measurements] and shows it.
  void _openPerson(int index, List<MeasurementValueEntity> measurements) {
    _editingIndex = index;
    nameController.text = !_singleMode && index < _people.length
        ? PersonMeasurementRules.displayName(_people[index].name, index)
        : '';
    _initializeMeasurements(measurements);
    _formBaseline = [_formPerson()].fingerprint;
  }

  void _initializeMeasurements(
    List<MeasurementValueEntity> productMeasurements,
  ) {
    // Dispose old controllers once the frame that stops using them is done:
    // a focused field still listens to its controller until it is rebuilt.
    final oldFields = measurementsNotifier.value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final field in oldFields) {
        field.controller.dispose();
      }
    });

    if (selectedProduct == null) {
      measurementsNotifier.value = [];
      return;
    }

    if (productMeasurements.isNotEmpty) {
      final genders = productMeasurements.map((e) => e.gender).toSet();
      final filteredGenders = genders
          .where((g) => g != GenderType.unisex)
          .toSet();

      if (filteredGenders.length == 1) {
        genderNotifier.value = filteredGenders.first ?? GenderType.unisex;
      } else {
        genderNotifier.value = GenderType.unisex;
      }
    }

    final baseMeasurements = MeasurementFieldFormState.standardFields();

    final updatedMeasurements = baseMeasurements.map((field) {
      final existing = productMeasurements.firstWhere(
        (e) => e.key == field.key,
        orElse: () => MeasurementValueEntity(
          name: field.name,
          key: field.key,
          value: '',
          gender: field.gender,
        ),
      );
      return field.copyWith(
        controller: TextEditingController(text: existing.value),
      );
    }).toList();

    final customMeasurements = productMeasurements
        .where((e) => !baseMeasurements.any((f) => f.key == e.key))
        .map(
          (e) => MeasurementFieldFormState(
            name: e.name,
            key: e.key,
            description: '',
            gender: e.gender ?? GenderType.unisex,
            controller: TextEditingController(text: e.value),
          ),
        )
        .toList();

    measurementsNotifier.value = [
      ...updatedMeasurements,
      ...customMeasurements,
    ];
  }

  @override
  void dispose() {
    genderNotifier.dispose();
    nameController.dispose();
    measurementsNotifier.value.forEach(
      (element) => element.controller.dispose(),
    );
    customCustomizationController.dispose();
    super.dispose();
  }

  /// The form's filled values as a person. The name only matters for one of
  /// several people; a lone person keeps the name they already had.
  PersonMeasurementsEntity _formPerson() {
    final index = _editingIndex ?? 0;
    final existingName = index < _people.length ? _people[index].name : '';
    return PersonMeasurementsEntity(
      name: _showsNameField ? nameController.text.trim() : existingName,
      measurements: [
        for (final field in measurementsNotifier.value)
          if (field.controller.text.trim().isNotEmpty)
            MeasurementValueEntity(
              name: field.name,
              key: field.key,
              value: field.controller.text.trim(),
              gender: field.gender,
            ),
      ],
    );
  }

  bool get _isDirty {
    final formChanged =
        _isEditingPerson && [_formPerson()].fingerprint != _formBaseline;
    if (_singleMode) return formChanged;
    return formChanged || _people.fingerprint != _peopleBaseline;
  }

  /// Asks before throwing away something the user entered. `true` when it is
  /// fine to go on.
  Future<bool> _confirmDiscard({bool formOnly = false}) async {
    final dirty = formOnly
        ? _isEditingPerson && [_formPerson()].fingerprint != _formBaseline
        : _isDirty;
    if (!dirty) return true;
    final discard = await showDiscardDialog(
      context,
      message:
          'Are you sure you want to discard your changes? The measurements '
          'you entered will be lost.',
    );
    return discard ?? false;
  }

  Future<void> _goBack() async {
    if (await _confirmDiscard() && mounted) widget.onBack();
  }

  Future<void> _selectProduct(ProductSelectedEntity product, int index) async {
    if (!await _confirmDiscard() || !mounted) return;
    setState(() {
      selectedProduct = product;
      selectedProductIndex = index;
      _loadSelectedProduct();
    });
  }

  Set<String> _namesExcept(int index) => {
    for (final (i, p) in _people.indexed)
      if (i != index)
        PersonMeasurementRules.displayName(p.name, i).toLowerCase(),
  };

  String? _validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) return 'Enter a name';
    if (_namesExcept(_editingIndex ?? -1).contains(name.toLowerCase())) {
      return 'This name is already used';
    }
    return null;
  }

  void _editPerson(int index) {
    setState(() => _openPerson(index, _people[index].measurements));
  }

  void _addPerson() {
    final taken = _namesExcept(-1);
    var n = _people.length;
    while (taken.contains(MeasurementConstants.personNameAt(n).toLowerCase())) {
      n++;
    }
    setState(() {
      _people = [
        ..._people,
        PersonMeasurementsEntity(name: MeasurementConstants.personNameAt(n)),
      ];
      _openPerson(_people.length - 1, const []);
    });
  }

  void _deletePerson(int index) {
    setState(() => _people = [..._people]..removeAt(index));
  }

  /// Returns from a person's form to the people list, keeping what was
  /// entered.
  void _donePerson() {
    final index = _editingIndex;
    if (index == null) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _people = [..._people]..[index] = _formPerson();
      _editingIndex = null;
    });
  }

  /// Returns from a person's form to the people list, dropping what was
  /// entered.
  Future<void> _backToList() async {
    if (!await _confirmDiscard(formOnly: true) || !mounted) return;
    setState(() => _editingIndex = null);
  }

  void _saveMeasurements({bool moveToNext = false}) {
    final product = selectedProduct;
    if (product == null) return;

    final List<PersonMeasurementsEntity> people;
    if (_isEditingPerson) {
      if (!(formKey.currentState?.validate() ?? false)) return;
      // Nothing entered means no person to store, so the line stays "Add".
      if (_singleMode) {
        people = [_formPerson()].withoutEmptyPeople();
      } else {
        final all = [..._people];
        all[_editingIndex!] = _formPerson();
        people = all.withoutEmptyPeople();
      }
    } else {
      people = _people.withoutEmptyPeople();
    }

    widget.onSaveForProduct(product, people);

    setState(() {
      _peopleBaseline = people.fingerprint;
      if (_isEditingPerson) _formBaseline = [_formPerson()].fingerprint;
      if (!_singleMode) {
        _people = people.isEmpty
            ? [const PersonMeasurementsEntity(name: '')]
            : people;
        _editingIndex = null;
      }
    });

    if (moveToNext) {
      _moveToNextProduct();
    }
  }

  void _moveToNextProduct() {
    if (selectedProductIndex == null) return;

    // Find next product
    final nextIndex = selectedProductIndex! + 1;
    if (nextIndex < widget.selectedProducts.length) {
      setState(() {
        selectedProductIndex = nextIndex;
        selectedProduct = widget.selectedProducts[nextIndex];
        _loadSelectedProduct();
      });
    } else {
      // All products done
      widget.onBack();
    }
  }

  void _addCustomMeasurement() {
    final newKey = customCustomizationController.text
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_');

    final alreadyExists = measurementsNotifier.value.any(
      (e) => e.key == newKey,
    );

    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This measurement already exists'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    measurementsNotifier.value = [
      ...measurementsNotifier.value,
      MeasurementFieldFormState(
        name: customCustomizationController.text.trim().capitalizeFirstLetter(),
        key: newKey,
        description: '',
        gender: GenderType.unisex,
      ),
    ];
    customCustomizationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          // Header with back button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.purpleSoft,
                  ),
                  onPressed: _goBack,
                  tooltip: 'Back to products',
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add Customization',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.charcoal,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        selectedProduct != null
                            ? 'Adding measurements for ${selectedProduct!.variant.name}'
                            : 'Select a product to add measurements',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF636E72),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      onPressed: selectedProduct != null
                          ? () => _saveMeasurements()
                          : null,
                      icon: const Icon(
                        Icons.save,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedProduct != null
                            ? const Color(0xFF27AE60)
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        elevation: 0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: selectedProduct != null
                          ? () => _saveMeasurements(moveToNext: true)
                          : null,
                      icon: const Icon(
                        Icons.skip_next,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Save & Next',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedProduct != null
                            ? AppColors.purpleSoft
                            : Colors.grey,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content - Split layout
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT: Selected products list
                SizedBox(width: 350, child: _buildProductsList()),

                // Divider
                Container(width: 1, color: Colors.grey.shade200),

                // RIGHT: Measurement fields
                Expanded(flex: 3, child: _buildMeasurementSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementSection() {
    final product = selectedProduct;
    if (product != null && !_singleMode && !_isEditingPerson) {
      return PersonMeasurementsPanel(
        people: _people,
        maxPeople: product.quantity,
        onEdit: _editPerson,
        onAdd: _addPerson,
        onDelete: _deletePerson,
      );
    }
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: genderNotifier,
          builder: (context, selectedGender, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customization header - moved from product list
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.purpleSoft.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.design_services,
                        color: AppColors.purpleSoft,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Customization',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Person (only when editing one of several people)
              if (_showsNameField) ...[
                _buildPersonNameCard(),
                const SizedBox(height: 20),
              ],

              // Gender selection
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Measurement for:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: DropdownButton<GenderType>(
                          value: selectedGender,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: GenderType.values
                              .map(
                                (gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(
                                    gender.name.capitalizeFirstLetter(),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: selectedProduct != null
                              ? (value) {
                                  if (value != null) {
                                    genderNotifier.value = value;
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Measurements
              const Text(
                'Measurements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(height: 12),

              ValueListenableBuilder(
                valueListenable: measurementsNotifier,
                builder: (context, measurements, child) {
                  final filteredMeasurements = measurements.where((element) {
                    if (selectedGender == GenderType.unisex) return true;
                    if (element.gender == GenderType.unisex) return true;
                    return element.gender == selectedGender;
                  }).toList();

                  return Column(
                    children: filteredMeasurements
                        .map(
                          (field) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: selectedProduct != null
                                  ? Colors.white
                                  : Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        field.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          color: AppColors.charcoal,
                                        ),
                                      ),
                                      if (field.description.isNotEmpty)
                                        Text(
                                          field.description,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  flex: 3,
                                  child: IgnorePointer(
                                    ignoring: selectedProduct == null,
                                    child: Opacity(
                                      opacity: selectedProduct != null
                                          ? 1.0
                                          : 0.5,
                                      child: CustomTextField(
                                        controller: field.controller,
                                        hintText: 'e.g., 32 inches',
                                        validator: (value) =>
                                            AppInputValidators.basicText(
                                              value,
                                              isRequired: false,
                                              fieldName: field.name,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Add custom measurement
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.offWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Custom Measurement',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: IgnorePointer(
                            ignoring: selectedProduct == null,
                            child: Opacity(
                              opacity: selectedProduct != null ? 1.0 : 0.5,
                              child: CustomTextField(
                                validator: (value) =>
                                    AppInputValidators.basicText(
                                      value,
                                      isRequired: false,
                                    ),
                                controller: customCustomizationController,
                                hintText: 'e.g., Shoulder Width',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: selectedProduct != null
                              ? _addCustomMeasurement
                              : null,
                          icon: const Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Add',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purpleSoft,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonNameCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, color: AppColors.purpleSoft),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Whose measurements?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: _backToList,
                icon: const Icon(Icons.arrow_back, size: 16),
                label: const Text('Back to people'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _donePerson,
                icon: const Icon(Icons.check, size: 16, color: Colors.white),
                label: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.purpleSoft,
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: nameController,
            hintText: 'Person name',
            textCapitalization: TextCapitalization.words,
            validator: _validateName,
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return Container(
      color: AppColors.offWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                const Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                const Spacer(),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Products list
          Expanded(
            child: widget.selectedProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No products selected',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: widget.selectedProducts.length,
                    itemBuilder: (context, index) {
                      final product = widget.selectedProducts[index];
                      final isSelected = selectedProduct == product;

                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: isSelected
                            ? null
                            : () => _selectProduct(product, index),
                        child: MouseRegion(
                          cursor: isSelected
                              ? MouseCursor.defer
                              : SystemMouseCursors.click,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFE8E4FF)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.purpleSoft
                                    : Colors.grey.shade200,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Product image
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child:
                                      (product.variant.thumbnailImage ??
                                                  product
                                                      .variant
                                                      .productImage) !=
                                              null &&
                                          (product.variant.thumbnailImage ??
                                                  product.variant.productImage)!
                                              .isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          child: Image.network(
                                            product.variant.productImage!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Icon(
                                              Icons.image,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.image,
                                          color: Colors.grey.shade400,
                                        ),
                                ),
                                const SizedBox(width: 12),

                                // Product info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.variant.name,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.charcoal,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      // Variant details in chips
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 4,
                                        children: [
                                          if (product
                                                      .variant
                                                      .variantAttribute !=
                                                  null &&
                                              product
                                                  .variant
                                                  .variantAttribute!
                                                  .isNotEmpty)
                                            _buildVariantChip(
                                              product.variant.variantAttribute!,
                                              Icons.label,
                                            ),
                                          if (product.variant.color != null &&
                                              product.variant.color!.isNotEmpty)
                                            _buildVariantChip(
                                              product.variant.color!,
                                              Icons.palette,
                                            ),
                                          if (product.variant.model != null &&
                                              product.variant.model!.isNotEmpty)
                                            _buildVariantChip(
                                              product.variant.model!,
                                              Icons.style,
                                            ),
                                          if (product.variant.category !=
                                                  null &&
                                              product
                                                  .variant
                                                  .category!
                                                  .isNotEmpty)
                                            _buildVariantChip(
                                              product.variant.category!,
                                              Icons.category,
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Status and action
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (product.peopleMeasurements.isNotEmpty)
                                      Container(
                                        margin: const EdgeInsets.only(right: 8),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF27AE60),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.check_circle,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              product
                                                      .peopleMeasurements
                                                      .haveMultiple
                                                  ? '${product.peopleMeasurements.length} people'
                                                  : '${product.peopleMeasurements.allValues.length}',
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _selectProduct(product, index),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isSelected
                                            ? AppColors.purpleSoft
                                            : product
                                                  .peopleMeasurements
                                                  .isNotEmpty
                                            ? AppColors.purpleSoft.withValues(
                                                alpha: 0.7,
                                              )
                                            : const Color(0xFF636E72),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        minimumSize: const Size(50, 32),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        isSelected
                                            ? 'Active'
                                            : product
                                                  .peopleMeasurements
                                                  .isNotEmpty
                                            ? 'Edit'
                                            : 'Add',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Helper method to build variant chips
  Widget _buildVariantChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
