class Cliente {
  String _nome = "";
  String _email = "";
  double _saldoCarteira = 0;
  bool _ativo = false;

  Cliente(String nome, String email, double saldoCarteira, bool ativo) {
    _nome = nome;
    _email = email;
    _saldoCarteira = saldoCarteira;
    _ativo = ativo;
  }

  String get nome => _nome;
  String get email => _email;
  double get saldoCarteira => _saldoCarteira;
  bool get ativo => _ativo;

  void exibirCliente() {
    print("Nome: $_nome | Email: $_email | Saldo: $_saldoCarteira | Ativo: $_ativo");
  }
}

class ListaCliente {
  List<Cliente> _clientes = [];

  void inserir(Cliente cliente) {
    _clientes.add(cliente);
    print("Cliente ${cliente.nome} inserido na lista.");
  }

  void remover(int i) {
    if (i >= 0 && i < _clientes.length) {
      print("Cliente ${_clientes[i].nome} removido.");
      _clientes.removeAt(i);
    } else {
      print("Erro: índice inválido.");
    }
  }

  int tamanho() {
    return _clientes.length;
  }

  Cliente? get(int i) {
    if (i >= 0 && i < _clientes.length) {
      return _clientes[i];
    } else {
      print("Erro: índice inválido.");
      return null;
    }
  }

  void exibirLista() {
    print("--- Lista de Clientes (${_clientes.length}) ---");
    for (int i = 0; i < _clientes.length; i++) {
      print("[$i] ");
      _clientes[i].exibirCliente();
    }
  }
}

void main() {
  // Criando clientes
  Cliente c1 = Cliente("Ana Silva", "ana@email.com", 100.0, true);
  Cliente c2 = Cliente("Bruno Lima", "bruno@email.com", 200.0, true);
  Cliente c3 = Cliente("Carla Souza", "carla@email.com", 50.0, false);

  // Inserindo na lista
  ListaCliente lista = ListaCliente();
  lista.inserir(c1);
  lista.inserir(c2);
  lista.inserir(c3);

  // Mostrando tamanho
  print("Tamanho da lista: ${lista.tamanho()}");

  // Recuperando cliente pelo índice
  Cliente? clienteRecuperado = lista.get(1);
  if (clienteRecuperado != null) {
    print("Cliente recuperado: ${clienteRecuperado.nome}");
  }

  // Removendo um cliente
  lista.remover(0);

  // Exibindo lista final
  lista.exibirLista();
}
