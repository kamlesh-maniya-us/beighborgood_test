import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neighborgood/_core/configs/injection.dart';
import 'package:neighborgood/_core/configs/page_refresh_provider.dart';
import 'package:neighborgood/_core/configs/theme_config.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/application/home/home_bloc.dart';
import 'package:neighborgood/presentation/_core/widgets/buttons.dart';
import 'package:neighborgood/presentation/home/widgets/custom_image.dart';
import 'package:neighborgood/presentation/profile/widgets/profile_stats.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../_core/constant/string_constants.dart';
import '../../domain/_core/failure.dart';
import '../_core/constant/assets.dart';
import '../_core/widgets/custom_toast.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(GetMyPosts()),
      child: const ProfileScreenUI(),
    );
  }
}

class ProfileScreenUI extends StatefulWidget {
  const ProfileScreenUI({super.key});

  @override
  State<ProfileScreenUI> createState() => _ProfileScreenUIState();
}

class _ProfileScreenUIState extends State<ProfileScreenUI> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this)
      ..addListener(() {
        context.read<HomeBloc>().add(ChangeTabIndex(index: _controller.index));
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        state.failureOrSuccess.fold(
          () => null,
          (a) => a.fold(
            (l) {
              switch (l) {
                case NetworkError():
                  CustomToast.show(title: StringConstants.noInternetError);
                  break;
                case ServerError():
                  CustomToast.show(title: StringConstants.serverError);
                  break;
              }
            },
            (r) => null,
          ),
        );
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SvgPicture.asset(
                  Assets.logoSvg,
                  height: 4.h,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: SvgPicture.asset(
                    Assets.icHamburgerSvg,
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer<PageRefresh>(
                  builder: (context, model, child) {
                    if (model.getRefreshEntity.pages.contains(PAGE.profile)) {
                      context.read<HomeBloc>().add(GetMyPosts());

                      model.setRefreshEntity = RefreshEntity(
                        [PAGE.none],
                        additionalInfo: {"page": PAGE.profile},
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        GoogleSignIn().signOut();
                        FirebaseAuth.instance.signOut();
                      },
                      child: SizedBox(
                        height: 72,
                        width: 72,
                        child: CustomImage(
                          imageUrl: currentUser.photoURL,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  currentUser.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  StringConstants.interestRunning,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 10,
                        color: Colors.black.withOpacity(0.5),
                      ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ProfileStats(
                          count: state.myPostCollection.length.toString(), subTitle: "Post"),
                      const SizedBox(width: 44),
                      const ProfileStats(
                          count: StringConstants.zero, subTitle: StringConstants.followers),
                      const SizedBox(width: 32),
                      const ProfileStats(
                          count: StringConstants.zero, subTitle: StringConstants.following),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SecondaryButton(
                      title: StringConstants.editProfile,
                      asset: Assets.icProfileSvg,
                      onTap: () {},
                    ),
                    const SizedBox(width: 12),
                    SecondaryButton(
                      title: StringConstants.createPostcard,
                      asset: Assets.icProfileSvg,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  child: TabBar(
                    controller: _controller,
                    indicatorColor: AppTheme.buttonColor,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        icon: SvgPicture.asset(
                          Assets.icGridSvg,
                          colorFilter: ColorFilter.mode(
                              state.selectedTabIndex == 0 ? AppTheme.buttonColor : Colors.black,
                              BlendMode.srcIn),
                        ),
                      ),
                      Tab(
                        icon: SvgPicture.asset(
                          Assets.icSavePostSvg,
                          colorFilter: ColorFilter.mode(
                            state.selectedTabIndex == 1 ? AppTheme.buttonColor : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: TabBarView(
                    controller: _controller,
                    children: const [
                      PostsWidget(),
                      SavedPost(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GridView.builder(
          itemCount: state.myPostCollection.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final img = state.myPostCollection[index].imgUrl;
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.borderColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: img.isEmpty ? StringConstants.staticUserImage : img,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SavedPost extends StatelessWidget {
  const SavedPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
