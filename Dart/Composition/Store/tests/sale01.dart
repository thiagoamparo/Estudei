import '../modules/client.dart';
import '../modules/item.dart';
import '../modules/product.dart';
import '../modules/cart.dart';

void main() {

  var sale = Cart(
    client: Client(
      name: "Isabela Tatiane Jesus",
      cpf: "391.818.748-98"
    ),
    itens: <Item> [
      Item(
        product: Product(
          code: 01,
          name: "Camiseta",
          price: 50.00,
          discont: 0.10
        ), 
        amount: 15
      ),
      Item(
        product: Product(
          code: 02,
          name: "Calça jeans",
          price: 120.00,
          discont: 0.15
        ), 
        amount: 3
      )
    ]
  );

  print(sale);
  
}