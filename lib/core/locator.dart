import 'package:cgpa_calculator_1/ui/views/sgpa_view/sgpa_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(SGPAViewModel());
}
