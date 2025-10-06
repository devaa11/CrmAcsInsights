
import 'package:crmacsinsights/Core/Constants/context_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../Model/SingleLeadResponseModel.dart';

Widget buildLogItem(BuildContext context,Logs log) {
  final DateTime logTime = DateTime.parse(log.createdAt ?? "");
  final String formattedTime = DateFormat('dd MMM yyyy, hh:mm a').format(logTime);
  final bool isUpdateEvent = log.event == 'updated';

  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4.w,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timestamp and user
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    children: [
                      TextSpan(text: '$formattedTime – '),
                      TextSpan(
                        text: isUpdateEvent ? 'Changed by ' : 'Created by ',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: log.causer ?? 'Unknown',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),

                // Status change
                if (isUpdateEvent && log.properties?.old?.status != null)
                  RichText(
                    text: TextSpan(
                      style: context.texts.bodySmall,
                      children: [
                        const TextSpan(text: 'Status changed from '),
                        TextSpan(
                          text: _formatStatus(log.properties?.old?.status ?? ''),
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: ' to '),
                        TextSpan(
                          text: _formatStatus(log.properties?.attributes?.status ?? ''),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (log.properties?.attributes?.status != null)
                  RichText(
                    text: TextSpan(
                      style: context.texts.bodySmall,
                      children: [
                        const TextSpan(text: 'Status changed to '),
                        TextSpan(
                          text: _formatStatus(log.properties?.attributes?.status ?? ''),
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Note
                if (log.properties?.attributes?.note != null)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: RichText(
                      text: TextSpan(
                        style: context.texts.labelLarge,
                        children: [
                          const TextSpan(
                            text: 'Note: ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextSpan(text: log.properties?.attributes?.note ?? ''),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

String _formatStatus(String status) {
  return status.split('_')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
