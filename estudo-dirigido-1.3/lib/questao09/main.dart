class Cliente {
  String nome = "";
  Cliente(this.nome);
}

class Produto {
  String nome = "";
  double preco = 0;
  Produto(this.nome, this.preco);
}

class ItemCarrinho {
  Produto produto;
  int quantidade;
  ItemCarrinho(this.produto, this.quantidade);
  double calcularSubtotal() => produto.preco * quantidade;
}

class Carrinho {
  Cliente cliente;
  List<ItemCarrinho> itens = [];
  Carrinho(this.cliente);
  void adicionarItem(ItemCarrinho item) => itens.add(item);
  double calcularTotal() {
    double total = 0;
    for (ItemCarrinho item in itens) {
      total += item.calcularSubtotal();
    }
    return total;
  }
}

class CupomDesconto {
  String codigo;
  double percentual;
  bool ativo;
  CupomDesconto(this.codigo, this.percentual, this.ativo);
  double calcularDesconto(double valor) {
    if (ativo) return valor * (percentual / 100);
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
    if (valor == "aberto" || valor == "fechado" || valor == "cancelado") {
      _status = valor;
    } else {
      print("Erro: status inválido.");
    }
  }

  void fecharPedido() {
    if (_status == "aberto") {
      _totalBruto = _carrinho.calcularTotal();
      if (_cupom != null && _cupom!.ativo) {
        _totalFinal = _totalBruto - _cupom!.calcularDesconto(_totalBruto);
      } else {
        _totalFinal = _totalBruto;
      }
      _status = "fechado";
      print("Pedido $_numero fechado!");
    } else {
      print("Erro: pedido não está aberto.");
    }
  }

  void cancelarPedido() {
    _status = "cancelado";
    print("Pedido $_numero cancelado.");
  }

  void exibirResumoPedido() {
    print("--- Pedido: $_numero ---");
    print("Cliente: ${_carrinho.cliente.nome}");
    print("Status: $_status");
    for (ItemCarrinho item in _carrinho.itens) {
      print("  ${item.produto.nome} x ${item.quantidade} = R\$ ${item.calcularSubtotal()}");
    }
    print("Total Bruto: R\$ $_totalBruto");
    if (_cupom != null && _cupom!.ativo) {
      print("Cupom ${_cupom!.codigo}: -${_cupom!.percentual}%");
    }
    print("Total Final: R\$ $_totalFinal");
  }
}

void main() {
  Cliente cliente = Cliente("André Felipe");

  Produto p1 = Produto("Camiseta", 49.90);
  Produto p2 = Produto("Jaqueta", 199.90);

  Carrinho carrinho = Carrinho(cliente);
  carrinho.adicionarItem(ItemCarrinho(p1, 2));
  carrinho.adicionarItem(ItemCarrinho(p2, 1));

  CupomDesconto cupom = CupomDesconto("DESCONTO20", 20, true);

  Pedido pedido = Pedido("PED-001", carrinho, cupom: cupom);
  pedido.fecharPedido();
  pedido.exibirResumoPedido();
}
