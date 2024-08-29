import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/features/input_shipment/domain/usecases/get_shipped_items.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_event.dart';
import 'package:pat_app/features/input_shipment/presentation/bloc/rcs_list/rcs_list_state.dart';

class RCsListBloc extends Bloc<RCsListEvent, RCsListState> {
  final GetShippedItemsUseCase _getShippedItemsUseCase;

  RCsListBloc(
    this._getShippedItemsUseCase,
  ) : super(const RCsListLoading()) {
    on<GetShippedItemsEvent>(onGetShippedItems);
  }

  void onGetShippedItems(GetShippedItemsEvent event, Emitter<RCsListState> emit) async {
    emit(const RCsListLoading());

    try {
      final rcsList = await _getShippedItemsUseCase(params: event.getShippedItemsData);
      emit(RCsListDone(rcsList: rcsList));
    } catch (e) {
      emit(RCsListError(exception: e));
    }
  }
}
