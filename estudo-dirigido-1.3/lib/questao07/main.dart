class Cliente {
  String _nome = "";
  String _email = "";

  Cliente(String nome, String email) {
    _nome = nome;
    _email = email;
  }

  String get nome => _nome;
  String get email => _email;
}

class Produto {
  String _nome = "";
  double _preco = 0;

  Produto(String nome, double preco) {
    _nome = nome;
    _preco = preco;
  }

  String get nome => _nome;
  double get preco => _preco;
}

class ItemCarrinho {
  Produto _produto;
  int _quantidade;

  ItemCarrinho(Produto produto, int quantidade)
      : _produto = produto,
        _quantidade = quantidade > 0 ? quantidade : 1;

  Produto get produto => _produto;
  int get quantidade => _quantidade;

  double calcularSubtotal() => _produto.preco * _quantidade;

  void exibirItem() {
    print("  - ${_produto.nome} x $_quantidade = R\$ ${calcularSubtotal()}");
  }
}

class ListaCarrinho {
  List<ItemCarrinho> _itens = [];

  void inserir(ItemCarrinho item) => _itens.add(item);
  void remover(int i) {
    if (i >= 0 && i < _itens.length) _itens.removeAt(i);
  }
  int tamanho() => _itens.length;
  ItemCarrinho? get(int i) => (i >= 0 && i < _itens.length) ? _itens[i] : null;
  List<ItemCarrinho> get todos => _itens;
}

class Carrinho {
  Cliente _cliente;
  ListaCarrinho _itens;
  bool _aberto;

  Carrinho(Cliente cliente)
      : _cliente = cliente,
        _itens = ListaCarrinho(),
        _aberto = true;

  Cliente get cliente => _cliente;
  ListaCarrinho get itens => _itens;
  bool get aberto => _aberto;

  set cliente(Cliente valor) {
    _cliente = valor;
  }

  set aberto(bool valor) {
    _aberto = valor;
  }

  void adicionarItem(ItemCarrinho item) {
    if (_aberto) {
      _itens.inserir(item);
      print("Item ${item.produto.nome} adicionado ao carrinho.");
    } else {
      print("Erro: carrinho fechado.");
    }
  }

  void removerItem(int i) {
    if (_aberto) {
      _itens.remover(i);
    } else {
      print("Erro: carrinho fechado.");
    }
  }

  double calcularTotal() {
    double total = 0;
    for (ItemCarrinho item in _itens.todos) {
      total += item.calcularSubtotal();
    }
    return total;
  }

  void exibirCarrinho() {
    print("=== Carrinho de ${_cliente.nome} ===");
    print("Status: ${_aberto ? 'Aberto' : 'Fechado'}");
    print("Itens:");
    for (ItemCarrinho item in _itens.todos) {
      item.exibirItem();
    }
    print("Total: R\$ ${calcularTotal()}");
  }
}

void main() {

  Cliente cliente = Cliente("André Felipe", "andref@gmail.com");

  Produto p1 = Produto("Camiseta", 49.90);
  Produto p2 = Produto("Jaqueta", 199.90);

  ItemCarrinho item1 = ItemCarrinho(p1, 2);
  ItemCarrinho item2 = ItemCarrinho(p2, 1);

  Carrinho carrinho = Carrinho(cliente);
  carrinho.adicionarItem(item1);
  carrinho.adicionarItem(item2);

  carrinho.exibirCarrinho();
}
