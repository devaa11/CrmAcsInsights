import 'package:call_log/call_log.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:crmacsinsights/Core/Constants/colors.dart';
import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:crmacsinsights/Core/Service/Permission_Service.dart';
import 'package:crmacsinsights/Core/Utils/common.dart';
import 'package:crmacsinsights/Core/Utils/validator.dart';
import 'package:crmacsinsights/Features/CreatePatient/Controller/createLeadController.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SymptonsModel.dart';
import 'package:crmacsinsights/Widgets/app_Buttons.dart';
import 'package:crmacsinsights/Widgets/app_textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreatePatientScreen extends StatefulWidget {
  const CreatePatientScreen({Key? key}) : super(key: key);

  @override
  State<CreatePatientScreen> createState() => _CreatePatientScreenState();
}

class _CreatePatientScreenState extends State<CreatePatientScreen> {
  final CreatePatientcontroller createPatientcontroller = Get.put(CreatePatientcontroller());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ✅ Persisted controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController searchController = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    ageController.dispose();
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Lead"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.h,
              children: [
                CustomTextField(
                  label: "Name",
                  controller: nameController,
                  hintText: "Enter Lead Name",
                  validator: Validators.validateName,
                ),
                Obx(() => createPatientcontroller.nameError.value.isNotEmpty
                    ? Padding(
                  padding:  EdgeInsets.only(left: 8.0.w, top: 4.0.h),
                  child: Text(
                    createPatientcontroller.nameError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),

                CustomTextField(
                  label: "Phone No",
                  controller: phoneController,
                  hintText: "Enter lead Phone No",
                  keyboardType: TextInputType.phone,
                  suffixIcon: Theme.of(context).platform == TargetPlatform.android
                      ? IconButton(
                    icon: Icon(Icons.call, color: context.icons.color),
                    onPressed: () async {
                      await showCallLogDialog(context);
                    },
                  )
                      : null,
                ),
                Obx(() => createPatientcontroller.phoneError.value.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    createPatientcontroller.phoneError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),
                CustomTextField(
                  label: "Age",
                  controller: ageController,
                  hintText: "Enter lead Age",
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Age is required';
                    if (int.tryParse(val) == null) return 'Enter a valid age';
                    return null;
                  },
                ),
                Obx(() => createPatientcontroller.ageError.value.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    createPatientcontroller.ageError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),
                CustomTextField(
                  label: "Address",
                  controller: locationController,
                  hintText: "Enter lead Address",
                  isMultiline: true,
                  validator: (val) => val == null || val.isEmpty ? 'Address is required' : null,
                ),
                Obx(() => createPatientcontroller.addressError.value.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    createPatientcontroller.addressError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),

                Obx(() => CustomDropdownButton2<int>(
                  label: "Select Source",
                  hintText: "Choose one",
                  dropdownHeight: 150,
                  offset: Offset(50, 100),
                  value: createPatientcontroller.selectedSourceId.value == 0
                      ? null
                      : createPatientcontroller.selectedSourceId.value,
                  items: createPatientcontroller.sourcesWithIds
                      .map((source) => DropdownMenuItem<int>(
                      value: source.id, child: Text(source.name)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      createPatientcontroller.updateSelectedSourceId(val);
                    }
                  },
                  prefixIcon: Icon(Icons.campaign, color: context.icons.color),
                )),
                Obx(() => createPatientcontroller.sourceError.value.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    createPatientcontroller.sourceError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),

                SymptomsMultiSelectDropdown(
                  searchController: searchController,
                  symptomsList: createPatientcontroller.symptomsList,
                  selectedSymptomIds: createPatientcontroller.selectedSymptomIds,
                  updateSelectedSymptoms: (ids) {
                    createPatientcontroller.updateSelectedSymptoms(ids);

                  },
                  removeSymptom: (id) {
                    createPatientcontroller.removeSymptomById(id);
                  },
                  context: context,
                ),
                Obx(() => createPatientcontroller.symptomsError.value.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                  child: Text(
                    createPatientcontroller.symptomsError.value,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                )
                    : SizedBox.shrink()),

                SizedBox(height: 20),
// In CreatePatientScreen
                PrimaryButton(
                  onTap: () async {
                    final bool isValid = createPatientcontroller.validateFields(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      age: ageController.text.trim(),
                      address: locationController.text.trim(),
                    );

                    if (!isValid) return;

                    await createPatientcontroller.createNewPatient(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim(),
                      age: ageController.text.trim(),
                      address: locationController.text.trim(),
                      source: createPatientcontroller.selectedSourceId.value,
                      symptoms: createPatientcontroller.selectedSymptomIds.value,
                    );

                    if (createPatientcontroller.responseModel.value?.message != null) {
                      showAppSnackBar(context, createPatientcontroller.apiMessage.value);

                      // Reset form
                      _formKey.currentState!.reset();
                      nameController.clear();
                      phoneController.clear();
                      ageController.clear();
                      locationController.clear();
                      createPatientcontroller.resetForm();
                    }
                  },
                  text: "Create",
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<List<CallLogEntry>> getCallLogs() async {
    Iterable<CallLogEntry> entries = await CallLog.get();
    return entries.toList();
  }
Future<void> showCallLogDialog(BuildContext context) async {
  await PermissionService.requestCallLogPermission();
  List<CallLogEntry> logs = await getCallLogs();
  String _formatDuration(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    if (min > 0) {
      return '$min min ${sec.toString().padLeft(2, '0')} sec';
    } else {
      return '$sec sec';
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Tap to select contact',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                var entry = logs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: entry.callType == CallType.missed
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.green.withValues(alpha: 0.1),
                      child: Icon(
                        entry.callType == CallType.incoming
                            ? Icons.call_received
                            : entry.callType == CallType.outgoing
                            ? Icons.call_made
                            : entry.callType == CallType.missed
                            ? Icons.call_missed
                            : Icons.phone,
                        color: entry.callType == CallType.missed
                            ? Colors.red
                            : entry.callType == CallType.outgoing
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            (entry.name == null || entry.name!.trim().isEmpty)
                                ? 'Unknown Contact'
                                : entry.name!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (entry.timestamp != null)
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
                              .toLocal()
                              .toString()
                              .split(' ')[0]
                              .split('-')
                              .reversed
                              .join('/'),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          entry.number ?? '',
                          style: TextStyle(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppColors.primaryDark
                                : AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            if (entry.duration != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${entry.duration != null ? _formatDuration(entry.duration!) : ''}',
                                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                ),
                              ),
                            SizedBox(width: 8),
                            if (entry.simDisplayName != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  entry.simDisplayName!,
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? AppColors.primaryDark
                                        : AppColors.primary,
                                  ),                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      final cleaned = (entry.number ?? '').replaceAll(RegExp(r'\D'), '');
                      phoneController.text = cleaned.length >= 10
                          ? cleaned.substring(cleaned.length - 10)
                          : cleaned;


                      Navigator.pop(context);
                    },
                  ),
                );
              },
            ),
          ),
        ],

      ),
    ),
  );
}}