import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/category/category_bloc.dart';
import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/basket.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/herocarouselcard.dart';
import 'package:croptivate_app/widgets/navigationdrawer.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:croptivate_app/widgets/productcarousel.dart';
import 'package:croptivate_app/widgets/productlistcard.dart';
import 'package:croptivate_app/widgets/sectiontitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBuyer extends StatefulWidget {
  const HomeBuyer({Key? key}) : super(key: key);
  static const String routeName = '/homebuyer';

  @override
  _HomeBuyerState createState() => _HomeBuyerState();
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => HomeBuyer());
  }
}

List<Tab> tabs = [
  Tab(child: Text("Posts")),
  Tab(child: Text("People")),
];

class _HomeBuyerState extends State<HomeBuyer> {
  TextEditingController _searchto = TextEditingController();
  bool TextEmpty = true;
  List users = [];
  List posts = [];
  late Future postsloaded;
  late Future usersloaded;
  List resultusers = [];
  List resultposts = [];
  String seller = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _searchto.addListener(_onsearchChanged);
  }

  @override
  void dispose() {
    _searchto.removeListener(_onsearchChanged);
    _searchto.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersloaded = getusers();
    postsloaded = getPosts();
  }

  searchuserlist() {
    var showresults = [];
    if (_searchto.text != '') {
      users.forEach((doc) {
        var name = doc['first name'].toString().toLowerCase() +
            ' ' +
            doc['last name'].toString().toLowerCase() +
            ' ' +
            doc['contact number'].toString();
        if (name.contains(_searchto.text)) {
          showresults.add(doc);
        }
      });
    }
    setState(() {
      resultusers = showresults;
    });
  }

  _onsearchChanged() {
    if (_searchto.text.isEmpty) {
      setState(() {
        TextEmpty = true;
      });
    } else {
      searchuserlist();
      searchpostlist();
      setState(() {
        TextEmpty = false;
      });
    }
  }

  getusers() async {
    List user = [];
    try {
      await FirebaseFirestore.instance
          .collection('userBuyer')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          user.add(doc.data());
        });
      });
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          user.add(doc.data());
        });
      });

      setState(() {
        users = user;
      });
      searchuserlist();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  getPosts() async {
    List post = [];
    try {
      await FirebaseFirestore.instance
          .collection('sellerPosts')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          post.add(doc.data());
        });
      });
      setState(() {
        posts = post;
      });
      searchpostlist();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  searchpostlist() {
    var showpostresults = [];
    //var showpostid = [];
    if (_searchto.text != '') {
      posts.forEach((doc) async {
        var owner = doc['ownerId'].toString();
        await FirebaseFirestore.instance
            .collection('userSeller')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (owner == doc.id) {
              setState(() {
                seller = doc['first name'].toString().toLowerCase() +
                    ' ' +
                    doc['last name'].toString().toLowerCase();
              });
            }
          });
        });
        var sellerpost = doc['category'].toString().toLowerCase() +
            ' ' +
            doc['description'].toString().toLowerCase() +
            ' ' +
            doc['name'].toString().toLowerCase() +
            ' ' +
            doc['price'].toString().toLowerCase() +
            ' ' +
            doc['weightCount'].toString().toLowerCase() +
            ' ' +
            doc['stockCount'].toString().toLowerCase() +
            ' ' +
            seller;
        if (sellerpost.contains(_searchto.text)) {
          showpostresults.add(doc);
        }
      });
    }
    setState(() {
      resultposts = showpostresults;
    });
  }

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
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: 350,
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-10, -3.52),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 5, 5),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _searchto,
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
                )),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/favorites');
                },
                icon: Icon(Icons.favorite_border_rounded),
                color: cWhite)
          ]),
      body: TextEmpty == false
          ? DefaultTabController(
              length: tabs.length,
              child: Scaffold(
                  appBar: AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(color: cGreen),
                      backgroundColor: cWhite,
                      elevation: 1,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      centerTitle: true,
                      title: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: TabBar(
                          labelColor: cGreen,
                          labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          indicatorColor: cGreen,
                          isScrollable: true,
                          tabs: tabs,
                        ),
                      )),
                  body: TabBarView(children: [
                    Container(
                      height: double.infinity,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.95, vertical: 16.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1, childAspectRatio: 2.4),
                        itemCount: resultposts.length,
                        itemBuilder: (BuildContext context, int x) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                /*child: ProductListCard(
                    product: Product(
                      category: resultposts[x]['category'],
                      description: resultposts[x]['description'],
                      imageUrlOne: resultposts[x]['imageUrlOne'],
                      imageUrlThree: resultposts[x]['imageUrlThree'],
                      weightCount: resultposts[x]['weightCount'],
                      imageUrlTwo: resultposts[x]['imageUrlTwo'],
                      isDeals: resultposts[x]['isDeals'],
                      isRecommended: resultposts[x]['isRecommended'],
                      weight: resultposts[x]['weight'],
                      name: resultposts[x]['name'],
                      ownerId: resultposts[x]['ownerId'],
                      price: resultposts[x]['price'],
                      stockCount: resultposts[x]['stockCount'],
                      sellerPostId: x.id,
                    ),
                    widthFactor: 1.1,
                    leftPosition: 150,
                    topPosition: 70,
                    heightofBox: 70,
                    widthValue: 205,
                    isRemoved: true,
                  ),*/
                                ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      color: cWhite,
                      child: ListView.builder(
                          itemCount: resultusers.length,
                          itemBuilder: (context, int) {
                            return ListTile(
                              tileColor: cGrey,
                              title: Text(
                                  resultusers[int]['first name'].toString()),
                            );
                          }),
                    ),
                  ])))
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state is CategoryLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: cGreen,
                          ),
                        );
                      }

                      if (state is CategoryLoaded) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 1.5,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enableInfiniteScroll: false,
                            initialPage: 2,
                            autoPlay: true,
                          ),
                          items: state.categories
                              .map((category) =>
                                  HeroCarouselCard(category: category))
                              .toList(),
                        );
                      } else {
                        return Text("Sorry");
                      }
                    },
                  )),
                  SectionTitle(title: "Deals of the Day"),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: cGreen,
                        ));
                      }

                      if (state is ProductLoaded) {
                        return ProductCarousel(
                            products: state.products
                                .where((product) => product.isDeals)
                                .toList());
                      } else {
                        return Text("Sorry");
                      }
                    },
                  ),
                  SectionTitle(title: "Recommended"),
                  BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: cGreen,
                        ));
                      }

                      if (state is ProductLoaded) {
                        return ProductCarousel(
                            products: state.products
                                .where((product) => product.isRecommended)
                                .toList());
                      } else {
                        return Text("Sorry");
                      }
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
