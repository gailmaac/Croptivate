import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int cnumber;
  final String fname;
  final String lname;
  final String loc;

  const User({
  required this.cnumber,
  required this.fname,
  required this.lname,
  required this.loc,
});

static User fromSnapshot(DocumentSnapshot snap) {
  User user = User(
    cnumber: snap['cnum'], 
    fname: snap['fname'], 
    lname: snap['lname'], 
    loc: snap['loc']
    );
  return user;
}


  @override
  List<Object?> get props => [
    cnumber,
    fname,
    lname,
    loc
  ];
}

List<User> user = [
  User(
    cnumber: 09154825692,
    fname: "Juan",
    lname: "Dela Cruz",
    loc: "7124 General Ricarte St. South Cembo, Makati City"
    )
];