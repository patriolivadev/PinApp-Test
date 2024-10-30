// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:pinapp/core/services/dependencies_service.dart' as _i67;
import 'package:pinapp/core/services/http_service.dart' as _i1068;
import 'package:pinapp/features/comment/data/data_sources/comment_remote_data_source.dart'
    as _i107;
import 'package:pinapp/features/comment/data/repositories/comment_respository.dart'
    as _i291;
import 'package:pinapp/features/comment/domain/repositories/comment_repository_base.dart'
    as _i550;
import 'package:pinapp/features/comment/domain/use_cases/get_comment_by_id_use_case.dart'
    as _i283;
import 'package:pinapp/features/post/data/data_sources/post_remote_data_source.dart'
    as _i89;
import 'package:pinapp/features/post/data/repositories/post_respository.dart'
    as _i63;
import 'package:pinapp/features/post/domain/repositories/post_repository_base.dart'
    as _i829;
import 'package:pinapp/features/post/domain/use_cases/get_post_use_case.dart'
    as _i230;
import 'package:pinapp/features/post/presentation/manager/post_bloc.dart'
    as _i207;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectableModule = _$InjectableModule();
    gh.lazySingleton<_i519.Client>(() => injectableModule.client);
    gh.factory<_i1068.HttpServiceBase>(
        () => _i1068.HttpService(http: gh<_i519.Client>()));
    gh.factory<_i107.CommentRemoteDataSourceBase>(() =>
        _i107.CommentRemoteDataSource(http: gh<_i1068.HttpServiceBase>()));
    gh.factory<_i550.CommentRepositoryBase>(() => _i291.CommentRepository(
        remote: gh<_i107.CommentRemoteDataSourceBase>()));
    gh.factory<_i283.GetCommentByIdUseCase>(() => _i283.GetCommentByIdUseCase(
        commentRepositoryBase: gh<_i550.CommentRepositoryBase>()));
    gh.factory<_i89.PostRemoteDataSourceBase>(
        () => _i89.PostRemoteDataSource(http: gh<_i1068.HttpServiceBase>()));
    gh.factory<_i829.PostRepositoryBase>(
        () => _i63.PostRepository(remote: gh<_i89.PostRemoteDataSourceBase>()));
    gh.factory<_i230.GetPostUseCase>(() => _i230.GetPostUseCase(
        postRepositoryBase: gh<_i829.PostRepositoryBase>()));
    gh.factory<_i207.PostBloc>(
        () => _i207.PostBloc(getPostUseCase: gh<_i230.GetPostUseCase>()));
    return this;
  }
}

class _$InjectableModule extends _i67.InjectableModule {}
