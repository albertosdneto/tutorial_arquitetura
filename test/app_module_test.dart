import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tutorial_arquitetura/app_modules.dart';
import 'package:tutorial_arquitetura/modules/search/domain/entities/result_search.dart';
import 'package:tutorial_arquitetura/modules/search/domain/usecases/search_by_text.dart';

import 'modules/search/utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  test("deve recuperar o usecase sem erro", () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test("deve trazer uma lista de ResultSearch", () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(githubResult),
          statusCode: 200,
        ));

    final usecase = Modular.get<SearchByText>();

    final result = await usecase("alberto");

    expect(result | null, isA<List<ResultSearch>>());
  });
}
