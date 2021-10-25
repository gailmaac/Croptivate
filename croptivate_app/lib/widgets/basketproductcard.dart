import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketProductCard extends StatelessWidget {
  final Product product;
  const BasketProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                product.name,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: cBrown,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '\₱${product.price}',
                style: TextStyle(fontSize: 16, color: cBlack),
              ),
            ]),
          ),
          SizedBox(
            width: 5,
          ),
          BlocBuilder<BasketBloc, BasketState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context
                      .read<BasketBloc>()
                      .add(BasketProductRemoved(product));
                    },
                    icon: Icon(
                      Icons.indeterminate_check_box_rounded,
                      color: cGreen,
                    ),
                  ),
                  Text("1",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: cBlack,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: () {
                      context
                      .read<BasketBloc>()
                      .add(BasketProductAdded(product));
                    },
                    icon: Icon(
                      Icons.add_box_rounded,
                      color: cGreen,
                    ),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
