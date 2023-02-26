import 'dart:math';

import './modules/client.dart';
import './modules/item.dart';
import './modules/product.dart';
import './modules/cart.dart';

import './database/clients.dart';
import './database/products.dart';

void main() {

  int sales = Random().nextInt(10) + 1;

  for (Map client in clients) {

    Client(
      name: client['Name'],
      cpf: client['CPF']
    );
  }

  for (var i = 0; i < sales; i++) {

    int idClient = Random().nextInt(Client.clients.length);
    Client client = Client.clients[idClient];

    int amountItens = Random().nextInt(10) + 1;
    List<Item> itens = [];

    for (var i = 0; i < amountItens; i++) {

      int codeProduct = Random().nextInt(products.length);
      int amount = Random().nextInt(100) + 1;

      Product product = Product(
        code: products[codeProduct]['Code'], 
        name: products[codeProduct]['Name'], 
        price: products[codeProduct]['Price']
        // discont: products[codeProduct]['Discont']
      );

      int indexWhere = itens.indexWhere((element) => element.product.name == product.name);

      if(indexWhere == -1) {
        
        itens.add(Item(
          product: product, 
          amount: amount
        ));

      } else {

        itens[indexWhere].amount += amount;

      }      
    }

    var sale = Cart(
      client: client,
      itens: itens
    );

    print("$sale\n");
    
  }  
}