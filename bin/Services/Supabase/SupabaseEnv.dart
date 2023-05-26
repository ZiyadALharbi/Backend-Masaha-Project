// ignore_for_file: file_names

import 'package:supabase/supabase.dart';

class SupabaseEnv {
  final _url = "https://bqdcvcvvsdjzkwgjcroh.supabase.co";
  final _key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJxZGN2Y3Z2c2Rqemt3Z2pjcm9oIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NTEwODk3MSwiZXhwIjoyMDAwNjg0OTcxfQ.z439zB0KeT3jUatZAWDLa0_WdEy9gd8_Y1Frky_QtTU";
  final _jwt =
      "CmNqRWbeFrcbaCjffNeJ9JXtAdOtDXgPWzqxqtf6nXEiAw3igpbA8pxm4sCuXZ7WIBfDH2Wx35DJXjFKfQJAIQ==";

  get getJWT {
    return _jwt;
  }

  SupabaseClient get supabase {
    final supabase = SupabaseClient(_url, _key);

    return supabase;
  }
}
