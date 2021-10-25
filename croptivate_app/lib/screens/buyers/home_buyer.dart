import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/basket.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/herocarouselcard.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:croptivate_app/widgets/productcarousel.dart';
import 'package:croptivate_app/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBuyer extends StatelessWidget {
  
  static const String routeName = '/homebuyer';
  
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => HomeBuyer());
  }

  const HomeBuyer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: cGreen,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Align(
            alignment: AlignmentDirectional(-1, -1),
            child: Container(
              width: 350,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Align(
                alignment: AlignmentDirectional(0,0),
                child: Container(
                  width: 350,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-10, -3.52),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 5, 5, 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    hintText: "What are you looking for?",
                                    hintStyle: hintBodyText,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0.94, 0.16),
                                child: Icon(
                                Icons.search_rounded,
                                color: Color(0xA3000000),
                                size: 20,
                              ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ),
          actions: <Widget> [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favorites');
              }, 
              icon: Icon(Icons.favorite_border_rounded), color: cWhite)
          ]
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enableInfiniteScroll: false,
                    initialPage: 2,
                    autoPlay: true,
                  ),
                  items: Category.categories
                  .map((category) => HeroCarouselCard(category: category))
                  .toList(),
                )
              ),
              SectionTitle(
                title: "Deals of the Day"),
              ProductCarousel(
                products: Product.products
                .where((product) => product.isDeals)
                .toList()),
              
              SectionTitle(
                title: "Recommended"),
              ProductCarousel(
                products: Product.products
                .where((product) => product.isRecommended)
                .toList()),
            ],
          ),
        ),
        
        bottomNavigationBar: BottomNavBar(),
        );
  }
}




