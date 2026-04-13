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

  void exibirProduto() {
    print("Nome: $_nome | Preço: R\$ $_preco | Estoque: $_estoque | Ativo: $_ativo");
  }
}

class ListaProduto {
  List<Produto> _produtos = [];

  void inserir(Produto produto) {
    _produtos.add(produto);
    print("Produto ${produto.nome} inserido na lista.");
  }

  void remover(int i) {
    if (i >= 0 && i < _produtos.length) {
      print("Produto ${_produtos[i].nome} removido.");
      _produtos.removeAt(i);
    } else {
      print("Erro: índice inválido.");
    }
  }

  int tamanho() {
    return _produtos.length;
  }

  Produto? get(int i) {
    if (i >= 0 && i < _produtos.length) {
      return _produtos[i];
    } else {
      print("Erro: índice inválido.");
      return null;
    }
  }

  void exibirLista() {
    print("--- Lista de Produtos (${_produtos.length}) ---");
    for (int i = 0; i < _produtos.length; i++) {
      print("[$i] ");
      _produtos[i].exibirProduto();
    }
  }
}

void main() {

  Produto p1 = Produto("Camiseta", 49.90, 10, true);
  Produto p2 = Produto("Jaqueta", 199.90, 5, true);
  Produto p3 = Produto("Cachecol", 89.90, 8, true);

  ListaProduto lista = ListaProduto();
  lista.inserir(p1);
  lista.inserir(p2);
  lista.inserir(p3);

  print("Tamanho da lista: ${lista.tamanho()}");

  Produto? produtoRecuperado = lista.get(2);
  if (produtoRecuperado != null) {
    print("Produto recuperado: ${produtoRecuperado.nome}");
  }

  lista.remover(1);

  lista.exibirLista();
}
