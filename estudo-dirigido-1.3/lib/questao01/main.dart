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

  Cliente c1 = Cliente("André Felipe", "andref@gmail.com", 100.0, true);
  Cliente c2 = Cliente("Rayane Nepomuceno", "rayanen@gmail.com", 200.0, true);

  c1.nome = "André Felipe";
  c2.email = "rayanenepomuceno@gmail.com";

  c1.adicionarSaldo(50.0);

  c2.debitarSaldo(80.0);

  c1.exibirCliente();
  c2.exibirCliente();
}
