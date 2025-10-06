import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:crmacsinsights/Core/Constants/text_styles.dart';
import 'package:crmacsinsights/Widgets/app_Buttons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:crmacsinsights/Core/Constants/Colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Features/CreatePatient/Controller/createLeadController.dart';
import '../Features/CreatePatient/Model/SymptonsModel.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final bool isPasswordField;

  const AuthField({
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.isPasswordField = false,
    super.key,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.body,
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: widget.isPasswordField ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 16),
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,

        // ✅ Consistent rounded borders for all states
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),

        // ✅ Password toggle
        suffixIcon: widget.isPasswordField
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.primary,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final TextEditingController controller;
  final bool isMultiline;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final bool? enabled;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hintText,
    required this.controller,
    this.isMultiline = false,
    this.suffixIcon,
    this.initialValue,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.enabled,
    this.onChanged,
    this.textInputAction,
    this.focusNode,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
  if (label.isNotEmpty) ...[
    Text(label, style: AppTextStyles.captionBold),
    const SizedBox(height: 8),
  ],
        TextField(
          controller: controller,
          maxLines: isMultiline ? 3 : 1,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: enabled,
          onChanged: onChanged,
          textInputAction: textInputAction,
          focusNode: focusNode,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.all(16),
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            counterText: "",
            fillColor: context.cardColor.color,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownButton2<T> extends StatelessWidget {
  const CustomDropdownButton2({
    super.key,
    this.label,
    this.hintText = '',
    this.prefixIcon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
  });

  final String? label;
  final String hintText;
  final Widget? prefixIcon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;

  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;

  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;

  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;

  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;

  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0, left: 4),
            child: Text(
              label!,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<T>(
            isExpanded: true,
            hint: Row(
              children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Container(
                    alignment: hintAlignment,
                    decoration: BoxDecoration(
                    ),
                    child: Text(
                        hintText,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.SmallCaption
                    ),
                  ),
                ),
              ],
            ),
            value: value,
            items: items,
            onChanged: onChanged,
            selectedItemBuilder: selectedItemBuilder,
            buttonStyleData: ButtonStyleData(
              height: buttonHeight ?? 48,
              width: buttonWidth ?? double.infinity,
              padding: buttonPadding ??
                  const EdgeInsets.symmetric(horizontal: 14),
              decoration: buttonDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                        color: Colors.grey.shade400, width: 1
                    ),
                  ),
              elevation: buttonElevation,
            ),
            iconStyleData: IconStyleData(
              icon: icon ?? const Icon(Icons.arrow_drop_down),
              iconSize: iconSize ?? 24,
              iconEnabledColor: iconEnabledColor,
              iconDisabledColor: iconDisabledColor,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: dropdownHeight ?? 250,
              width: dropdownWidth ?? buttonWidth,
              padding: dropdownPadding,
              decoration: dropdownDecoration ?? BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: dropdownElevation ?? 8,
              offset: Offset(0, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: scrollbarRadius ?? const Radius.circular(40),
                thickness: scrollbarThickness != null
                    ? MaterialStateProperty.all<double>(scrollbarThickness!)
                    : null,
                thumbVisibility: scrollbarAlwaysShow != null
                    ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                    : null,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: itemHeight ?? 44,
              padding: itemPadding ??
                  const EdgeInsets.symmetric(horizontal: 14),
            ),
          ),
        ),
      ],
    );
  }
}


class SymptomsMultiSelectDropdown extends StatelessWidget {
  final TextEditingController searchController;
  final RxList<SymptomItem> symptomsList;
  final RxList<int> selectedSymptomIds;
  final Function(List<int>) updateSelectedSymptoms;
  final Function(int) removeSymptom;
  final BuildContext context;

  const SymptomsMultiSelectDropdown({
    Key? key,
    required this.searchController,
    required this.symptomsList,
    required this.selectedSymptomIds,
    required this.updateSelectedSymptoms,
    required this.removeSymptom,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Symptoms",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _showSymptomsBottomSheet(context);
          },
          child: Obx(() {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.medical_information, color: context.icons.color),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            selectedSymptomIds.isEmpty
                                ? "Select Symptoms"
                                : "${selectedSymptomIds
                                .length} Symptoms selected",

                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: context.icons.color),
                      ],
                    ),
                  ),
                  if (selectedSymptomIds.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, bottom: 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedSymptomIds.map((id) {
                          final symptom = symptomsList.firstWhere((s) =>
                          s.id == id);
                          return Chip(
                            backgroundColor: context.colors.primaryContainer,
                            label: Text(
                              symptom.name,
                              style: TextStyle(fontSize: 12),
                            ),
                            deleteIcon: Icon(Icons.close, size: 18),
                            onDeleted: () => removeSymptom(id),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showSymptomsBottomSheet(BuildContext context) {
    final RxList<SymptomItem> filteredSymptoms = RxList<SymptomItem>.from(symptomsList);
    final RxList<int> tempSelectedIds = RxList<int>.from(selectedSymptomIds);
    final CreatePatientcontroller createPatientController = Get.put(CreatePatientcontroller());


    searchController.clear();

    // Use GetX's bottom sheet instead of standard showModalBottomSheet
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.cardColor.color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "Select Symptoms",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        final TextEditingController newSymptomController = TextEditingController();
                        return AlertDialog(
                          title: Text('Add Symptom'),
                          content: TextField(
                            controller: newSymptomController,
                            decoration: InputDecoration(
                              hintText: 'Enter symptom name',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            PrimaryButton(
                              width: 100.w,
                                height: 50.h,
                                onTap: ()async {
                                final name = newSymptomController.text.trim();
                                if (name.isNotEmpty) {
                                  await createPatientController.createSymptom(name);
                                  await createPatientController.refreshSymtomsList();
                                  filteredSymptoms.value = createPatientController.symptomsList;

                                  final newSymptom = createPatientController.symptomsList.firstWhere(
                                        (s) => s.name.toLowerCase() == name.toLowerCase(),
                                    orElse: () => SymptomItem(id: -1, name: name),
                                  );
                                  if (newSymptom.id != -1 && !tempSelectedIds.contains(newSymptom.id)) {
                                    tempSelectedIds.add(newSymptom.id);
                                  }
                                  Navigator.of(context).pop();
                                  }
                            },
                                text: "Add"),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomTextField(
                label: "",
              hintText: "Search Symptoms",
              controller: searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  filteredSymptoms.value = symptomsList;
                } else {
                  filteredSymptoms.value = symptomsList
                      .where((item) =>
                      item.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                }}),
            SizedBox(height: 16),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await createPatientController.refreshSymtomsList();
                  filteredSymptoms.value = createPatientController.symptomsList;
                },
                child: Obx(() {
                  final currentSymptoms = filteredSymptoms;
                  return ListView.builder(
                    itemCount: currentSymptoms.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final symptom = currentSymptoms[index];
                      // Wrap the ListTile with Obx for reactive updates
                      return Obx(() {
                        final isSelected = tempSelectedIds.contains(symptom.id);
                        return CheckboxListTile(
                          title: Text(symptom.name),
                          value: isSelected,
                          activeColor: context.colors.primary,
                          dense: true,
                          onChanged: (bool? selected) {
                            if (selected == true) {
                              if (!tempSelectedIds.contains(symptom.id)) {
                                tempSelectedIds.add(symptom.id);
                              }
                            } else {
                              tempSelectedIds.remove(symptom.id);
                            }
                            // Force UI update
                            tempSelectedIds.refresh();
                          },
                        );
                      });
                    },
                  );
                }),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton(
                    onPressed: () {
                      updateSelectedSymptoms(tempSelectedIds);
                      Get.back();
                    },

                    child: Text(
                      "Done (${tempSelectedIds.length})",
                      style: AppTextStyles.button
                    ),
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

}