import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m_hike/app.dart';
import 'package:m_hike/common/local/database.dart';
import 'package:m_hike/di/di.dart';
import 'package:m_hike/presentation/screens/hike/create_update/bloc/create_update_bloc.dart';
import 'package:m_hike/presentation/screens/hike/create_update/bloc/form/create_update_form_bloc.dart';
import 'package:m_hike/presentation/screens/home/bloc/home_bloc.dart';

import 'presentation/screens/hike/detail/bloc/detail_hike_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configInjectable();
  getIt<Database>().init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => getIt<CreateUpdateFormBloc>()),
    BlocProvider(create: (_) => getIt<CreateUpdateHikeBloc>()),
    BlocProvider(create: (_) => getIt<DetailHikeBloc>()),
    BlocProvider(create: (_) => getIt<HomeBloc>()),
  ], child: const Application()));
}
