import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/models/basket_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/checkoutscreen.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/buyers/home_buyer.dart';
import 'package:croptivate_app/widgets/basketprodcard_wid.dart';
import 'package:croptivate_app/widgets/basketproductcard.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/ordersummary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasketScreen extends StatefulWidget {
  final allUserSellers;
  final allUserSellersid;
  const BasketScreen(
      {Key? key, required this.allUserSellers, required this.allUserSellersid})
      : super(key: key);
      

  @override
  _BasketScreenState createState() => _BasketScreenState();
  
}

final FirebaseAuth _auth = FirebaseAuth.instance;

List shoplist = [];
List<Product> allproducts = [];
List<int> allproductvalues = [];
List<Product> selectedproducts = [];
List<int> selectedproductvalues = [];
List shopname = [];
List userSellers = [];
List userSellersid = [];
int selectedtile = 0;
List<Product> passproducts = [];
List<int> passvalues = [];
String passshopname = '';

class _BasketScreenState extends State<BasketScreen> {
  @override
  void initState() {
    super.initState();
    userSellers = widget.allUserSellers;
    userSellersid = widget.allUserSellersid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
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
                  onPressed: () async {
                    for (int x = 0; x < userSellersid.length; x++) {
                      if (userSellersid[x] == shoplist[selectedtile]) {
                        passshopname = userSellers[x]['shop name'];
                      }
                    }
                    passproducts = [];
                    passvalues = [];
                    for (int x = 0; x < allproducts.length; x++) {
                      if (allproducts[x].ownerId == shoplist[selectedtile]) {
                        passproducts.add(allproducts[x]);
                        passvalues.add(allproductvalues[x]);
                      }
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen(
                                  selectedproducts: passproducts,
                                  selectedvalues: passvalues,
                                  shopname: passshopname,
                                )));
                  },
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
      body: Container(
        height: double.infinity,
        // child: SingleChildScrollView(
        child: BlocBuilder<BasketBloc, BasketState>(
          builder: (context, state) {
            shopname = [];
            shoplist = [];
            allproducts = [];
            allproductvalues = [];
            selectedproducts = [];
            selectedproductvalues = [];
            if (state is BasketLoading) {
              return Center(child: CircularProgressIndicator(color: cGreen));
            }
            if (state is BasketLoaded) {
              for (int x = 0;
                  x <
                      state.basket
                          .productQuantity(state.basket.products)
                          .keys
                          .length;
                  x++) {
                Product Products;
                Products = state.basket
                    .productQuantity(state.basket.products)
                    .keys
                    .elementAt(x);
                allproducts.add(Products);
                int Productvalue;
                Productvalue = state.basket
                    .productQuantity(state.basket.products)
                    .values
                    .elementAt(x);
                allproductvalues.add(Productvalue);

                if (shoplist.contains(Products.ownerId)) {
                } else {
                  shoplist.add(Products.ownerId);
                }
              }

              //TRY ULIT
              return Container(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 665.9,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      itemCount: shoplist.length,
                                      itemBuilder: (context, index) {
                                        selectedproducts = [];
                                        selectedproductvalues = [];

                                        for (int x = 0;
                                            x < userSellersid.length;
                                            x++) {
                                          if (userSellersid[x] ==
                                              shoplist[index]) {
                                            shopname.add(
                                                userSellers[x]['shop name']);
                                          }
                                        }

                                        for (int x = 0;
                                            x < allproducts.length;
                                            x++) {
                                          if (allproducts[x].ownerId ==
                                              shoplist[index]) {
                                            selectedproducts
                                                .add(allproducts[x]);
                                            selectedproductvalues
                                                .add(allproductvalues[x]);
                                          }
                                        }

                                        return Container(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListTile(
                                                  onTap: () {
                                                    setState(() {
                                                      selectedtile = index;
                                                    });
                                                  },
                                                  
                                                  tileColor:
                                                      selectedtile == index
                                                          ? cGreen.withOpacity(0.50)
                                                          : cGreen.withOpacity(0.10),
                                                  title: Text(
                                                    shopname[index],
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Poppins',
                                                      color: cBlack
                                                    ),
                                                  ),
                                                  trailing: Icon(
                                                    selectedtile != index
                                                        ? Icons
                                                            .check_box_outline_blank_sharp
                                                        : Icons
                                                            .check_box_outlined,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    //color: cGreen,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ScrollPhysics(),
                                                        itemCount:
                                                            selectedproducts
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return BasketProdCard(
                                                              product:
                                                                  selectedproducts[
                                                                      index],
                                                              quantity:
                                                                  selectedproductvalues[
                                                                      index]);
                                                        })),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Divider(
                                                  thickness: 1,
                                                ),
                                              ),
                                              Container(
                                                child: OrderSummary(
                                                  selectedproducts:
                                                      selectedproducts,
                                                  selectedproductvalues:
                                                      selectedproductvalues,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                              /*Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Divider(
                                      thickness: 1,
                                    ),
                                  ),
                                  OrderSummary(),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );

              // Eto TRY pero okay naman
              /*for (int x = 0; x < shoplist.length; x++)
              {
                return Container(
                    child: SizedBox(
                        height: 530,
                        child: ListView.builder(
                            itemCount: state.basket
                                .productQuantity(state.basket.products)
                                .keys
                                .length,
                            itemBuilder: (context, index) {
                              return BasketProdCard(
                                product: state.basket
                                    .productQuantity(state.basket.products)
                                    .keys
                                    .elementAt(index),
                                quantity: state.basket
                                    .productQuantity(state.basket.products)
                                    .values
                                    .elementAt(index),
                              );
                            })));
              }*/

              //Eto yung unang code
              /*return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: 530,
                                    child: ListView.builder(
                                        itemCount: state.basket
                                            .productQuantity(
                                                state.basket.products)
                                            .keys
                                            .length,
                                        itemBuilder: (context, index) {
                                          return BasketProdCard(
                                            product: state.basket
                                                .productQuantity(
                                                    state.basket.products)
                                                .keys
                                                .elementAt(index),
                                            quantity: state.basket
                                                .productQuantity(
                                                    state.basket.products)
                                                .values
                                                .elementAt(index),
                                          );
                                        })),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          OrderSummary(),
                        ],
                      ),
                    ],
                  );*/
            } else {
              return Text("sarreh");
            }
          },
        ),
      ),
    );
  }
}
