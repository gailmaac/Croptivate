import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrlOne;
  final String imageUrlTwo;
  final String imageUrlThree;
  final double price;
  final bool isDeals;
  final bool isRecommended;
  final int stockCount;
  final int weightCount;
  final String weight;
  final String description;
  
  const Product({
    required this.name,
    required this.category,
    required this.imageUrlOne,
    required this.imageUrlTwo,
    required this.imageUrlThree,
    required this.price,
    required this.isDeals,
    required this.isRecommended,
    required this.stockCount,
    required this.weightCount,
    required this.weight,
    required this.description,
  });

  static Product fromSnapshot(DocumentSnapshot snap){
    Product product = Product(
      name: snap['name'],
      category: snap['category'],
      imageUrlOne: snap['imageUrlOne'],
      imageUrlTwo: snap['imageUrlTwo'],
      imageUrlThree: snap['imageUrlThree'],
      price: snap['price'],
      isDeals: snap['isDeals'],
      isRecommended: snap['isRecommended'],
      stockCount: snap['stockCount'],
      weightCount: snap['weightCount'],
      weight: snap['weight'],
      description: snap['description'],
      );
      return product;
  }

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrlOne,
    imageUrlTwo,
    imageUrlThree,
    price,
    isDeals,
    isRecommended,
    stockCount,
    weightCount,
    weight
  ];
  
  static List<Product> products = [
    //isDeals
    Product(
      name: "Potato Marbles",
      category: "Root Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1508313880080-c4bef0730395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1508313880080-c4bef0730395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1508313880080-c4bef0730395?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      price: 90,
      isDeals: true,
      isRecommended: false,
      stockCount: 8,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Potato",
      category: "Root Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1518977676601-b53f82aba655?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      price: 70,
      isDeals: true,
      isRecommended: false,
      stockCount: 10,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Chayote",
      category: "Climbers and Creepers",
      imageUrlOne: "https://as1.ftcdn.net/v2/jpg/00/60/28/62/1000_F_60286292_5jwoJaa1TWanYFLJXf7eOeKlg4iL8ad3.jpg",
      imageUrlTwo: "https://as1.ftcdn.net/v2/jpg/00/60/28/62/1000_F_60286292_5jwoJaa1TWanYFLJXf7eOeKlg4iL8ad3.jpg",
      imageUrlThree: "https://as1.ftcdn.net/v2/jpg/00/60/28/62/1000_F_60286292_5jwoJaa1TWanYFLJXf7eOeKlg4iL8ad3.jpg",
      price: 100,
      isDeals: true,
      isRecommended: false,
      stockCount: 18,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Pechay",
      category: "Leafy Vegetables",
      imageUrlOne: "https://as2.ftcdn.net/v2/jpg/03/26/95/93/1000_F_326959353_wlJd8opIhFrL97RKVNuvaobFwHp6PaBB.jpg",
      imageUrlTwo: "https://as2.ftcdn.net/v2/jpg/03/26/95/93/1000_F_326959353_wlJd8opIhFrL97RKVNuvaobFwHp6PaBB.jpg",
      imageUrlThree: "https://as2.ftcdn.net/v2/jpg/03/26/95/93/1000_F_326959353_wlJd8opIhFrL97RKVNuvaobFwHp6PaBB.jpg",
      price: 70,
      isDeals: true,
      isRecommended: false,
      stockCount: 18,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",  
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Bottle Gourd",
      category: "Climbers and Creepers",
      imageUrlOne: "https://th.bing.com/th/id/R.f5277d0d60acf5a9952ff0b14b0f3a72?rik=pE6%2fm%2fW9b14XTw&riu=http%3a%2f%2fwww.diyhealthremedy.com%2fwp-content%2fuploads%2f2014%2f08%2fBottle-Gourd.jpg&ehk=htjp%2bEeXvGCUCjP8q%2bfp2WSCl%2ftPeI%2bhywzRMTt3cro%3d&risl=&pid=ImgRaw&r=0",
      imageUrlTwo: "https://th.bing.com/th/id/R.f5277d0d60acf5a9952ff0b14b0f3a72?rik=pE6%2fm%2fW9b14XTw&riu=http%3a%2f%2fwww.diyhealthremedy.com%2fwp-content%2fuploads%2f2014%2f08%2fBottle-Gourd.jpg&ehk=htjp%2bEeXvGCUCjP8q%2bfp2WSCl%2ftPeI%2bhywzRMTt3cro%3d&risl=&pid=ImgRaw&r=0",
      imageUrlThree: "https://th.bing.com/th/id/R.f5277d0d60acf5a9952ff0b14b0f3a72?rik=pE6%2fm%2fW9b14XTw&riu=http%3a%2f%2fwww.diyhealthremedy.com%2fwp-content%2fuploads%2f2014%2f08%2fBottle-Gourd.jpg&ehk=htjp%2bEeXvGCUCjP8q%2bfp2WSCl%2ftPeI%2bhywzRMTt3cro%3d&risl=&pid=ImgRaw&r=0",
      price: 120,
      isDeals: true,
      isRecommended: false,
      stockCount: 6,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo", 
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Bell Pepper",
      category: "Plant Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1601648764658-cf37e8c89b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=871&q=80",
      price: 110,
      isDeals: true,
      isRecommended: false,
      stockCount: 9,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Red Leaf Lettuce",
      category: "Leafy Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      price: 130,
      isDeals: true,
      isRecommended: false,
      stockCount: 12,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),

    //isRecommended
      Product(
      name: "Broccoli",
      category: "Leafy Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1606585333304-a7fa1ca4376c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1591981093714-034c8ed010f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      price: 100,
      isDeals: false,
      isRecommended: true,
      stockCount: 15,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Cabbage",
      category: "Climbers and Creepers",
      imageUrlOne: "https://images.unsplash.com/photo-1603049404411-13c2ca81a316?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=882&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1603049404411-13c2ca81a316?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=882&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1603049404411-13c2ca81a316?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=882&q=80",
      price: 90,
      isDeals: false,
      isRecommended: true,
      stockCount: 13,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo", 
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Cauliflower",
      category: "Climbers and Creepers",
      imageUrlOne: "https://images.unsplash.com/photo-1601171908684-75604cf5da5f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1601171908684-75604cf5da5f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1601171908684-75604cf5da5f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=870&q=80",
      price: 100,
      isDeals: false,
      isRecommended: true,
      stockCount: 15,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Carrots",
      category: "Root Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1447175008436-054170c2e979?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=999&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1447175008436-054170c2e979?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=999&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1447175008436-054170c2e979?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=999&q=80",
      price: 70,
      isDeals: false,
      isRecommended: true,
      stockCount: 8,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Bitter Gourd",
      category: "Climbers and Creepers",
      imageUrlOne: "https://images.unsplash.com/photo-1588391453522-a8b470845269?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1588391453522-a8b470845269?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1588391453522-a8b470845269?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1526&q=80",
      price: 90,
      isDeals: false,
      isRecommended: true,
      stockCount: 21,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Tomato",
      category: "Plant Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1582284540020-8acbe03f4924?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80",
      price: 60,
      isDeals: false,
      isRecommended: true,
      stockCount: 15,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
    Product(
      name: "Lady Finger",
      category: "Plant Vegetables",
      imageUrlOne: "https://images.unsplash.com/photo-1558408525-1092038389ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=580&q=80",
      imageUrlTwo: "https://images.unsplash.com/photo-1558408525-1092038389ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=580&q=80",
      imageUrlThree: "https://images.unsplash.com/photo-1558408525-1092038389ae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=580&q=80",
      price: 50,
      isDeals: false,
      isRecommended: true,
      stockCount: 8,
      description: "Product and Payment Information:\nPay manually online using the following options and send us the proof of payment afterwards.\nIf online payment is not available for you, Cash On Delivery (COD) is also available:\n\nGCash\n09171232568\nCamille Abi E\n\nPaymaya\n09171232568\nCamille Abi E\n\nUnionBank\n109421041204\nCamille Abi Enzo",
      weightCount: 500,
      weight: "grams"
    ),
  ];
}