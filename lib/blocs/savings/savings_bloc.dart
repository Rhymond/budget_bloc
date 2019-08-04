import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/blocs/savings/savings.dart';
import 'package:todo/models/models.dart';
import 'package:todo/repositories/repositories.dart';

class SavingsBloc extends Bloc<SavingsEvent, SavingsState> {
  final SavingsRepository savingsRepository;

  SavingsBloc({@required this.savingsRepository});

  @override
  SavingsState get initialState => SavingsLoading();

  @override
  Stream<SavingsState> mapEventToState(SavingsEvent event) async* {
    if (event is LoadSavings) {
      yield* _mapLoadSavingsToState();
    } else if (event is UpdateSaving) {
      yield* _mapUpdateSavingToState(event);
    }
  }

  Stream<SavingsState> _mapLoadSavingsToState() async* {
    try {
      yield SavingsLoading();
      final savings = await this.savingsRepository.loadSavings();
      yield SavingsLoaded(Savings.fromEntity(savings));
    } catch (e) {
      print('Something really unknown: $e');
      yield SavingsNotLoaded();
    }
  }

  Stream<SavingsState> _mapUpdateSavingToState(UpdateSaving event) async* {
    if (currentState is SavingsLoaded) {
      _saveSavings(event.saving);
      yield SavingsLoaded(event.saving);
    }
  }

  Future _saveSavings(Savings savings) {
    return savingsRepository.saveSavings(savings.toEntity());
  }
}
