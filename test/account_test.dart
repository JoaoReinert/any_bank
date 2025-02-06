import 'package:anybank/main.dart';
import 'package:anybank/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;

  setUp(
    () {
      account = Account(
        id: 1,
        nome: 'João',
        cpf: '14028701910',
        balance: 100,
      );
    },
  );

  group(
    'Account Transfer Tests',
    () {
      test(
        'Teste de uma nova transferencia',
        () {
          account.transfer(50);

          expect(account.balance, 50);
        },
      );

      test(
        'Deve atualizar corretamente o valor do saldo quando a transferencia for validada',
        () {
          account.transfer(100);

          expect(account.balance, 0);
        },
      );

      test('Deve lançar uma exceção quando passar um valor inválido', () {
        expect(
            () => account.transfer(0), throwsA(isA<InvalidAmountException>()));

        expect(() => account.transfer(-100),
            throwsA(isA<InvalidAmountException>()));
      });

      test(
          'Deve lançar uma exceção quando o valor de transferencia for maior que o saldo disponível',
          () {
        expect(() => account.transfer(200),
            throwsA(isA<InsuficientAmountException>()));
      });

      test('Deve lançar uma exceção quando o valor da transferencia for nulo',
          () {
        expect(
            () => account.transfer(null), throwsA(isA<NullAmountException>()));
      });
    },
  );

  group(
    'Account interest rates',
    () {
      test(
        'Deve-se aplicar um juros de 1% quando o tipo de conta for conta corrente',
        () {
          account.applyInterest();
          expect(account.balance, 101);
        },
      );

      test(
        'Deve-se aplicar um juros de 3% quando o tipo de conta for conta poupança',
        () {
          final Account savingsAccount = Account(
              id: 2,
              nome: 'Reinert',
              cpf: '11111',
              balance: 100,
              accountType: AccountType.savings,
              );

          savingsAccount.applyInterest();
          expect(savingsAccount.balance, 103);
        },
      );
      test(
        'Deve-se aplicar um juros de 7% quando o tipo de conta for conta investment',
        () {
          final Account investmentAccount = Account(
              id: 3,
              nome: 'Claudio',
              cpf: '2222222',
              balance: 100,
              accountType: AccountType.investment);

          investmentAccount.applyInterest();
          expect(investmentAccount.balance, 107);
        },
      );
    },
  );
  
}
