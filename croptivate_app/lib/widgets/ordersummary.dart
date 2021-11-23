import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoaded) {
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
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900)),
                  Text('\₱${state.basket.subtotalString}',
                      style: TextStyle(
                          color: cBlack,
                          fontSize: 24,
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
        else {
          return Text("Something went wrong");
        }
      },
    );
  }
}
