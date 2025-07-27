import 'package:clot/features/app/data/models/product_model.dart';
import 'package:clot/features/app/data/sources/services/like_services.dart';
import 'package:clot/features/app/data/sources/services/product_service.dart';
import 'package:clot/features/app/presentation/widgets/product_card.dart';
import 'package:clot/features/shared/components/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<ProductModel>? products;
  Stream<List<ProductModel>> getLikedProductsDetailsStream(
    List<int> ids,
  ) async* {
    final futures = ids.map(getSingleProduct).toList();
    final results = await Future.wait(futures);
    yield results.whereType<ProductModel>().toList();
  }
  // Stream<ProductModel> getLikedProductsDetailsStream(List<int> ids) async* {
  //   for (final id in ids) {
  //     final product = await getSingleProduct(id);
  //     if (product != null) {
  //       yield product; // Emit as soon as it loads
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context: context, title: 'My Favorites'),
      body: StreamBuilder<List<int>>(
        stream: getLikedProductsForFavorites(),
        builder: (context, idSnapshot) {
          if (idSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (idSnapshot.hasError) {
            return Center(child: Text('Error: ${idSnapshot.error}'));
          }
          final ids = idSnapshot.data ?? [];
          if (ids.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet.',
                style: TextStyle(fontSize: 20.sp),
              ),
            );
          }

          return StreamBuilder<List<ProductModel>>(
            stream: getLikedProductsDetailsStream(ids),
            builder: (context, productSnapshot) {
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (productSnapshot.hasError) {
                return Center(child: Text('Error: ${productSnapshot.error}'));
              }

              final products = productSnapshot.data ?? [];

              return Padding(
                padding: EdgeInsets.only(left: 10.w, right: 5.w),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 280.h,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return VerticalProductCard(product: products, index: index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
