import 'package:injectable/injectable.dart';
import '../presentation/routes/app_router.dart';

@module
abstract class RegisterDependencies {
  final AppRouter appRouter = AppRouter();
}
