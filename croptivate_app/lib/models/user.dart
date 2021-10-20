class MyUser {

  final String? uid;

  MyUser({ this.uid });

}

class UserData {

  final String uid;
  final String sellerType;
  final String fname;
  final String lname;
  final String loc;
  final String shopname;
  final String shopdesc;
  final int cnum;
  final String avatar;

  UserData({ required this.uid, required this.sellerType, required this.fname, required this.lname, required this.loc, required this.shopname, required this.shopdesc, required this.cnum, required this.avatar});

}