import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tutorial_arquitetura/modules/search/domain/entities/result_search.dart';
import 'package:tutorial_arquitetura/modules/search/domain/errors/errors.dart';
import 'package:tutorial_arquitetura/modules/search/domain/usecases/search_by_text.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/search_bloc.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/states/states.dart';

class SearchByTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchByTextMock();
  final bloc = SearchBloc(usecase);

  test("deve retornar os estados na ordem correta", () {
    when(usecase.call(any)).thenAnswer((_) async => Right(<ResultSearch>[]));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchSuccess>(),
        ]));

    bloc.add("albertosdneto");
  });

  test("deve retornar erro", () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));

    expect(
        bloc,
        emitsInOrder([
          isA<SearchLoading>(),
          isA<SearchError>(),
        ]));
    bloc.add("alberto");
  });
}
