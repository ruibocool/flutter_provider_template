import 'package:flutter_provider_template/core/models/ArticleModel.dart';
import 'package:flutter_provider_template/core/models/post.dart';
import 'package:flutter_provider_template/core/viewmodels/authentication_service.dart';
import 'package:flutter_provider_template/core/viewmodels/posts_service.dart';
import 'package:flutter_provider_template/ui/widgets/home_widget.dart';
import 'package:provider/provider.dart';

import 'core/models/cart.dart';
import 'core/models/catalog.dart';
import 'core/models/user.dart';
import 'core/services/api.dart';
import 'core/viewmodels/home_service.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
  ...homeIndexProvider
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api()),
  Provider(builder: (context) => CatalogModel()),
  // CartModel is implemented as a ChangeNotifier, which calls for the use
  // of ChangeNotifierProvider. Moreover, CartModel depends
  // on CatalogModel, so a ProxyProvider is needed.
  ChangeNotifierProxyProvider<CatalogModel, CartModel>(
      builder: (context, catalog, previousCart) =>
          CartModel(catalog, previousCart)),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<Api, AuthenticationService>(
    builder: (context, api, authenticationService) =>
        AuthenticationService(api: api),
  ),
  ProxyProvider<Api, PostsService>(
    builder: (context, api, postService) =>
        PostsService(api: api),
  ),
  ProxyProvider<Api, HomeService>(
    builder: (context, api, homeService) =>
        HomeService(api: api),
  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
    initialData: User(),
  ),
  StreamProvider<List<Post> >(
    builder: (context) =>Provider.of<PostsService>(context, listen: false).poster,
  ),
  StreamProvider<List<Article>>(
    builder: (context) =>Provider.of<HomeService>(context, listen: false).articleStream,
  )
];

List<SingleChildCloneableWidget> homeIndexProvider = [
  ChangeNotifierProvider.value(value: HomePageIndex())
];