import 'package:envied/envied.dart';

part 'env.g.dart';

/// Project environmental variables stored in [.env] file.
@Envied(path: '.env')
abstract class Env {
  /// The url of the Supabase project instance.
  @EnviedField(varName: 'AMPLITUDE_KEY')
  static const String amplitudeKey = _Env.amplitudeKey;

  /// The url of the Supabase project instance.
  @EnviedField(varName: 'SUPABASE_URL')
  static const String supabaseUrl = _Env.supabaseUrl;

  /// The anonymous key of the Supabase project instance.
  @EnviedField(varName: 'SUPABASE_ANON_KEY')
  static const String supabaseAnonKey = _Env.supabaseAnonKey;
}
