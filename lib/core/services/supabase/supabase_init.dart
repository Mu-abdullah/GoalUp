import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseInit {
  static final String supabaseUrl = '${dotenv.env['SUPABASE_URL']}';
  static final String supabaseAnonKey = '${dotenv.env['API_KEY']}';

  Future<void> initSupabase() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
}
