import 'package:flutter/material.dart';
import 'package:neighborgood/_core/configs/bottom_nav_bar_provider.dart';
import 'package:neighborgood/_core/configs/page_refresh_provider.dart';
import 'package:neighborgood/_core/constant/app_constant.dart';
import 'package:neighborgood/presentation/_core/router/route_names.dart';
import 'package:neighborgood/presentation/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'widgets/internal_navigator.dart';

class MainHome extends StatefulWidget {
  const MainHome({super.key});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    pageRefresh = Provider.of<PageRefresh>(context, listen: false);

    _pages = [
      const InternalNavigator(
        index: 0,
      ),
      const InternalNavigator(
        index: 1,
      ),
      const InternalNavigator(
        index: 2,
      ),
      const InternalNavigator(
        index: 3,
      ),
      const InternalNavigator(
        index: 4,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context);
      },
      child: Consumer<BottomNavigationBarProvider>(
        builder: (context, bottomBarProvider, child) {
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: CustomBottomNavigationBar(
              currentSelected: bottomBarProvider.currentIndex,
              onChange: (value) async {
                bottomBarProvider.currentIndex = value;

                if (value == 2) {
                  final result = await mainNavigator.navigateTo(AllRoutes.addPostRoute);

                  if (result ?? false) {
                    pageRefresh.setRefreshEntity = RefreshEntity([PAGE.home, PAGE.profile]);
                  }
                }
              },
            ),
            body: IndexedStack(
              index: bottomBarProvider.currentIndex,
              children: _pages,
            ),
          );
        },
      ),
    );
  }
}
