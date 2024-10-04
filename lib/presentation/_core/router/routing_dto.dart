import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoutingDto {
  final String route;
  final Map<String, String> queryParameters;

  RoutingDto({required this.route, required this.queryParameters});

  RoutingDto copyWith({
    String? route,
    Map<String, String>? queryParameters,
  }) {
    return RoutingDto(
      route: route ?? this.route,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'route': route,
      'queryParameters': queryParameters,
    };
  }

  factory RoutingDto.fromMap(Map<String, dynamic> map) {
    return RoutingDto(
      route: map['route'] as String,
      queryParameters: Map<String, String>.from((map['queryParameters'] as Map<String, String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoutingDto.fromJson(String source) => RoutingDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
