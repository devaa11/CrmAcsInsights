// import 'package:drdictims/Features/CreatePatient/Controller/createLeadController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:multi_dropdown/multi_dropdown.dart';
//
// class SymptomSelector extends StatelessWidget {
//   final CreatePatientcontroller controller = Get.find();
//   final MultiSelectController _multiSelectController = MultiSelectController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text("Select Symptoms", style: Theme.of(context).textTheme.titleMedium),
//           const SizedBox(height: 8),
//           MultiSelectDropdown(
//             controller: _multiSelectController,
//             options: controller.symptomsList,
//             onOptionSelected: (List<String> selected) {
//               controller.updateSelectedSymptoms(selected);
//             },
//             selectedOptions: controller.selectedSymptoms,
//             selectionType: SelectionType.multi,
//             chipConfig: const ChipConfig(wrapType: WrapType.wrap),
//             dropdownHeight: 300,
//             searchEnabled: true,
//             hint: 'Choose symptoms',
//           ),
//         ],
//       );
//     });
//   }
// }
