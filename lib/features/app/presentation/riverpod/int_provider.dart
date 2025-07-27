import 'package:flutter_riverpod/flutter_riverpod.dart';

var productPriceProvider = StateProvider<int>((ref) => 200);
var productQuantityProvider = StateProvider<int>((ref) => 1);
var productTotalProvider = StateProvider<int>((ref) => ref.watch(productPriceProvider) * ref.watch(productQuantityProvider));
