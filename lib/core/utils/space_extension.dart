import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension NumExtension on num {
  SizedBox get customW => SizedBox(width: toDouble().w);
  SizedBox get customH => SizedBox(height: toDouble().h);
}
