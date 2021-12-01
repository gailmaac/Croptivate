import 'package:croptivate_app/models/basketdata_model.dart';

abstract class BaseBasketDataRepository {
  Future<void> addBasket(BasketData basketData);
}