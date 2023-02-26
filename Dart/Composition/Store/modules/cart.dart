import './client.dart';
import './item.dart';

class Cart {

  Client client;
  List<Item> itens;

  Cart({
    required this.client,
    required this.itens
  });

  double get total {
    return itens
      .map((e) => e.total)
      .reduce((value, element) => value + element);
  }

  @override
  String toString() {
    return "$client\nItens: ${itens.map((e) => e.toString()).reduce((value, element) => value + "\n " + element)}\nValor Total: $total";
  }  
}