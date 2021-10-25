import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isDeals;
  final bool isRecommended;
  final String location;
  final int stockCount;
  
  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isDeals,
    required this.isRecommended,
    required this.location,
    required this.stockCount
  });

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrl,
    price,
    isDeals,
    isRecommended,
    location,
    stockCount
  ];
  
  static List<Product> products = [
    //isDeals
    Product(
      name: "Potato Marbles",
      category: "Root Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1508313880080-c4bef0730395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      price: 90,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 8
    ),
    Product(
      name: "Potato",
      category: "Root Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      price: 70,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 10
    ),
    Product(
      name: "Chayote",
      category: "Climbers and Creepers",
      imageUrl: "https://as1.ftcdn.net/v2/jpg/00/60/28/62/1000_F_60286292_5jwoJaa1TWanYFLJXf7eOeKlg4iL8ad3.jpg",
      price: 100,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 18
    ),
    Product(
      name: "Pechay",
      category: "Leafy Vegetables",
      imageUrl: "https://as2.ftcdn.net/v2/jpg/03/26/95/93/1000_F_326959353_wlJd8opIhFrL97RKVNuvaobFwHp6PaBB.jpg",
      price: 70,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 18
    ),
    Product(
      name: "Bottle Gourd",
      category: "Climbers and Creepers",
      imageUrl: "https://th.bing.com/th/id/R.f5277d0d60acf5a9952ff0b14b0f3a72?rik=pE6%2fm%2fW9b14XTw&riu=http%3a%2f%2fwww.diyhealthremedy.com%2fwp-content%2fuploads%2f2014%2f08%2fBottle-Gourd.jpg&ehk=htjp%2bEeXvGCUCjP8q%2bfp2WSCl%2ftPeI%2bhywzRMTt3cro%3d&risl=&pid=ImgRaw&r=0",
      price: 120,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 6
    ),
    Product(
      name: "Bell Pepper",
      category: "Plant Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80",
      price: 110,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 9
    ),
    Product(
      name: "Red Leaf Lettuce",
      category: "Leafy Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      price: 130,
      isDeals: true,
      isRecommended: false,
      location: "Makati City, Philippines",
      stockCount: 12
    ),

    //isRecommended
      Product(
      name: "Broccoli",
      category: "Leafy Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1606585333304-a7fa1ca4376c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      price: 100,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 15
    ),
    Product(
      name: "Cabbage",
      category: "Climbers and Creepers",
      imageUrl: "https://images.unsplash.com/photo-1603049404411-13c2ca81a316?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=882&q=80",
      price: 90,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 13
    ),
    Product(
      name: "Cauliflower",
      category: "Climbers and Creepers",
      imageUrl: "https://images.unsplash.com/photo-1601171908684-75604cf5da5f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      price: 100,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 15
    ),
    Product(
      name: "Carrots",
      category: "Root Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1447175008436-054170c2e979?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=999&q=80",
      price: 70,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 8
    ),
    Product(
      name: "Bitter Gourd",
      category: "Climbers and Creepers",
      imageUrl: "https://images.unsplash.com/photo-1588391453522-a8b470845269?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
      price: 90,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 21
    ),
    Product(
      name: "Tomato",
      category: "Plant Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80",
      price: 60,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 15
    ),
    Product(
      name: "Lady Finger",
      category: "Plant Vegetables",
      imageUrl: "https://images.unsplash.com/photo-1558408525-1092038389ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=580&q=80",
      price: 50,
      isDeals: false,
      isRecommended: true,
      location: "Makati City, Philippines",
      stockCount: 8
    ),
  ];
}