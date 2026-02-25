import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';

/// Profile bottom sheet — displays user profile info.
class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final UserModel user = controller.currentUser.value!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle.
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          20.verticalSpace,

          // Avatar.
          CircleAvatar(
            radius: 36.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: Text(
              user.firstName[0].toUpperCase(),
              style: getTextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          12.verticalSpace,

          // Name.
          Text(
            user.fullName,
            style: getTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          4.verticalSpace,

          // Email.
          Text(
            user.email,
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          24.verticalSpace,

          // Info rows.
          _buildInfoRow(Icons.email_outlined, 'Email', user.email),
          _buildInfoRow(Icons.phone_outlined, 'Phone', user.phone),
          _buildInfoRow(
            Icons.location_on_outlined,
            'Address',
            user.fullAddress,
          ),
          _buildInfoRow(Icons.person_outline, 'Username', user.username),
          24.verticalSpace,

          // Logout button.
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () {
                controller.logout();
                Get.back();
                Get.snackbar('Logged Out', 'You have been logged out.');
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'LOG OUT',
                style: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.textSecondary),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getTextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textHint,
                  ),
                ),
                2.verticalSpace,
                Text(
                  value,
                  style: getTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
