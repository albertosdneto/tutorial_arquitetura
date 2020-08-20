import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tutorial_arquitetura/modules/search/presenter/search/search_page.dart';

import 'app_widget.dart';
import 'modules/search/domain/usecases/search_by_text.dart';
import 'modules/search/external/datasources/github_datasource.dart';
import 'modules/search/infra/repositories/search_repository_impl.dart';
import 'modules/search/presenter/search/search_bloc.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => SearchRepositoryImpl(i())),
        Bind((i) => GithubDatasource(i())),
        Bind((i) => SearchByTextImpl(i())),
        Bind((i) => SearchBloc(i())),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<Router> get routers => [
        Router('/', child: (_, __) => SearchPage()),
      ];
}
