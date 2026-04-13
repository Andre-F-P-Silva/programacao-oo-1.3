class Cliente {
  String _nome = "";
  Cliente(String nome) { _nome = nome; }
  String get nome => _nome;
}

class Produto {
  String _nome = "";
  double _preco = 0;
  Produto(String nome, double preco) { _nome = nome; _preco = preco; }
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

  void adicionarItem(ItemCarrinho item) => _itens.inserir(item);

  double calcularTotal() {
    double total = 0;
    for (ItemCarrinho item in _itens.todos) {
      total += item.calcularSubtotal();
    }
    return total;
  }
}

class CupomDesconto {
  String _codigo = "";
  double _percentual = 0;
  bool _ativo = false;

  CupomDesconto(String codigo, double percentual, bool ativo) {
    _codigo = codigo;
    _percentual = percentual;
    _ativo = ativo;
  }

  String get codigo => _codigo;
  double get percentual => _percentual;
  bool get ativo => _ativo;

  double calcularDesconto(double valor) {
    if (_ativo) return valor * (_percentual / 100);
    return 0;
  }
}

class Pedido {
  String _numero = "";
  Carrinho _carrinho;
  CupomDesconto? _cupom;
  double _totalBruto = 0;
  double _totalFinal = 0;
  String _status = "aberto";

  Pedido(String numero, Carrinho carrinho, {CupomDesconto? cupom})
      : _numero = numero,
        _carrinho = carrinho,
        _cupom = cupom;

  String get numero => _numero;
  Carrinho get carrinho => _carrinho;
  CupomDesconto? get cupom => _cupom;
  double get totalBruto => _totalBruto;
  double get totalFinal => _totalFinal;
  String get status => _status;

  set numero(String valor) {
    if (valor.isNotEmpty) {
      _numero = valor;
    } else {
      print("Erro: número não pode ser vazio.");
    }
  }

  set cupom(CupomDesconto? valor) {
    _cupom = valor;
  }

  set status(String valor) {
    List<String> statusValidos = ["aberto", "fechado", "cancelado"];
    if (statusValidos.contains(valor)) {
      _status = valor;
    } else {
      print("Erro: status inválido.");
    }
  }

  void fecharPedido() {
    if (_status == "aberto") {
      _totalBruto = _carrinho.calcularTotal();

      if (_cupom != null && _cupom!.ativo) {
        double desconto = _cupom!.calcularDesconto(_totalBruto);
        _totalFinal = _totalBruto - desconto;
      } else {
        _totalFinal = _totalBruto;
      }

      _status = "fechado";
      print("Pedido $_numero fechado com sucesso.");
    } else {
      print("Erro: pedido não está aberto.");
    }
  }

  void cancelarPedido() {
    if (_status != "cancelado") {
      _status = "cancelado";
      print("Pedido $_numero cancelado.");
    } else {
      print("Pedido já está cancelado.");
    }
  }

  void exibirResumoPedido() {
    print("=== Resumo do Pedido $_numero ===");
    print("Cliente: ${_carrinho.cliente.nome}");
    print("Status: $_status");
    print("Itens:");
    for (ItemCarrinho item in _carrinho.itens.todos) {
      item.exibirItem();
    }
    print("Total Bruto: R\$ $_totalBruto");
    if (_cupom != null && _cupom!.ativo) {
      print("Cupom: ${_cupom!.codigo} (${_cupom!.percentual}% de desconto)");
    }
    print("Total Final: R\$ $_totalFinal");
  }
}

void main() {

  Cliente cliente = Cliente("André Felipe");

  Produto p1 = Produto("Camiseta", 49.90);
  Produto p2 = Produto("Jaqueta", 199.90);

  ItemCarrinho item1 = ItemCarrinho(p1, 2);
  ItemCarrinho item2 = ItemCarrinho(p2, 1);

  Carrinho carrinho = Carrinho(cliente);
  carrinho.adicionarItem(item1);
  carrinho.adicionarItem(item2);

  CupomDesconto cupom = CupomDesconto("DESCONTO20", 20, true);

  Pedido pedido = Pedido("PED-001", carrinho, cupom: cupom);
  pedido.fecharPedido();

  pedido.exibirResumoPedido();
}
