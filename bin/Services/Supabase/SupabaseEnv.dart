// ignore_for_file: file_names

import 'package:supabase/supabase.dart';

class SupabaseEnv {
<<<<<<< HEAD
  final _url = "https://bqdcvcvvsdjzkwgjcroh.supabase.co";
  final _key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJxZGN2Y3Z2c2Rqemt3Z2pjcm9oIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NTEwODk3MSwiZXhwIjoyMDAwNjg0OTcxfQ.z439zB0KeT3jUatZAWDLa0_WdEy9gd8_Y1Frky_QtTU";
  final _jwt =
      "CmNqRWbeFrcbaCjffNeJ9JXtAdOtDXgPWzqxqtf6nXEiAw3igpbA8pxm4sCuXZ7WIBfDH2Wx35DJXjFKfQJAIQ==";
=======
  final _url = "https://qjjzsudjbsudodsamcpw.supabase.co";
  final _key =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFqanpzdWRqYnN1ZG9kc2FtY3B3Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4NDIzMDU5NiwiZXhwIjoxOTk5ODA2NTk2fQ.ykuwAxviz5vqDmBwaGZOB-B8LDLSuk62ZtW3yreNyXU";
  final _jwt =
      "X8HJoWYoDvfs1xFF65RpSlL8Tz3IT2tSnjY4Wdjckf5Zmr1QTgHBpxnz5w0dxK54bMMnCjXbku6PPwaepuzINw==";
>>>>>>> 380537d9ec31972e6d8a3692a592578032f11bb8

  get getJWT {
    return _jwt;
  }

  SupabaseClient get supabase {
    final supabase = SupabaseClient(_url, _key);

    return supabase;
  }
}
