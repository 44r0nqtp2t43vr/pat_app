import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/features/input_shipment/domain/usecases/get_rcs_list.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_event.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_state.dart';

class RCsListBloc extends Bloc<RCsListEvent, RCsListState> {
  final GetRCsListUseCase _getRCsListUseCase;

  RCsListBloc(
    this._getRCsListUseCase,
  ) : super(const RCsListLoading()) {
    on<GetRCsListEvent>(onGetRCsList);
  }

  void onGetRCsList(GetRCsListEvent event, Emitter<RCsListState> emit) async {
    emit(const RCsListLoading());

    try {
      final rcsList = await _getRCsListUseCase();
      emit(RCsListDone(rcsList: rcsList));
    } catch (e) {
      emit(RCsListError(exception: e));
    }
  }
}
