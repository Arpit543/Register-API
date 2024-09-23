import 'package:bloc_api/core/Model/addressModel/country_data.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  CountryBloc({required AuthRepo authRepo, required ApiService apiService})
      : _authRepo = authRepo,
        _apiService = apiService,
        super(CountryInitial()) {
    on<UserCountryEvent>(_getCountry);
  }

  _getCountry(UserCountryEvent event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    await _authRepo.getCountry(
      apiService: _apiService,
      url: event.url,
      success: (countryData) => emit(CountrySuccess(country: countryData)),
      fail: (commonModel) => emit(CountryFailed(error: commonModel.message!)),
    );
  }
}
