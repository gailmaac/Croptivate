import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();

  static const String routeName = '/myorders';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => MyOrders());
  }
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 0,
        title: Text(
          "My Orders",
          style: TextStyle(
              color: cGreen,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: cBlack,
            size: 15,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Container(
            height: 165,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: cWhite,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(3, 6),
                    blurRadius: 10,
                    color: cGrey.withOpacity(0.6),
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.network(
                    "https://images.unsplash.com/photo-1508313880080-c4bef0730395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Reference ID",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: cBrown,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "sampleLBzkB6f0wVdPOVgw",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: cBlack),
                        ),
                        BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            if (state is BasketLoading) {
                              return Center(
                                child: CircularProgressIndicator(color: cGreen));
                            }
                            if(state is BasketLoaded){
                              return Text(
                              "Total: ${state.basket.subtotalString}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: cBlack),
                            );
                            }
                            else{
                              return Text("Sorry");
                            }
                          },
                        ),
                        SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                              "To Ship",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: cGreen
                              )
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: cGreen),
                                onPressed: (){}, 
                                child: Text(
                                  "Order Received",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                  ),
                                )
                            ),
                          ] 
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
