import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo/blocs/tab/tab.dart';
import 'package:todo/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.expenses;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    }
  }
}