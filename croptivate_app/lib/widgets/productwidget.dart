import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:flutter/cupertino.dart';

class ProductWidget extends StatelessWidget {
  final List<Product> products;
  const ProductWidget({
    Key? key,
    required this.products,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding:
            const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: ProductCard(
              product: products[index],
            ),
          );
        });
  }
}
