class Produto {
  String _nome = "";
  double _preco = 0;
  int _estoque = 0;
  bool _ativo = false;

  Produto(String nome, double preco, int estoque, bool ativo) {
    _nome = nome;
    _preco = preco;
    _estoque = estoque;
    _ativo = ativo;
  }

  String get nome => _nome;
  double get preco => _preco;
  int get estoque => _estoque;
  bool get ativo => _ativo;
}

class ItemCarrinho {
  Produto _produto;
  int _quantidade;

  ItemCarrinho(Produto produto, int quantidade)
      : _produto = produto,
        _quantidade = quantidade > 0 ? quantidade : 1;

  Produto get produto => _produto;
  int get quantidade => _quantidade;

  set produto(Produto valor) {
    _produto = valor;
  }

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
    print("--- Item do Carrinho ---");
    print("Produto: ${_produto.nome}");
    print("Preço unitário: R\$ ${_produto.preco}");
    print("Quantidade: $_quantidade");
    print("Subtotal: R\$ ${calcularSubtotal()}");
  }
}

void main() {

  Produto p1 = Produto("Camiseta", 49.90, 10, true);
  Produto p2 = Produto("Jaqueta", 199.90, 5, true);

  ItemCarrinho item1 = ItemCarrinho(p1, 2);
  ItemCarrinho item2 = ItemCarrinho(p2, 1);

  item1.quantidade = 3;

  item1.exibirItem();
  item2.exibirItem();
}
