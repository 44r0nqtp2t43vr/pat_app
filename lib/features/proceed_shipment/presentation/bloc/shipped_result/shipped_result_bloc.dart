import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pat_app/features/proceed_shipment/domain/usecases/get_shipped_result.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_event.dart';
import 'package:pat_app/features/proceed_shipment/presentation/bloc/shipped_result/shipped_result_state.dart';

class ShippedResultBloc extends Bloc<ShippedResultEvent, ShippedResultState> {
  final GetShippedResultUseCase _getShippedResultUseCase;

  ShippedResultBloc(
    this._getShippedResultUseCase,
  ) : super(const ShippedResultLoading()) {
    on<GetShippedResultEvent>(onGetShippedResult);
  }

  void onGetShippedResult(GetShippedResultEvent event, Emitter<ShippedResultState> emit) async {
    emit(const ShippedResultLoading());

    try {
      final shippedResult = await _getShippedResultUseCase(params: event.getShippedResultData);
      emit(ShippedResultDone(shippedResult: shippedResult));
    } catch (e) {
      emit(ShippedResultError(exception: e));
    }
  }
}
