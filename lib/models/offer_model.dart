import 'package:flutter/material.dart';

class OfferModel {
  final String id;
  final String title;
  final String subtitle;
  final String discount;
  final String validUntil;
  final Color color;

  const OfferModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.validUntil,
    required this.color,
  });
}
