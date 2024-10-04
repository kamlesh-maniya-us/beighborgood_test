import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighborgood/presentation/home/widgets/custom_image.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

import '../../../_core/configs/theme_config.dart';
import '../../../_core/constant/app_constant.dart';
import '../../../_core/constant/string_constants.dart';
import '../../../infrastructure/add_post/dtos/post.dart';
import '../../_core/constant/assets.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.feedBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 10,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 36,
                  width: 36,
                  child: CustomImage(
                    imageUrl: post.user.photoURL,
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                    ),
                    Text(
                      StringConstants.walking,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 10,
                          ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            post.title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
          ),
          ReadMoreText(
            post.description,
            trimMode: TrimMode.Line,
            trimLines: 2,
            colorClickableText: AppTheme.seeMoreTextColor,
            trimCollapsedText: 'See More',
            trimExpandedText: 'See Less',
            annotations: [
              Annotation(
                regExp: RegExp(r'#([a-zA-Z0-9_]+)'),
                spanBuilder: ({required String text, TextStyle? textStyle}) => TextSpan(
                  text: text,
                  style: textStyle?.copyWith(
                    color: AppTheme.hashTextColor,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.hashTextColor,
                  ),
                ),
              ),
            ],
            style: Theme.of(context).textTheme.titleSmall,
            moreStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppTheme.seeMoreTextColor,
                ),
            lessStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                  decoration: TextDecoration.underline,
                  color: AppTheme.seeMoreTextColor,
                ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                imageUrl: post.imgUrl,
                height: 195,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              SvgPicture.asset(
                Assets.icLikeSvg,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                Assets.icCommentSvg,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                Assets.icShareSvg,
                height: 24,
                width: 24,
              ),
              const Spacer(),
              SvgPicture.asset(
                Assets.icSavePostSvg,
                height: 24,
                width: 24,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(left: 10),
                  child: CustomImage(
                    imageUrl: currentUser.photoURL,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: StringConstants.addAComment,
                      isDense: true,
                      hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black.withOpacity(0.3),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
