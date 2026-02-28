import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';
import 'login_bottom_sheet.dart';
import 'profile_bottom_sheet.dart';

class SearchAppBar extends StatelessWidget {
  final HomeController controller;

  const SearchAppBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: AppColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      toolbarHeight: 56.h,
      title: Row(
        children: [
          Expanded(
            child: Container(
              height: 38.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: const Color(0xFFE91E63), width: 1.5),
              ),
              child: Row(
                children: [
                  12.horizontalSpace,
                  Expanded(
                    child: Text(
                      'Search in Daraz',
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textHint,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 20.sp,
                    color: AppColors.textHint,
                  ),
                  8.horizontalSpace,
                  Container(
                    height: 38.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE91E63),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(2.r),
                        bottomRight: Radius.circular(2.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Search',
                        style: getTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          10.horizontalSpace,
          GestureDetector(
            onTap: () => _onProfileTap(),
            child: Obx(
              () => Icon(
                controller.isLoggedIn.value
                    ? Icons.account_circle
                    : Icons.account_circle_outlined,
                size: 26.sp,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onProfileTap() {
    if (controller.isLoggedIn.value) {
      Get.bottomSheet(const ProfileBottomSheet(), isScrollControlled: true);
    } else {
      Get.bottomSheet(LoginBottomSheet(), isScrollControlled: true);
    }
  }
}
