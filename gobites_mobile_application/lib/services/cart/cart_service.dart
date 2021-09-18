abstract class CartService {
  Future addToCart(int mid, int quantity);
  Future getCartList();
  Future deleteCartItem(int kid);
}
