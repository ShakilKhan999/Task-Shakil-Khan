import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';
import '../widgets/login_bottom_sheet.dart';
import '../widgets/product_card.dart';
import '../widgets/profile_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final double bannerHeight = 400.h;
    controller.setTabBarScrollOffset(bannerHeight);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          _onHorizontalDragEnd(details, controller);
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.white,
            displacement: 60.h,
            edgeOffset: 56.h,
            onRefresh: controller.refreshProducts,
            child: CustomScrollView(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildSliverAppBar(controller),
                _buildBannerSections(),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(controller: controller),
                ),
                _buildProductGrid(controller),
                SliverToBoxAdapter(child: SizedBox(height: 300.h)),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _onHorizontalDragEnd(DragEndDetails details, HomeController controller) {
    const double swipeThreshold = 300;
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < -swipeThreshold) {
      controller.swipeToNextTab();
    } else if (velocity > swipeThreshold) {
      controller.swipeToPreviousTab();
    }
  }

  // ── Search bar (pinned) ─────────────────────────────────────────
  SliverAppBar _buildSliverAppBar(HomeController controller) {
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
            onTap: () => _onProfileTap(controller),
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

  void _onProfileTap(HomeController controller) {
    if (controller.isLoggedIn.value) {
      Get.bottomSheet(const ProfileBottomSheet(), isScrollControlled: true);
    } else {
      Get.bottomSheet(LoginBottomSheet(), isScrollControlled: true);
    }
  }

  // ── Banner sections (scrolls away) ──────────────────────────────
  SliverToBoxAdapter _buildBannerSections() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          // 1. Trust badges bar.
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

          // 2. Category icons row.
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

          // 3. Voucher card.
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

          // 4. Promo banner.
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

  // ── Product grid ────────────────────────────────────────────────
  Widget _buildProductGrid(HomeController controller) {
    return Obx(() {
      if (controller.currentProducts.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              'No products found',
              style: getTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        );
      }

      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.w,
            mainAxisSpacing: 4.h,
            childAspectRatio: 0.58,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return ProductCard(product: controller.currentProducts[index]);
          }, childCount: controller.currentProducts.length),
        ),
      );
    });
  }
}

// ── Sticky tab bar ────────────────────────────────────────────────
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final HomeController controller;

  _StickyTabBarDelegate({required this.controller});

  @override
  double get minExtent => 44;

  @override
  double get maxExtent => 44;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.divider, width: 1)),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
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
                      Icon(tabInfo.icon, size: 14.sp, color: tabInfo.iconColor),
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
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => true;
}

class _TabInfo {
  final String label;
  final IconData icon;
  final Color iconColor;

  _TabInfo(this.label, this.icon, this.iconColor);
}
