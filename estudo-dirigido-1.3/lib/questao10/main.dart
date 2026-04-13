class Cliente {
  String nome = "";
  String email = "";
  Cliente(this.nome, this.email);
  void exibirCliente() => print("  Cliente: $nome | $email");
}

class Produto {
  String nome = "";
  double preco = 0;
  int estoque = 0;
  Produto(this.nome, this.preco, this.estoque);
  void exibirProduto() => print("  Produto: $nome | R\$ $preco | Estoque: $estoque");
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
    for (ItemCarrinho item in itens) total += item.calcularSubtotal();
    return total;
  }
}

class Pedido {
  String numero;
  Carrinho carrinho;
  double totalFinal = 0;
  String status = "aberto";
  Pedido(this.numero, this.carrinho);
  void fecharPedido() {
    totalFinal = carrinho.calcularTotal();
    status = "fechado";
  }
  void exibirResumoPedido() {
    print("  Pedido: $numero | Status: $status | Total: R\$ $totalFinal");
  }
}

class Loja {
  String _nome = "";
  List<Cliente> _clientes = [];
  List<Produto> _produtos = [];
  List<Pedido> _pedidos = [];

  Loja(String nome) {
    _nome = nome;
  }

  String get nome => _nome;
  List<Cliente> get clientes => _clientes;
  List<Produto> get produtos => _produtos;
  List<Pedido> get pedidos => _pedidos;

  set nome(String valor) {
    if (valor.isNotEmpty) {
      _nome = valor;
    } else {
      print("Erro: nome da loja não pode ser vazio.");
    }
  }

  void cadastrarCliente(Cliente cliente) {
    _clientes.add(cliente);
    print("Cliente ${cliente.nome} cadastrado.");
  }

  void cadastrarProduto(Produto produto) {
    _produtos.add(produto);
    print("Produto ${produto.nome} cadastrado.");
  }

  void registrarPedido(Pedido pedido) {
    _pedidos.add(pedido);
    print("Pedido ${pedido.numero} registrado.");
  }

  void exibirResumoLoja() {
    print("=== Loja: Furacão Store ===");

    print("\nClientes (${_clientes.length}):");
    for (Cliente c in _clientes) c.exibirCliente();

    print("\nProdutos (${_produtos.length}):");
    for (Produto p in _produtos) p.exibirProduto();

    print("\nPedidos (${_pedidos.length}):");
    for (Pedido p in _pedidos) p.exibirResumoPedido();
  }
}

void main() {
  Loja loja = Loja("Furacão Store");

  Cliente c1 = Cliente("André Felipe", "andref@gmail.com");
  Cliente c2 = Cliente("Rayane Nepomuceno", "rayanen@gmail.com");

  Produto p1 = Produto("Camiseta", 49.90, 50);
  Produto p2 = Produto("Jaqueta", 199.90, 20);

  loja.cadastrarCliente(c1);
  loja.cadastrarCliente(c2);
  loja.cadastrarProduto(p1);
  loja.cadastrarProduto(p2);

  Carrinho carrinho = Carrinho(c1);
  carrinho.adicionarItem(ItemCarrinho(p1, 2));
  carrinho.adicionarItem(ItemCarrinho(p2, 1));

  Pedido pedido = Pedido("PED-001", carrinho);
  pedido.fecharPedido();
  loja.registrarPedido(pedido);

  loja.exibirResumoLoja();
}
