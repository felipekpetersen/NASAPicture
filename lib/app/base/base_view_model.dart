import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
    bool _isLoading = false;
    bool get isLoading => _isLoading;

    setIsLoading(bool value) {
      _isLoading = value;
      notifyListeners();
    }

}