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

  // Getters
  String get nome => _nome;
  String get email => _email;
  double get saldoCarteira => _saldoCarteira;
  bool get ativo => _ativo;

  // Setters
  set nome(String valor) {
    if (valor.isNotEmpty) {
      _nome = valor;
    } else {
      print("Erro: nome não pode ser vazio.");
    }
  }

  set email(String valor) {
    if (valor.isNotEmpty) {
      _email = valor;
    } else {
      print("Erro: email não pode ser vazio.");
    }
  }

  set saldoCarteira(double valor) {
    if (valor >= 0) {
      _saldoCarteira = valor;
    } else {
      print("Erro: saldo não pode ser negativo.");
    }
  }

  set ativo(bool valor) {
    _ativo = valor;
  }

  // Métodos
  void ativar() {
    _ativo = true;
    print("Cliente $_nome ativado.");
  }

  void desativar() {
    _ativo = false;
    print("Cliente $_nome desativado.");
  }

  void adicionarSaldo(double valor) {
    if (valor > 0) {
      _saldoCarteira += valor;
      print("Saldo adicionado. Novo saldo: $_saldoCarteira");
    } else {
      print("Erro: valor inválido para adicionar.");
    }
  }

  void debitarSaldo(double valor) {
    if (valor > 0 && valor <= _saldoCarteira) {
      _saldoCarteira -= valor;
      print("Saldo debitado. Novo saldo: $_saldoCarteira");
    } else {
      print("Erro: saldo insuficiente ou valor inválido.");
    }
  }

  void exibirCliente() {
    print("--- Cliente ---");
    print("Nome: $_nome");
    print("Email: $_email");
    print("Saldo: $_saldoCarteira");
    print("Ativo: $_ativo");
  }
}

void main() {
  // Criando dois clientes
  Cliente c1 = Cliente("Ana Silva", "ana@email.com", 100.0, true);
  Cliente c2 = Cliente("Bruno Lima", "bruno@email.com", 200.0, true);

  // Alterando dados com setters
  c1.nome = "Ana Costa";
  c2.email = "brunolima@email.com";

  // Adicionando saldo no c1
  c1.adicionarSaldo(50.0);

  // Debitando saldo do c2
  c2.debitarSaldo(80.0);

  // Exibindo dados finais
  c1.exibirCliente();
  c2.exibirCliente();
}
