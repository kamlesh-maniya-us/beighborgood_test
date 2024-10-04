import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:neighborgood/presentation/_core/router/routing_dto.dart';

extension StringExtension on String {
  RoutingDto get getRoutingData {
    final uriData = Uri.parse(this);
    return RoutingDto(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}

extension WidgetExtension on Widget {
  Widget addDottedBorder({
    bool showBorder = true,
    double radius = 12.0,
    // Color dotColor = Colors.black.withOpacity(0.25),
    double dashPattern = 5,
  }) {
    return DottedBorder(
      strokeCap: showBorder ? StrokeCap.butt : StrokeCap.square,
      borderType: BorderType.RRect,
      color: Colors.black.withOpacity(0.25),
      padding: EdgeInsets.zero,
      radius: Radius.circular(radius),
      dashPattern: [if (showBorder) dashPattern else 1.0],
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: this,
      ),
    );
  }
}
