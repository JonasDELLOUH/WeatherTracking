import 'package:get/get.dart';
import 'package:weather_tracking1/services/weather_service.dart';

import '../models/location_data.dart';
import '../models/weather_data.dart';

class HomeController extends GetxController {
  // By using Get.find(), Get will find the object in the binding class and give it to you.
  final WeatherServices _weatherServices = Get.find();

  // A nullable Rx instance of LocationData. Initial value is null.
  Rxn<LocationData> locationData = Rxn();

  // A nullable Rx instance of WeatherData. Initial value is null.
  Rxn<WeatherData> weatherData = Rxn();

  // A reactive String to display informative text. default is '...'.
  RxString infoText = '...'.obs;

  // This will be retrieved by the UI for a pretty display.
  String get address =>
      "${locationData.value?.regionName}, ${locationData.value?.country}";

  // Preparing the temperature String to show in the Widget
  String get temperature => "${weatherData.value?.temp}";

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCurrentLocation();
    // Order is important! We need to wait for the location before fetching the temperature.
    await getTemperatureForCurrentLocation();
  }

  getCurrentLocation() async {
    LocationData? location = await _weatherServices.getCurrentLocation();
    print(location?.regionName);
    // We assign the response from our API call to our Rx object.
    locationData.value = location;
  }

  getTemperatureForCurrentLocation() async {
    // TODO add the logic to fetch temperature
    // Verify if location is not null first
    if (locationData.value != null) {
      // We assign the response from our API call to our Rx object.
      weatherData.value =
          await _weatherServices.getWeatherForLocation(locationData.value!);
      _getInfoText(weatherData.value?.temp); // make the call here
    }
  }

  _getInfoText(int? temperature) {
    if (temperature == null) {
      infoText.value = "unknown";
    } else if (temperature <= 0) {
      infoText.value =
          "make sure to dress thick cloths! It's freezing out there!";
    } else if (temperature <= 15) {
      infoText.value = "wear a jacket, don't catch a cold!";
    } else {
      infoText.value = "enjoy the weather, it's nice!";
    }
  }
}
