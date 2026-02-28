import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  StickyTabBarDelegate({required this.controller});

  @override
  double get minExtent => 44.h;

  @override
  double get maxExtent => 44.h;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            bottom: BorderSide(color: AppColors.divider, width: 1),
          ),
        ),
        child: Obx(() {
          final tabs = ['All', ...controller.categories];

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              children: List.generate(tabs.length, (index) {
                final isActive = controller.currentTabIndex.value == index;
                final tabInfo = _getTabInfo(tabs[index]);

                return GestureDetector(
                  onTap: () => controller.switchTab(index),
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: isActive
                              ? AppColors.primary
                              : Colors.transparent,
                          width: 2.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          tabInfo.icon,
                          size: 14.sp,
                          color: tabInfo.iconColor,
                        ),
                        4.horizontalSpace,
                        Text(
                          tabInfo.label,
                          style: getTextStyle(
                            fontSize: 12.sp,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isActive
                                ? AppColors.activeTab
                                : AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  _TabInfo _getTabInfo(String rawLabel) {
    switch (rawLabel.toLowerCase()) {
      case 'all':
        return _TabInfo(
          'For You',
          Icons.local_fire_department,
          const Color(0xFF4CAF50),
        );
      case 'electronics':
        return _TabInfo(
          'Hot Deals',
          Icons.inventory_2,
          const Color(0xFFE65100),
        );
      case 'jewelery':
        return _TabInfo(
          'Daraz Look',
          Icons.auto_awesome,
          const Color(0xFF4CAF50),
        );
      case "men's clothing":
        return _TabInfo(
          'Free Delivery',
          Icons.local_shipping,
          const Color(0xFF4CAF50),
        );
      case "women's clothing":
        return _TabInfo('Fashion', Icons.checkroom, const Color(0xFF9C27B0));
      default:
        return _TabInfo(rawLabel, Icons.category, const Color(0xFF757575));
    }
  }

  @override
  bool shouldRebuild(covariant StickyTabBarDelegate oldDelegate) => true;
}

class _TabInfo {
  final String label;
  final IconData icon;
  final Color iconColor;

  _TabInfo(this.label, this.icon, this.iconColor);
}
