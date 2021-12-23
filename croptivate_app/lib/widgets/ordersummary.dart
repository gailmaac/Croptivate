import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/models/basket_model.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatefulWidget {
  final selectedproducts;
  final selectedproductvalues;
  const OrderSummary(
      {Key? key, this.selectedproducts, this.selectedproductvalues})
      : super(key: key);

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  double subtotal = 0;
  double total = 0;

  computetotal() {
    List<Product> selectedproducts = widget.selectedproducts;
    List<int> selectedvalues = widget.selectedproductvalues;
    double _subtotal = 0;
    for (int x = 0; x < selectedproducts.length; x++) {
      _subtotal += selectedproducts[x].price * selectedvalues[x];
    }
    setState(() {
      subtotal = _subtotal;
    });
  }

  @override
  Widget build(BuildContext context) {
    computetotal();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total".toUpperCase(),
                  style: TextStyle(
                      color: cBlack,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900)),
              SizedBox(width: 50),
              Text('\₱ ' + subtotal.toStringAsFixed(2),
                  style: TextStyle(
                      color: cBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Text("Shipping Fee".toUpperCase(),
              //     style: TextStyle(
              //         color: cBlack,
              //         fontSize: 18,
              //         fontFamily: 'Poppins',
              //         fontWeight: FontWeight.bold)),
              // Text('\₱${state.basket.shippingFeeString}',
              //     style: TextStyle(
              //         color: cBlack,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("Total".toUpperCase(),
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 24,
          //             fontFamily: 'Poppins',
          //             fontWeight: FontWeight.w900)),
          //     Text('\₱${state.basket.totalString}',
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 24,
          //             fontWeight: FontWeight.bold)),
          //   ],
          // )
        ],
      ),
    );
  }
}
