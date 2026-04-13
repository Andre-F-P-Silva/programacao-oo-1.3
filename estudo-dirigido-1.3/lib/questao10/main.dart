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
    print("  Cliente: $_nome | Email: $_email | Saldo: R\$ $_saldoCarteira | Ativo: $_ativo");
  }
}

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
    print("  Produto: $_nome | Preço: R\$ $_preco | Estoque: $_estoque | Ativo: $_ativo");
  }
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
    print("    - ${_produto.nome} x $_quantidade = R\$ ${calcularSubtotal()}");
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
  double get totalFinal => _totalFinal;
  String get status => _status;

  void fecharPedido() {
    _totalBruto = _carrinho.calcularTotal();
    if (_cupom != null && _cupom!.ativo) {
      _totalFinal = _totalBruto - _cupom!.calcularDesconto(_totalBruto);
    } else {
      _totalFinal = _totalBruto;
    }
    _status = "fechado";
  }

  void exibirResumoPedido() {
    print("  Pedido: $_numero | Status: $_status | Total: R\$ $_totalFinal");
    for (ItemCarrinho item in _carrinho.itens.todos) {
      item.exibirItem();
    }
  }
}

class ListaCliente {
  List<Cliente> _clientes = [];
  void inserir(Cliente c) => _clientes.add(c);
  List<Cliente> get todos => _clientes;
}

class ListaProduto {
  List<Produto> _produtos = [];
  void inserir(Produto p) => _produtos.add(p);
  List<Produto> get todos => _produtos;
}

class Loja {
  String _nome = "";
  ListaCliente _clientes;
  ListaProduto _produtos;
  List<Pedido> _pedidos;

  Loja(String nome)
      : _nome = nome,
        _clientes = ListaCliente(),
        _produtos = ListaProduto(),
        _pedidos = [];

  // Getters
  String get nome => _nome;
  ListaCliente get clientes => _clientes;
  ListaProduto get produtos => _produtos;
  List<Pedido> get pedidos => _pedidos;

  // Setter
  set nome(String valor) {
    if (valor.isNotEmpty) {
      _nome = valor;
    } else {
      print("Erro: nome da loja não pode ser vazio.");
    }
  }

  // Métodos
  void cadastrarCliente(Cliente cliente) {
    _clientes.inserir(cliente);
    print("Cliente ${cliente.nome} cadastrado na loja.");
  }

  void cadastrarProduto(Produto produto) {
    _produtos.inserir(produto);
    print("Produto ${produto.nome} cadastrado na loja.");
  }

  void registrarPedido(Pedido pedido) {
    _pedidos.add(pedido);
    print("Pedido ${pedido.numero} registrado na loja.");
  }

  void exibirResumoLoja() {
    print("=============================");
    print("Loja: $_nome");
    print("=============================");

    print("\nClientes (${_clientes.todos.length}):");
    for (Cliente c in _clientes.todos) {
      c.exibirCliente();
    }

    print("\nProdutos (${_produtos.todos.length}):");
    for (Produto p in _produtos.todos) {
      p.exibirProduto();
    }

    print("\nPedidos (${_pedidos.length}):");
    for (Pedido p in _pedidos) {
      p.exibirResumoPedido();
    }

    print("=============================");
  }
}

void main() {
  // Criando a loja
  Loja loja = Loja("Minha Loja");

  // Criando clientes
  Cliente c1 = Cliente("Ana Silva", "ana@email.com", 500.0, true);
  Cliente c2 = Cliente("Bruno Lima", "bruno@email.com", 300.0, true);

  // Criando produtos
  Produto p1 = Produto("Camiseta", 49.90, 50, true);
  Produto p2 = Produto("Calça Jeans", 129.90, 20, true);

  // Cadastrando na loja
  loja.cadastrarCliente(c1);
  loja.cadastrarCliente(c2);
  loja.cadastrarProduto(p1);
  loja.cadastrarProduto(p2);

  // Criando um pedido
  Carrinho carrinho = Carrinho(c1);
  carrinho.adicionarItem(ItemCarrinho(p1, 2));
  carrinho.adicionarItem(ItemCarrinho(p2, 1));

  CupomDesconto cupom = CupomDesconto("LOJA10", 10, true);
  Pedido pedido = Pedido("PED-001", carrinho, cupom: cupom);
  pedido.fecharPedido();

  // Registrando pedido na loja
  loja.registrarPedido(pedido);

  // Exibindo resumo geral
  loja.exibirResumoLoja();
}
