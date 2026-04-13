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

  set codigo(String valor) {
    if (valor.isNotEmpty) {
      _codigo = valor;
    } else {
      print("Erro: código não pode ser vazio.");
    }
  }

  set percentual(double valor) {
    if (valor >= 0 && valor <= 100) {
      _percentual = valor;
    } else {
      print("Erro: percentual deve estar entre 0 e 100.");
    }
  }

  set ativo(bool valor) {
    _ativo = valor;
  }

  void ativar() {
    _ativo = true;
    print("Cupom $_codigo ativado.");
  }

  void desativar() {
    _ativo = false;
    print("Cupom $_codigo desativado.");
  }

  double calcularDesconto(double valor) {
    if (_ativo) {
      return valor * (_percentual / 100);
    } else {
      print("Cupom inativo, nenhum desconto aplicado.");
      return 0;
    }
  }

  void exibirCupom() {
    print("--- Cupom de Desconto ---");
    print("Código: $_codigo");
    print("Percentual: $_percentual%");
    print("Ativo: $_ativo");
  }
}

void main() {
 
  CupomDesconto cupom = CupomDesconto("PROMO10", 10, true);

  cupom.percentual = 20;
  cupom.codigo = "PROMO20";

  double valor = 200.0;
  double desconto = cupom.calcularDesconto(valor);
  print("Valor original: R\$ $valor");
  print("Desconto: R\$ $desconto");
  print("Valor final: R\$ ${valor - desconto}");

  cupom.exibirCupom();
}
