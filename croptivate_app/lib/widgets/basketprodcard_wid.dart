import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/basketproductcard.dart';
import 'package:flutter/material.dart';

class BasketProdCard extends StatelessWidget {
  final Product product;
  const BasketProdCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), 
          color: cWhite,
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 6),
              blurRadius: 10,
              color: cGrey.withOpacity(0.6),
            )
          ]
          ),
        child: BasketProductCard(
          product: product),
      )
    );
  }
}