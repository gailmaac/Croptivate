import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BasketData extends Equatable {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<Product>? products;
  final String? total;

  BasketData({
    required this.products,
    required this.total,
  });


  @override
  List<Object?> get props => [
    products, 
    total
  ];

  Map<String, Object> toDocument() {

    return {
      'buyerId': _auth.currentUser!.uid,
      'products': products!.map((product) => product.name).toList(),
      'productPrice': products!.map((product) => product.price).toList(),
      'productOwnerId': products!.map((product) => product.ownerId).toList(),
      'total': total!,
    };
  }

}