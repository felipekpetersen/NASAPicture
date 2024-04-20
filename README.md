# nasa_pictures

## About
Simple Flutter app that shows a list of Nasa Pictures. 

Flutter 3.19.5 • channel stable • https://github.com/flutter/flutter.git

Tools • Dart 3.3.3 • DevTools 2.31.1



## Architecture 
<img width="754" alt="Captura de Tela 2024-04-19 às 20 46 12" src="https://github.com/felipekpetersen/NASAPicture/assets/31223287/35286142-d908-40c7-b137-8e6b60378529">

### Layers
- Data Source: Retrieve data from local or remote Data base. In our case, https://api.nasa.gov
- Repository: Handle data so it can be use by our app.
- Use Case: Connects to repository for handling interactions with data.
- View Model: Builds and provide data to our view. The Provider (`ChangeNotifier`) goes here.
- View: Shows data from View Model

## Packages used
- [Dio](https://pub.dev/packages/dio)
- [Modular](https://pub.dev/packages/flutter_modular): Dependecy Injection and Navigation
- [Hive](https://pub.dev/packages/hive): Local data source
- [Provider](https://pub.dev/packages/provider)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [shared_preferences](https://pub.dev/packages/shared_preferences)

Note: SharedPreferences is not a good option for security reasons. We should use flutter_secure_storage instead. But, as this is a training project and does not contain sensitive data, I chose SharedPreferences over flutter_secure_storage because flutter_secure_storage can have some problems depending on the configs while running on emulators/simulators ([like this one](https://github.com/mogol/flutter_secure_storage/issues/391)). The logical behing using SharedPreferences and flutter_secure_storage is exactly the same, with few adaptations on code. 
