import 'package:bloc_api/core/Model/addressModel/city_data.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final ApiService _apiService;
  final AuthRepo _authRepo;

  CityBloc({
    required ApiService apiService,
    required AuthRepo authRepo,
  })  : _apiService = apiService,
        _authRepo = authRepo,
        super(CityInitial()) {
    on<UserCityEvent>(onGetCityList);
  }

  onGetCityList(UserCityEvent event, Emitter<CityState> emit) async {
    emit(CityLoading());
    await _authRepo.getCityList(
      apiService: _apiService,
      url: event.url,
      state: event.stateId,
      success: (cityModel) => emit(CitySuccess(cityModel: cityModel)),
      fail: (commonModel) => emit(CityFailed(error: commonModel.message ?? "")),
    );
  }
}
