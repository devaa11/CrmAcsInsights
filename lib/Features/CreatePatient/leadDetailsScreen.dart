import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:crmacsinsights/Core/Constants/text_styles.dart';
import 'package:crmacsinsights/Core/Utils/common.dart';
import 'package:crmacsinsights/Features/CreatePatient/Controller/LeadController.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/SingleLeadResponseModel.dart';
import 'package:crmacsinsights/Features/CreatePatient/Model/leadsResponseModel.dart';
import 'package:crmacsinsights/Features/Profile/Controller/ProfileController.dart';
import 'package:crmacsinsights/Widgets/app_Buttons.dart';
import 'package:crmacsinsights/Widgets/app_textFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Components/ExpandableCard.dart';
import 'Components/LogComponent.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final PatientController patientController = Get.put(PatientController());
  final TextEditingController noteController = TextEditingController();
  ProfileController profileController = Get.find<ProfileController>();
  late int leadId;

  @override
  void initState() {
    super.initState();
    leadId = Get.arguments['id'];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPatientData();
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> fetchPatientData() async {
    await patientController.getSinglePatient(leadId);
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "N/A";
    try {
      return DateFormat('dd-MM-yyyy • hh:mm a').format(DateTime.parse(date));
    } catch (e) {
      return "Invalid Date";
    }
  }

  void _handleUpdatePatient() async {
    if (noteController.text.isEmpty) {
      showAppSnackBar(context, "Please enter the Note");
      return;
    }

    await patientController.updatePatient(
      id: leadId,
      status: patientController.selectedStatusId.value,
      note: noteController.text.trim(),
    );
    await fetchPatientData();
    await profileController.getPieChartData();
    Get.back();
  }

  void _showUpdateDialog() {
    noteController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update Status'),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusDropdown(),
                SizedBox(height: 16.h),
                CustomTextField(
                  label: "Note",
                  controller: noteController,
                  hintText: "Enter Note",
                  isMultiline: true,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          PrimaryButton(
              width: 100.w,
              height: 40.h, // Reduced height
              onTap: _handleUpdatePatient,
              text: "Update")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lead No: $leadId')),
      body: Obx(() {
        if (patientController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final patient = patientController.leadDetails.value.lead;
        if (patient == null) {
          return Center(child: Text('Lead data not found'));
        }

        final statusColor =
            patient.status?.color != null && patient.status!.color!.isNotEmpty
                ? Color(int.parse(patient.status!.color!))
                : Colors.grey;
        final createdAt = formatDate(patient.createdAt);

        return RefreshIndicator(
          onRefresh: () async {
            await fetchPatientData();
            setState(() {}); // Force rebuild after refresh
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        _buildPatientHeader(
                          patient.name ?? "Unknown",
                          patient.id ?? 0,
                          statusColor,
                          patient.status?.name ?? "No Status",
                        ),
                        SizedBox(height: 10.h),
                        PrimaryButton(
                            onTap: () {
                              _showUpdateDialog();
                            },
                            text: "Update Status"),
                        SizedBox(
                          height: 10.h,
                        ),
                        buildCardSection(
                          title: 'Patient Details',
                          expandable: true,
                          initiallyExpanded: true,
                          children: [
                            _buildInfoRow(Icons.person, 'Name',
                                patient.name ?? "Not provided"),
                            GestureDetector(
                              onTap: () async {
                                final phone = patient.phoneNumber;
                                if (phone != null && phone.isNotEmpty) {
                                  final uri = Uri.parse('tel:$phone');
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                }
                              },
                              child: _buildInfoRow(Icons.phone, 'Phone', patient.phoneNumber ?? "Not provided"),
                            ),
                            _buildInfoRow(Icons.location_on, 'Location',
                                patient.location ?? "Not provided"),
                            _buildInfoRow(
                                Icons.calendar_today,
                                'Age',
                                patient.age != null
                                    ? '${patient.age} years'
                                    : "Not provided"),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        buildCardSection(
                          expandable: true,
                          title: 'Lead Details',
                          children: [
                            _buildInfoRow(Icons.campaign, 'Source',
                                patient.source?.name ?? "Not provided"),
                            _buildInfoRow(
                                Icons.access_time, 'Created', createdAt),
                            _buildInfoRow(Icons.medical_services, 'Procedure',
                                patient.procedure ?? "Not provided"),
                            _buildSymptomsInfoRow(Icons.local_hospital,
                                "Status", patient.symptoms),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        buildCardSection(
                          title: 'Logs',
                          expandable: true,
                          children: [
                            SizedBox(
                              height: 200.h, // Set your desired fixed height
                              child: patientController
                                              .leadDetails.value.lead?.logs !=
                                          null &&
                                      patientController.leadDetails.value.lead!
                                          .logs!.isNotEmpty
                                  ? Scrollbar(
                                      child: ListView.builder(
                                        itemCount: patientController.leadDetails
                                            .value.lead!.logs!.length,
                                        itemBuilder: (context, index) {
                                          final log = patientController
                                              .leadDetails
                                              .value
                                              .lead!
                                              .logs![index];
                                          return buildLogItem(context, log);
                                        },
                                      ),
                                    )
                                  : Center(child: Text('No logs available')),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildStatusDropdown() {
    return Obx(() {
      if (patientController.statusWithIds.isEmpty) {
        return Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Loading statuses...")
            ],
          ),
        );
      }

      return CustomDropdownButton2<String>(
        label: "Select Status",
        hintText: "Choose one",
        dropdownHeight: 150.h,
        offset: Offset(0, 0),
        value: patientController.selectedStatusId.value.isEmpty ||
            !patientController.statusWithIds.any((status) => status.id == patientController.selectedStatusId.value)
            ? null
            : patientController.selectedStatusId.value,
        items: patientController.statusWithIds
            .map((status) => DropdownMenuItem<String>(
                  value: status.id,
                  child: Text(status.label ?? ""),
                ))
            .toList(),
        onChanged: (val) {
          if (val != null) {
            patientController.updateSelectedStatusId(val);
          }
        },
      );
    });
  }

  Widget _buildPatientHeader(
      String name, int id, Color statusColor, String statusName) {
    final createdAt = patientController.leadDetails.value.lead!.createdAt;
    final updatedAt = patientController.leadDetails.value.lead!.updatedAt;
    final displayDate =
        (createdAt != null && updatedAt != null && createdAt != updatedAt)
            ? formatDate(updatedAt)
            : formatDate(createdAt);
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: Colors.blue.shade100,
                child: Text(name.isNotEmpty ? name[0].toUpperCase() : "?",
                    style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800)),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    Text(
                        (createdAt != null &&
                                updatedAt != null &&
                                createdAt != updatedAt)
                            ? 'Updated At: $displayDate'
                            : 'Created At: $displayDate',
                        style: TextStyle(
                            fontSize: 12.sp, color: Colors.grey[600])),
                    SizedBox(height: 4.h),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                              height: 10.h,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  color: statusColor, shape: BoxShape.circle)),
                          SizedBox(width: 6.w),
                          Text(statusName,
                              style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp)),
                        ],
                      ),
                    ),

                    // Text('Lead ID: $id',
                    //     style: TextStyle(
                    //         fontSize: 14.sp, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(
            color: Colors.grey[500],
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomsInfoRow(
      IconData icon, String label, List<SingleLeadSymtoms>? symptoms) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[600]),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                SizedBox(height: 4.h),
                symptoms == null || symptoms.isEmpty
                    ? Text("No symptoms recorded",
                        style: TextStyle(fontSize: 14.sp))
                    : Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: symptoms.map((symptom) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: Colors.blue.shade100),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_hospital,
                                    size: 16.sp, color: Colors.blue.shade700),
                                SizedBox(width: 6.w),
                                Text(
                                  symptom.name ?? "Unknown",
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.blue.shade700),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData? icon, String? label, String? value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Colors.grey[600]),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label ?? "",
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                Text(value ?? "", style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
