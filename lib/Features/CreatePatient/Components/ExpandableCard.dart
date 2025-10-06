
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/Constants/text_styles.dart';

Widget buildCardSection({
  required String title,
  required List<Widget> children,
  double? height,
  bool expandable = false,
  bool? initiallyExpanded,
}) {
  if (!expandable) {
    return SizedBox(
      width: double.infinity,
      height: 10.h,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.captionBold),
              SizedBox(height: 16.h),
              ...children,
            ],
          ),
        ),
      ),
    );
  } else {
    return ExpandableCard(
      title: title,
      children: children,
      initiallyExpanded: initiallyExpanded ?? false,

    );
  }
}

class ExpandableCard extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const ExpandableCard({
    required this.title,
    required this.children,
    this.initiallyExpanded = false,

    super.key,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> with SingleTickerProviderStateMixin {
  late bool isExpanded;
  @override
  void initState() {
    super.initState();
    isExpanded = widget.initiallyExpanded;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: AppTextStyles.captionBold),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.children,
                ],
              ),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
            firstCurve: Curves.easeInOut,
            secondCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}