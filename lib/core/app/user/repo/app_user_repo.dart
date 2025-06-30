import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../services/shared_pref/pref_keys.dart';
import '../../../services/shared_pref/shared_pref.dart';

class AppUserRepo {
  void logout() async {
    await SharedPref.removeData(key: PrefKeys.academyId);  
    await SharedPref.removeData(key: PrefKeys.coachId);  
    await SharedPref.removeData(key: PrefKeys.remember);

    await Supabase.instance.client.auth.signOut();
  }
}
