import 'package:flutter/material.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';

class BannerSection extends StatelessWidget {
  final HomeController controller;

  const BannerSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            color: const Color(0xFF3C3C3C),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _trustBadge(Icons.verified_user_outlined, 'Safe Payment'),
                Container(width: 1, height: 14.h, color: Colors.white38),
                _trustBadge(Icons.local_shipping_outlined, 'Fast Delivery'),
                Container(width: 1, height: 14.h, color: Colors.white38),
                _trustBadge(Icons.replay_outlined, 'Free Return'),
              ],
            ),
          ),
          Container(
            color: AppColors.surface,
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  _categoryIcon(
                    Icons.monetization_on,
                    'Coins\n40% Off',
                    const Color(0xFF4CAF50),
                  ),
                  _categoryIcon(
                    Icons.mosque,
                    'Ramadan\nSale',
                    const Color(0xFF9C27B0),
                  ),
                  _categoryIcon(
                    Icons.local_shipping,
                    'Free\nDelivery',
                    const Color(0xFFE91E63),
                  ),
                  _categoryIcon(
                    Icons.shopping_bag,
                    'Buy\nAny 3',
                    const Color(0xFFFF9800),
                  ),
                  _categoryIcon(
                    Icons.card_giftcard,
                    'Daraz\nFreebie',
                    const Color(0xFF4CAF50),
                  ),
                  _categoryIcon(
                    Icons.star,
                    'Beauty\nSale',
                    const Color(0xFFE91E63),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome: 15% OFF + Free Delivery',
                      style: getTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'More Voucher >',
                      style: getTextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                8.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Up to ৳100',
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.priceColor,
                            ),
                          ),
                          Text(
                            'New User Exclusive',
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 30.h, color: AppColors.divider),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '৳60',
                            style: getTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                          Text(
                            'Selected Sellers',
                            style: getTextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.priceColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: AppColors.priceColor),
                      ),
                      child: Text(
                        'Collect All',
                        style: getTextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.priceColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 80.h,
            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B6B), Color(0xFFF85606)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EXTRA 15% OFF',
                    style: getTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'ON YOUR FIRST ORDER',
                    style: getTextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ),
          8.verticalSpace,
        ],
      ),
    );
  }

  Widget _trustBadge(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.white),
        4.horizontalSpace,
        Text(
          label,
          style: getTextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _categoryIcon(IconData icon, String label, Color color) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 24.sp, color: color),
          ),
          6.verticalSpace,
          Text(
            label,
            textAlign: TextAlign.center,
            style: getTextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
