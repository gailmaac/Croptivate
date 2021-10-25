import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/models/basket_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/buyers/home_buyer.dart';
import 'package:croptivate_app/widgets/basketprodcard_wid.dart';
import 'package:croptivate_app/widgets/basketproductcard.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  _BasketScreenState createState() => _BasketScreenState();

  static const String routeName = '/basket';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => BasketScreen());
  }
}

List<Tab> tabs = [
  Tab(child: Text("Current Orders".toUpperCase())),
  Tab(child: Text("Order History".toUpperCase())),
];

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            backgroundColor: cWhite,
            appBar: AppBar(
                backgroundColor: cWhite,
                elevation: 0,
                title: Text(
                  "My Basket",
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
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: TabBar(
                    labelColor: cGreen,
                    labelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    indicatorColor: cGreen,
                    isScrollable: true,
                    tabs: tabs,
                  ),
                )),
            bottomNavigationBar: Container(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  top: 10,
                ),
                height: 65,
                decoration: BoxDecoration(color: cWhite, boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 10),
                    blurRadius: 35,
                    color: cGrey.withOpacity(0.40),
                  )
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: cGreen),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text("PROCEED TO CHECKOUT",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                        ))
                  ],
                )),
            body: BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: cGreen,
                    ),
                  );
                }
                if (state is BasketLoaded) {
                  return TabBarView(
                    children: [
                      Container(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                                    child: Column(
                                      children: [

                                        SizedBox(
                                          height: 400,
                                          child: ListView.builder(
                                            itemCount: state.basket.products.length,
                                            itemBuilder: (context, index){
                                              return BasketProdCard(product: state.basket.products[index]);
                                            }
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              
                              Column(
                                children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Divider(thickness: 1,),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Subtotal", 
                                            style: TextStyle(
                                              color: cBlack,
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold)),
                                            Text('\₱${Basket().subtotalString}',
                                              style: TextStyle(
                                                color: cBlack,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Shipping Fee", 
                                            style: TextStyle(
                                              color: cBlack,
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold)),
                                            Text('\₱${Basket().shippingFeeString}',
                                              style: TextStyle(
                                                color: cBlack,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 35,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total", 
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 28,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold
                                              )
                                            ),
                                            Text('\₱${Basket().totalString}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold
                                              )
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: double.infinity,
                        color: cDGreen,
                      )
                    ]
                  );
                } else {return Text("Something went wrong");}
              },
            )));
  }
}
