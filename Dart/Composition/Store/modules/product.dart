class Product {

  int code;
  String name;
  double price;
  double discont;

  Product({
    required this.code,
    required this.name,
    required this.price,
    this.discont = 0.0
  });

  double get priceWithDiscount {
    return (1 - discont) * price;
  }

  @override
  String toString() {
    return "Codigo: $code, Nome: $name, Preco: $price, Desconto: $discont, Preco com Desconto: $priceWithDiscount";
  } 
}