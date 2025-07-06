// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// import '../../../data/model/certina_model.dart';
// import '../../../data/repo/get_certina_repo.dart';

// part 'get_certina_state.dart';

// class GetCertinaCubit extends Cubit<GetCertinaState> {
//   GetCertinaRepo getCertinaRepo = GetCertinaRepo();
//   GetCertinaCubit() : super(GetCertinaInitial());

//   Future<void> getCertina() async {
//     emit(GetCertinaLoading());
//     var result = await getCertinaRepo.getCertina();
//     result.fold(
//       (l) {
//         if (!isClosed) {
//           emit(GetCertinaError(l.message));
//         }
//       },
//       (r) {
//         if (!isClosed) {
//           emit(GetCertinaLoaded(r));
//         }
//       },
//     );
//   }
// }
