

import 'package:flutter/material.dart';

class PageRefresh extends ChangeNotifier {
  RefreshEntity _refreshEntity = RefreshEntity([PAGE.none]);

  void reset() {
    _refreshEntity = RefreshEntity([PAGE.none]);

    Future.delayed(Duration.zero, () async {
      notifyListeners();
    });
  }

  RefreshEntity get getRefreshEntity => _refreshEntity;

  set setRefreshEntity(RefreshEntity page) {
    if (page.pages.contains(PAGE.none)) {
      if (page.additionalInfo['page'] != null) {
        final removingPage = page.additionalInfo['page'] as PAGE;
        _refreshEntity = _refreshEntity..pages.remove(removingPage);
      } else if (_refreshEntity.pages.length == 1) {
        _refreshEntity = page;
        Future.delayed(Duration.zero, () async {
          notifyListeners();
        });
      }
    } else {
      _refreshEntity = page;
      Future.delayed(Duration.zero, () async {
        notifyListeners();
      });
    }
  }
}

class RefreshEntity {
  final List<PAGE> pages;
  final Map<String, dynamic> additionalInfo;

  RefreshEntity(
    this.pages, {
    this.additionalInfo = const {},
  });
}

enum PAGE{
  home,
  profile,
  none,
}