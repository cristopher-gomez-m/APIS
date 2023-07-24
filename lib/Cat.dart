import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cat {
  final String id;
  final String url;
  final int width;
  final int height;

    Cat({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
  });
}
