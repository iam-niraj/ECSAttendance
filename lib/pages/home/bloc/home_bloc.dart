import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:ecs_attendance/database/database.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required MongoDatabase database})
      : _database = database,
        super(const HomeState()) {
    on<LoadStudentsEvent>(_loadEvents);
  }

  final MongoDatabase _database;

  _loadEvents(LoadStudentsEvent event, Emitter<HomeState> emit) async {
    emit(state.copywith(
      status: () => HomeStatus.loading,
    ));
    final data = await _database.getStudent();
    emit(state.copywith(
      attendance: () => data,
      status: () => HomeStatus.loaded,
    ));
  }
}
