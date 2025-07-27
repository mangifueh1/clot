import 'package:clot/features/app/data/sources/services/like_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikeButton extends StatefulWidget {
  LikeButton({
    super.key,
    required this.isFavorite,
    this.color,
    required this.productId,
  });

  final Color? color;
  final int productId;
  bool isFavorite;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  List? products;
  bool? isLiked;

  void getData() async {
    products = await getLikedProducts();

    isLiked = products!.contains(widget.productId);

    if (isLiked!) {
      widget.isFavorite = true;
    } else {
      widget.isFavorite = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: likeToggle,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: widget.color ?? Colors.white.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        child:
            widget.isFavorite
                ? Image.asset('assets/images/favorites_filled.png')
                : Image.asset('assets/images/favorites.png'),
      ),
    );
  }

  void likeToggle() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (!isLiked!) {
      try {
        final likedProducts = List.from(products!)..add(widget.productId);
        setState(() {
          widget.isFavorite = true;
          // widget.isFavorite = !widget.isFavorite;
          FirebaseFirestore.instance.collection('usernames').doc(userId).update(
            {'likedProducts': likedProducts},
          );
        });
      } catch (e) {
        print('Error: $e');
        rethrow;
      }
    } else {
      try {
        final likedProducts = List.from(products!)..remove(widget.productId);

        setState(() {
          widget.isFavorite = false;
          // widget.isFavorite = !widget.isFavorite;
          FirebaseFirestore.instance.collection('usernames').doc(userId).update(
            {'likedProducts': likedProducts},
          );
        });
      } catch (e) {
        print('Error: $e');
        rethrow;
      }
    }
  }
}
