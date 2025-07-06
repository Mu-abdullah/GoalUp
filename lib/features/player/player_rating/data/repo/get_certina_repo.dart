// import 'package:dartz/dartz.dart';

// import '../../../../../core/error/custom_errors.dart';
// import '../../../../../core/language/lang_keys.dart';
// import '../../../../../core/services/graph_ql/graph_ql.dart';
// import '../../../../../core/services/supabase/backend_points.dart';
// import '../model/certina_model.dart';

// class GetCertinaRepo {
//   GraphQLService graphQLService = GraphQLService();
//   Future<Either<CustomError, List<CriteriaModel>>> getCertina() async {
//     try {
//       var response = await graphQLService.fetchCollection(
//         collection: BackendPoint.criteria,
//         fields: ['id', 'category{id}', 'name', 'average', 'max'],
//         fromJson: CriteriaModel.fromJson,
//       );

//       return Right(response);
//     } catch (e) {
//       return Left(CustomError(LangKeys.somethingWentWrong));
//     }
//   }
// }
