import 'package:flutter/material.dart';
import 'package:ostudy/presentation/core/utils/app_colors.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class FeaturedClassCard extends StatelessWidget {
  final String image;
  final String category;
  final String title;
  final String duration;
  final String rating;
  final String authorName;
  final String authorRole;
  final String authorAvatar;
  final String price;
  final VoidCallback? onTap;

  const FeaturedClassCard({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.duration,
    required this.rating,
    required this.authorName,
    required this.authorRole,
    required this.authorAvatar,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: NeutralColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: NeutralColors.black50,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  height: 92,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: NeutralColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 14,
                    color: NeutralColors.black100,
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    color: NeutralColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    price,
                    style: TextAuth.paragraphSmallOrange.copyWith(
                      color: AppColors.orange500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            category,
            style: ParagraphBody.xsmallBold.copyWith(
              color: AppColors.orange500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: HeadingBold.heading6.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.access_time, size: 12, color: Colors.grey),
              const SizedBox(width: 3),
              Text(duration, style: ParagraphBody.xsmallRegular),
              const Spacer(),
              const Icon(Icons.star, size: 12, color: Colors.amber),
              const SizedBox(width: 3),
              Text(rating, style: ParagraphBody.xsmallRegular),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(authorAvatar),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authorName,
                      style: ParagraphBody.smallBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      authorRole,
                      style: ParagraphBody.xsmallRegular.copyWith(
                        color: NeutralColors.black400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
