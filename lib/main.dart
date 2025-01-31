import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/bloc_observer.dart';
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://enakes-base-staging.peltops.com',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.ewogICJyb2xlIjogImFub24iLAogICJpc3MiOiAic3VwYWJhc2UiLAogICJpYXQiOiAxNzMwOTM0MDAwLAogICJleHAiOiAxODg4NzAwNDAwCn0.EP8axDBmHdO6MCtq-5xHaiRe31-OVaRR3GQObhBhJ74',
  );

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  await configureDependencies();
  runApp(App());
}
