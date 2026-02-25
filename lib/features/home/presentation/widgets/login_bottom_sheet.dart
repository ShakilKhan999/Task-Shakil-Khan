import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';

/// Login bottom sheet — lightweight login within the single screen.
class LoginBottomSheet extends StatelessWidget {
  LoginBottomSheet({super.key});

  final TextEditingController usernameController = TextEditingController(
    text: 'johnd',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'm38rmF\$',
  );

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle.
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,

          // Title.
          Text(
            'Welcome Back',
            style: getTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          4.verticalSpace,
          Text(
            'Sign in to continue shopping',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
          24.verticalSpace,

          // Username field.
          _buildTextField(
            controller: usernameController,
            label: 'Username',
            icon: Icons.person_outline,
          ),
          16.verticalSpace,

          // Password field.
          _buildTextField(
            controller: passwordController,
            label: 'Password',
            icon: Icons.lock_outline,
            obscure: true,
          ),
          8.verticalSpace,

          // Test credentials hint.
          Text(
            'Test: johnd / m38rmF\$',
            style: getTextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textHint,
            ),
          ),
          24.verticalSpace,

          // Login button.
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: controller.isLoginLoading.value
                    ? null
                    : () async {
                        final success = await controller.login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (success) {
                          Get.back();
                          Get.snackbar('Success', 'Logged in successfully!');
                        } else {
                          Get.snackbar('Error', 'Invalid credentials.');
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: controller.isLoginLoading.value
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
                        'LOG IN',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ),
          16.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20.sp),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
