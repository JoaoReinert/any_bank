class NullAmountException implements Exception {
  @override
  String toString() => 'O valor não pode ser nulo';
}

class InsuficientAmountException implements Exception {
  @override
  String toString() => 'Saldo insuficiente';
}

class InvalidAmountException implements Exception {
  @override
  String toString() => 'Valor inválido';
}

enum AccountType { checkings, savings, investment }

class Account {
  final int id;
  final String nome;
  final String cpf;
  double balance;
  final AccountType accountType;

  Account({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.balance,
    this.accountType = AccountType.checkings,
  });

  void transfer(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }

    if (amount > balance) {
      throw InsuficientAmountException();
    }

    if (amount <= 0) {
      throw InvalidAmountException();
    }

    balance = balance - amount;
  }

  void applyInterest() {
    double interest = 0.01;

    if (AccountType.savings == accountType) {
      interest = 0.03;
    }

    if (AccountType.investment == accountType) {
      interest = 0.07;
    }

    balance += balance * interest;
  }
}
