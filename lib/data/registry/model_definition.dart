import 'package:flutter/material.dart';

import 'model_type.dart';

class ModelDefinition<T> {
  final ModelType type;

  final String title;

  final String api;

  final T Function(Map<String, dynamic>) fromJson;

  final Widget Function(dynamic item) tileBuilder;




  ModelDefinition({
    required this.type,
    required this.title,
    required this.api,
    required this.fromJson,
    required this.tileBuilder,

  });
}

class ModelDetailDefinition<T> {
  final ModelType type;
  final String title;
  // final String? api;
  final String Function(dynamic item)? apiBuilder;
  final T Function(Map<String, dynamic>) fromJson;
  final Widget Function(dynamic item) DetailBuilder;



  ModelDetailDefinition({
    required this.type,
    required this.title,
    // required this.api,
    required this.apiBuilder,
    required this.fromJson,
    required this.DetailBuilder,
  });
}
