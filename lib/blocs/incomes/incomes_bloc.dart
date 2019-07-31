import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/blocs/incomes/incomes.dart';
import 'package:todo/models/models.dart';
import 'package:todo/repositories/repositories.dart';

class IncomesBloc extends Bloc<IncomesEvent, IncomesState> {
  final IncomesRepository incomesRepository;

  IncomesBloc({@required this.incomesRepository});

  @override
  IncomesState get initialState => IncomesLoading();

  @override
  Stream<IncomesState> mapEventToState(IncomesEvent event) async* {
    if (event is LoadIncomes) {
      yield* _mapLoadIncomesToState();
    } else if (event is AddIncome) {
      yield* _mapAddIncomeToState(event);
    } else if (event is UpdateIncome) {
      yield* _mapUpdateIncomeToState(event);
    } else if (event is DeleteIncome) {
      yield* _mapDeleteIncomeToState(event);
    }
  }

  Stream<IncomesState> _mapLoadIncomesToState() async* {
    try {
      yield IncomesLoading();
      final incomes = await this.incomesRepository.loadIncomes();
      yield IncomesLoaded(incomes.map(Income.fromEntity).toList());
    } catch (e) {
      print('Something really unknown: $e');
      yield IncomesNotLoaded();
    }
  }

  Stream<IncomesState> _mapAddIncomeToState(AddIncome event) async* {
    if (currentState is IncomesLoaded) {
      final List<Income> updatedIncomes =
      List.from((currentState as IncomesLoaded).incomes)
        ..add(event.income);
      _saveIncomes(updatedIncomes);
      yield IncomesLoaded(updatedIncomes);
    }
  }

  Stream<IncomesState> _mapUpdateIncomeToState(UpdateIncome event) async* {
    if (currentState is IncomesLoaded) {
      final List<Income> updatedIncomes =
      (currentState as IncomesLoaded).incomes.map((income) {
        return income.id == event.income.id ? event.income : income;
      }).toList();
      _saveIncomes(updatedIncomes);
      yield IncomesLoaded(updatedIncomes);
    }
  }

  Stream<IncomesState> _mapDeleteIncomeToState(DeleteIncome event) async* {
    if (currentState is IncomesLoaded) {
      final updatedIncomes = (currentState as IncomesLoaded)
          .incomes
          .where((income) => income.id != event.income.id)
          .toList();
      _saveIncomes(updatedIncomes);
      yield IncomesLoaded(updatedIncomes);
    }
  }

  Future _saveIncomes(List<Income> incomes) {
    return incomesRepository.saveIncomes(
      incomes.map((income) => income.toEntity()).toList(),
    );
  }
}
