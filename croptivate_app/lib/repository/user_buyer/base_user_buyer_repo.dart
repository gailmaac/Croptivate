import 'package:croptivate_app/models/user_model_buyer.dart';

abstract class BaseUserBuyerRepository {

  Stream<List<User>> getUserBuyer();
}