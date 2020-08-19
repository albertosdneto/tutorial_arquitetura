import 'package:dartz/dartz.dart';
import 'package:tutorial_arquitetura/modules/search/domain/entities/result_search.dart';
import 'package:tutorial_arquitetura/modules/search/domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
