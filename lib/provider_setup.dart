import 'package:provider/provider.dart';
import 'package:flutter_provider_template/core/viewmodels/authentication_service.dart';

import 'core/models/user.dart';
import 'core/services/api.dart';

List<SingleChildCloneableWidget> providers = [
  //...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api())
];

List<SingleChildCloneableWidget> dependentServices = [
  /*ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  ),*/
  ChangeNotifierProvider.value(value: AuthenticationService(api: Api.getInstance()))
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
    initialData: User(),
  )
];
