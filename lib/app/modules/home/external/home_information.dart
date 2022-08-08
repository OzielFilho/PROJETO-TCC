import 'package:app/app/modules/home/infra/models/current_position_model.dart';

import 'package:app/app/modules/auth/infra/models/auth_result_model.dart';

import '../../../core/services/firebase_auth_service.dart';
import '../../../core/services/firestore_service.dart';
import '../../../core/services/locations_service.dart';
import '../infra/datasources/home_datasource.dart';

class HomeInformation implements HomeDatasource {
  final LocationsService locationsService;
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;

  HomeInformation(
      this.locationsService, this.authService, this.firestoreService);
  @override
  Future<CurrentPositionModel> getCurrentLocation() async {
    final location = await locationsService.getCurrentLocation();
    return CurrentPositionModel(location.latitude, location.longitude);
  }

  @override
  Future<AuthResultModel> getUserHome() async {
    final tokenId = await authService.getToken();
    final data = await firestoreService.getDocument('users', tokenId);
    return AuthResultModel.fromDocument(data);
  }

  @override
  Future<void> logoutUser() async {
    await authService.signOut();
  }
}
