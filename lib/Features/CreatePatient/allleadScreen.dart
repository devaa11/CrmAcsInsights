import 'package:crmacsinsights/Widgets/app_Buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:crmacsinsights/Core/Constants/text_styles.dart';
import 'package:crmacsinsights/Core/routes/app_routes.dart';
import 'package:crmacsinsights/Features/CreatePatient/Controller/LeadController.dart';

import '../../Widgets/app_textFields.dart';

Color _getColorFromHex(String? colorString) {
  if (colorString == null || colorString.isEmpty) return Colors.grey;
  return Color(int.parse(colorString));
}

class Allpatientscreen extends StatefulWidget {
  const Allpatientscreen({super.key});

  @override
  State<Allpatientscreen> createState() => _AllpatientscreenState();
}

class _AllpatientscreenState extends State<Allpatientscreen> {
  final PatientController controller = Get.put(PatientController());

  @override
  void initState() {
    super.initState();
    controller.refreshPatients();
  }
  final List<String> months = List.generate(12, (i) => DateFormat('MMMM').format(DateTime(0, i + 1)));
  final List<int> years = List.generate(5, (i) => DateTime.now().year - i);

void _showFilterBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: context.colors.primaryContainer,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter Leads', style: AppTextStyles.heading2.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  )),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              Divider(thickness: 1.5),
              SizedBox(height: 15.h),

              // Date Range Filter
              _buildSectionTitle('Date Range', Icons.date_range),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colors.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        icon: Icon(Icons.calendar_today, size: 16.sp),
                        label: Text(
                          controller.startDate.value ?? 'Start Date',
                          style: AppTextStyles.caption,
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: context.colors.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            controller.startDate.value = DateFormat('yyyy-MM-dd').format(date);
                          }
                        },
                      ),
                    )),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Obx(() => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: context.colors.primary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        icon: Icon(Icons.calendar_today, size: 16.sp),
                        label: Text(
                          controller.endDate.value ?? 'End Date',
                          style: AppTextStyles.caption,
                        ),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: context.colors.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (date != null) {
                            controller.endDate.value = DateFormat('yyyy-MM-dd').format(date);
                          }
                        },
                      ),
                    )),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              _buildSectionTitle('Month & Year', Icons.calendar_view_month),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Obx(() => DropdownButton<int>(
                        isExpanded: true,
                        hint: Text('Select Month'),
                        value: controller.selectedMonth.value,
                        underline: SizedBox(),
                        items: List.generate(months.length, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(months[index]),
                          );
                        }),
                        onChanged: (val) {
                          controller.selectedMonth.value = val;
                        },
                      )),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Obx(() => DropdownButton<int>(
                        isExpanded: true,
                        hint: Text('Select Year'),
                        value: controller.selectedYear.value,
                        underline: SizedBox(),
                        items: years.map((year) {
                          return DropdownMenuItem(
                            value: year,
                            child: Text(year.toString()),
                          );
                        }).toList(),
                        onChanged: (val) {
                          controller.selectedYear.value = val;
                        },
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              _buildSectionTitle('Status', Icons.flag),
              SizedBox(height: 10.h),
              SizedBox(
                height: 40.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.statusList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: Obx(() => FilterChip(
                        label: Text(controller.statusList[index]),
                        selected: controller.selectedStatus.value == controller.statusList[index],
                        selectedColor: context.colors.primary.withOpacity(0.2),
                        checkmarkColor: context.colors.primary,
                        onSelected: (selected) {
                          controller.selectedStatus.value = selected
                              ? controller.statusList[index]
                              : null;
                        },
                      )),
                    );
                  },
                ),
              ),

              SizedBox(height: 30.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: BorderSide(color: context.colors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text('Reset', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        controller.resetFilters();
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  PrimaryButton(
                    width: 120.w,
                    height: 45.h,
                    fontSize: 14.sp,
                    onTap: () {
                      controller.applyFilters();
                      Get.back();
                    },
                    text: "Apply Filter",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18.sp, color: Colors.grey),
        SizedBox(width: 8.w),
        Text(title, style: AppTextStyles.captionBold.copyWith(
          fontSize: 16.sp,
          color: Colors.grey[700],
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Leads", style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 24.sp),
            onPressed: () => Get.toNamed(Routes.createPatient),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller.searchController,
                    hintText: 'Search leads...',
                    label: "",
                    prefixIcon: Icon(Icons.search),
                    onChanged: (val) {
                      controller.filterPatients(val);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: _showFilterBottomSheet,
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.patientsList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return RefreshIndicator(
                onRefresh: controller.refreshPatients,

                child: controller.patientsList.isEmpty
                    ? Center(
                        child: Text(
                          'No Leads found',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      )
                    : ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: controller.patientsList.length,
                        itemBuilder: (context, index) {
                          final patient =
                              controller.patientsList[index];
                          final color = _getColorFromHex(patient.status?.color);
                          final createdAt = DateFormat('dd MM, yyyy')
                              .format(DateTime.parse(patient.createdAt ?? ""));

                          return GestureDetector(
                            onTap: () => Get.toNamed(
                              Routes.patientDetails,
                              arguments: {'id': patient.id},
                            ),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: context.colors.primaryContainer,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 10.w,
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12.r),
                                          bottomLeft: Radius.circular(12.r),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 10.h,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              patient.name ?? 'No Name',
                                              style: AppTextStyles.captionBold,
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 14.sp,
                                                  color: color,
                                                ),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  createdAt,
                                                  style: AppTextStyles.caption
                                                      .copyWith(
                                                    color: color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              patient.phoneNumber ??
                                                  'No Phone No',
                                              style: AppTextStyles.caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        right: 10.w,
                                        top: 15.h,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 4.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Text(
                                        patient.status?.name ?? "",
                                        style: AppTextStyles.smallTextBold
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
