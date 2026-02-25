import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/models/product_model.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/sizer.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(4.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with badge overlay.
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                // Image.
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      color: AppColors.background,
                      child: Center(
                        child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.background,
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.textHint,
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),

                // Badge overlay.
                Positioned(
                  left: 0,
                  bottom: 4.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBadge('FREE DELIVERY', const Color(0xFF00BFA5)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Product details.
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title.
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),

                  // Price + discount.
                  Row(
                    children: [
                      Text(
                        '৳${product.price.toStringAsFixed(0)}',
                        style: getTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.priceColor,
                        ),
                      ),
                      6.horizontalSpace,
                      Text(
                        '-${_getDiscount()}%',
                        style: getTextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.discountRed,
                        ),
                      ),
                    ],
                  ),
                  4.verticalSpace,

                  // Rating + sold count.
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 12.sp,
                        color: AppColors.ratingYellow,
                      ),
                      2.horizontalSpace,
                      Text(
                        '${product.rating} (${product.ratingCount})',
                        style: getTextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      6.horizontalSpace,
                      Flexible(
                        child: Text(
                          '${product.ratingCount} Sold',
                          overflow: TextOverflow.ellipsis,
                          style: getTextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(4.r),
          bottomRight: Radius.circular(4.r),
        ),
      ),
      child: Text(
        text,
        style: getTextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
    );
  }

  int _getDiscount() {
    // Generate a mock discount based on price.
    return (product.price * 0.3).round().clamp(10, 80);
  }
}
