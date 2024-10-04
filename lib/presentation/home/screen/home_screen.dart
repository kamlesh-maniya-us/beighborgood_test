import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neighborgood/_core/configs/injection.dart';
import 'package:neighborgood/_core/configs/page_refresh_provider.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../_core/constant/string_constants.dart';
import '../../../application/home/home_bloc.dart';
import '../../../domain/_core/failure.dart';
import '../../_core/constant/assets.dart';
import '../../_core/widgets/custom_toast.dart';
import '../widgets/post_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(GetAllPosts()),
      child: const HomeScreenUI(),
    );
  }
}

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({super.key});

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
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Row(
                children: [
                  SvgPicture.asset(
                    Assets.logoSvg,
                    height: 4.h,
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    Assets.icBellSvg,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      pageRefresh.setRefreshEntity = RefreshEntity([PAGE.home]);
                    },
                    child: SvgPicture.asset(
                      Assets.icLeaderBoardSvg,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Consumer<PageRefresh>(
                  builder: (context, model, child) {
                    if (model.getRefreshEntity.pages.contains(PAGE.home)) {
                      context.read<HomeBloc>().add(GetAllPosts());

                      model.setRefreshEntity = RefreshEntity(
                        [PAGE.none],
                        additionalInfo: {"page": PAGE.home},
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                if (state.isFetchingPosts)
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 12);
                      },
                      itemCount: state.postCollection.length,
                      itemBuilder: (context, index) {
                        final post = state.postCollection[index];
                        return PostCard(post: post);
                      },
                    ),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}
