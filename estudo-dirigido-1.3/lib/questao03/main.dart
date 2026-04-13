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

  // Getters
  String get nome => _nome;
  double get preco => _preco;
  int get estoque => _estoque;
  bool get ativo => _ativo;

  // Setters
  set nome(String valor) {
    if (valor.isNotEmpty) {
      _nome = valor;
    } else {
      print("Erro: nome não pode ser vazio.");
    }
  }

  set preco(double valor) {
    if (valor >= 0) {
      _preco = valor;
    } else {
      print("Erro: preço não pode ser negativo.");
    }
  }

  set estoque(int valor) {
    if (valor >= 0) {
      _estoque = valor;
    } else {
      print("Erro: estoque não pode ser negativo.");
    }
  }

  set ativo(bool valor) {
    _ativo = valor;
  }

  // Métodos
  void ativar() {
    _ativo = true;
    print("Produto $_nome ativado.");
  }

  void desativar() {
    _ativo = false;
    print("Produto $_nome desativado.");
  }

  void reporEstoque(int quantidade) {
    if (quantidade > 0) {
      _estoque += quantidade;
      print("Estoque reposto. Novo estoque: $_estoque");
    } else {
      print("Erro: quantidade inválida.");
    }
  }

  void retirarEstoque(int quantidade) {
    if (quantidade > 0 && quantidade <= _estoque) {
      _estoque -= quantidade;
      print("Estoque retirado. Novo estoque: $_estoque");
    } else {
      print("Erro: quantidade inválida ou estoque insuficiente.");
    }
  }

  void exibirProduto() {
    print("--- Produto ---");
    print("Nome: $_nome");
    print("Preço: R\$ $_preco");
    print("Estoque: $_estoque");
    print("Ativo: $_ativo");
  }
}

void main() {
  // Criando dois produtos
  Produto p1 = Produto("Camiseta", 49.90, 10, true);
  Produto p2 = Produto("Calça Jeans", 129.90, 5, true);

  // Alterando dados com setters
  p1.nome = "Camiseta Polo";
  p2.preco = 119.90;

  // Repondo estoque do p1
  p1.reporEstoque(20);

  // Retirando estoque do p2
  p2.retirarEstoque(3);

  // Exibindo dados finais
  p1.exibirProduto();
  p2.exibirProduto();
}
