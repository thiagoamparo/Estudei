import "./product.dart";

class Item {

  Product product;
  int amount;

  Item({
    required this.product,
    required this.amount
  });

  double get total {
    return product.priceWithDiscount * amount;
  }

  @override
  String toString() {
    return "Produto: $product, Quantidade: $amount, Total: $total";
  }
}