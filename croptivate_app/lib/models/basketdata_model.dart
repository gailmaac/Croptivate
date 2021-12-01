import 'package:croptivate_app/models/product_model.dart';
import 'package:equatable/equatable.dart';

class BasketData extends Equatable {
  final List<Product>? products;
  final String? total;

  const BasketData({
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
      'products': products!.map((product) => product.name).toList(),
      'productPrice': products!.map((product) => product.price).toList(),
      'total': total!,
    };
  }

}