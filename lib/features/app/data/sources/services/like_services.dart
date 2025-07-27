import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<List<dynamic>> getLikedProducts() async {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  try {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance
            .collection('usernames')
            .doc(userId)
            .get();

    // print(doc['likedProducts']);
    return doc['likedProducts'] ?? [];
  } catch (e) {
    print("Error fetching products: $e");
    rethrow; // Re-throw to let the provider handle the error
  }
}

Stream<List<int>> getLikedProductsForFavorites() {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  return FirebaseFirestore.instance
      .collection('usernames')
      .doc(userId)
      .snapshots()
      .map((doc) {
        final data = doc.data();
        final ids = data?['likedProducts'] ?? [];
        return ids
            .map((e) => int.tryParse(e.toString()))
            .whereType<int>()
            .toList();
      });
}
// Future<void> toggleLikeStatus(
//   String productId,
//   List likedBy,
//   bool isLiked,
// ) async {
//   if (isLiked == false) {
//     try {
//       final updatedLikedBy = List.from(likedBy)
//         ..add(FirebaseAuth.instance.currentUser!.uid);
//       await FirebaseFirestore.instance
//           .collection('products')
//           .doc(productId)
//           .update({'likedBy': updatedLikedBy});
//     } catch (e) {
//       print('Error updating like status: $e');
//     }
//   } else {
//     try {
//       final updatedLikedBy = List.from(likedBy)
//         ..remove(FirebaseAuth.instance.currentUser!.uid);
//       await FirebaseFirestore.instance
//           .collection('products')
//           .doc(productId)
//           .update({'likedBy': updatedLikedBy});

//       isLiked = false; // Update local state if needed
//     } catch (e) {
//       print('Error updating like status: $e');
//     }
    
//   }
// }