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

  set quantidade(int valor) {
    if (valor > 0) {
      _quantidade = valor;
    } else {
      print("Erro: quantidade deve ser maior que zero.");
    }
  }

  double calcularSubtotal() {
    return _produto.preco * _quantidade;
  }

  void exibirItem() {
    print("Produto: ${_produto.nome} | Qtd: $_quantidade | Subtotal: R\$ ${calcularSubtotal()}");
  }
}

class ListaCarrinho {
  List<ItemCarrinho> _itens = [];

  void inserir(ItemCarrinho item) {
    _itens.add(item);
    print("Item ${item.produto.nome} adicionado ao carrinho.");
  }

  void remover(int i) {
    if (i >= 0 && i < _itens.length) {
      print("Item ${_itens[i].produto.nome} removido.");
      _itens.removeAt(i);
    } else {
      print("Erro: índice inválido.");
    }
  }

  int tamanho() {
    return _itens.length;
  }

  ItemCarrinho? get(int i) {
    if (i >= 0 && i < _itens.length) {
      return _itens[i];
    } else {
      print("Erro: índice inválido.");
      return null;
    }
  }

  void exibirLista() {
    print("--- Itens do Carrinho (${_itens.length}) ---");
    for (int i = 0; i < _itens.length; i++) {
      print("[$i] ");
      _itens[i].exibirItem();
    }
  }
}

void main() {

  Produto p1 = Produto("Camiseta", 49.90);
  Produto p2 = Produto("Jaqueta", 199.90);
  Produto p3 = Produto("Cachecol", 89.90);

  ItemCarrinho item1 = ItemCarrinho(p1, 2);
  ItemCarrinho item2 = ItemCarrinho(p2, 1);
  ItemCarrinho item3 = ItemCarrinho(p3, 1);

  ListaCarrinho lista = ListaCarrinho();
  lista.inserir(item1);
  lista.inserir(item2);
  lista.inserir(item3);

  print("Tamanho da lista: ${lista.tamanho()}");

  ItemCarrinho? itemRecuperado = lista.get(0);
  if (itemRecuperado != null) {
    print("Item recuperado: ${itemRecuperado.produto.nome}");
  }

  lista.remover(1);

  lista.exibirLista();
}
