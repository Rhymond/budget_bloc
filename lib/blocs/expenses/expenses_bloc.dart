import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/blocs/expenses/expenses.dart';
import 'package:todo/models/models.dart';
import 'package:todo/repositories/repositories.dart';

List<Expense> listOfExpenses = [
  Expense("expense 4", category: 'other', amount: 120),
  Expense("expense 2", category: 'other', amount: 73),
  Expense("expense 3", category: 'misc', amount: 30),
];

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final ExpensesRepository expensesRepository;

  ExpensesBloc({@required this.expensesRepository});

  @override
  ExpensesState get initialState => ExpensesLoading();

  @override
  Stream<ExpensesState> mapEventToState(ExpensesEvent event) async* {
    if (event is LoadExpenses) {
      yield* _mapLoadExpensesToState();
    } else if (event is AddExpense) {
      yield* _mapAddExpenseToState(event);
    } else if (event is UpdateExpense) {
      yield* _mapUpdateExpenseToState(event);
    } else if (event is DeleteExpense) {
      yield* _mapDeleteExpenseToState(event);
    }
  }

  Stream<ExpensesState> _mapLoadExpensesToState() async* {
    try {
      yield ExpensesLoading();
      final expenses = await this.expensesRepository.loadExpenses();
      yield ExpensesLoaded(expenses.map(Expense.fromEntity).toList());
    } catch (e) {
      print('Something really unknown: $e');
      yield ExpensesNotLoaded();
    }
  }

  Stream<ExpensesState> _mapAddExpenseToState(AddExpense event) async* {
    if (currentState is ExpensesLoaded) {
      final List<Expense> updatedExpenses =
          List.from((currentState as ExpensesLoaded).expenses)
            ..add(event.expense);
      _saveExpenses(updatedExpenses);
      yield ExpensesLoaded(updatedExpenses);
    }
  }

  Stream<ExpensesState> _mapUpdateExpenseToState(UpdateExpense event) async* {
    if (currentState is ExpensesLoaded) {
      final List<Expense> updatedExpenses =
          (currentState as ExpensesLoaded).expenses.map((expense) {
        return expense.id == event.expense.id ? event.expense : expense;
      }).toList();
      _saveExpenses(updatedExpenses);
      yield ExpensesLoaded(updatedExpenses);
    }
  }

  Stream<ExpensesState> _mapDeleteExpenseToState(DeleteExpense event) async* {
    if (currentState is ExpensesLoaded) {
      final updatedExpenses = (currentState as ExpensesLoaded)
          .expenses
          .where((expense) => expense.id != event.expense.id)
          .toList();
      _saveExpenses(updatedExpenses);
      yield ExpensesLoaded(updatedExpenses);
    }
  }

  Future _saveExpenses(List<Expense> expenses) {
    return expensesRepository.saveExpenses(
      expenses.map((expense) => expense.toEntity()).toList(),
    );
  }
}
