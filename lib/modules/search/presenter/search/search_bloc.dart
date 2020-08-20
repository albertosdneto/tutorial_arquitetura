import 'package:bloc/bloc.dart';
import 'package:tutorial_arquitetura/modules/search/domain/usecases/search_by_text.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/states/states.dart';
import 'package:rxdart/rxdart.dart';


class SearchBloc extends Bloc<String, SearchState> {
  final SearchByText usecase;

  SearchBloc(this.usecase) : super(SearchStart());

  @override
  Stream<SearchState> mapEventToState(String searchText) async* {
    // Iniciamos passando o estado de SearchLoading
    yield SearchLoading();

    // Não há a necessidade de um if ou try catch para testar aqui
    // uma vez que o teste já foi feito nas outras camadas.
    final result = await usecase(searchText);

    // Finalizamos passando o resultado da busca com seu respectivo estado
    yield result.fold((l) => SearchError(l), (r) => SearchSuccess(r));
  }

  // Aqui é feito o tratamento para que não seja feita uma requisição
  // para a api sempre que algo é digitado no TextField.
  // Para usar debounceTime precisamos importar rxdart.
  @override
  Stream<Transition<String, SearchState>> transformEvents(
      Stream<String> events, transitionFn) {
    return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 800)), transitionFn);
  }
}
