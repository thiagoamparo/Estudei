class Client {

  static List<Client> clients = [];

  int id = clients.length;
  String name;
  String cpf;

  Client({
    required this.name,
    required this.cpf
  }) {

    clients.add(this);

  }

  @override
  String toString() {
    return "Cliente: $name, $cpf";
  }  
}