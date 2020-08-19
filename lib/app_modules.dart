import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_widget.dart';
import 'modules/search/domain/usecases/search_by_text.dart';
import 'modules/search/external/datasources/github_datasource.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchByTextImpl(i())),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  // TODO: implement routers
  List<Router> get routers => throw UnimplementedError();
}
