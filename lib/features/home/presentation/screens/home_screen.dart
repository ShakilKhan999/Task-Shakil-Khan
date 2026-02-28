import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';
import '../../controllers/home_controller.dart';
import '../widgets/banner_section.dart';
import '../widgets/product_card.dart';
import '../widgets/product_shimmer.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/sticky_tab_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          _onHorizontalDragEnd(details, controller);
        },
        child: RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: AppColors.white,
          displacement: 60.h,
          edgeOffset: 56.h,
          onRefresh: controller.refreshProducts,
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SearchAppBar(controller: controller),
              BannerSection(controller: controller),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(controller: controller),
              ),
              _buildProductGrid(controller),
              SliverToBoxAdapter(child: SizedBox(height: 300.h)),
            ],
          ),
        ),
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

  Widget _buildProductGrid(HomeController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const ProductShimmer();
      }

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
