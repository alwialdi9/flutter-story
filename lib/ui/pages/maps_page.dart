part of 'pages.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final locationStory = LatLng(
      double.parse(Get.rootDelegate.parameters['latitude']!),
      double.parse(Get.rootDelegate.parameters['longitude']!));
  late GoogleMapController mapController;
  final Set<Marker> markers = {};
  geo.Placemark? placemark;
  bool isPickLocation =
      bool.parse(Get.rootDelegate.parameters['isPickLocation']!);
  Map<String, double> pickLocation = {
    'latitude': double.parse(Get.rootDelegate.parameters['latitude']!),
    'longitude': double.parse(Get.rootDelegate.parameters['longitude']!)
  };

  @override
  void initState() {
    super.initState();
    _defineLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Maps',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: mainColor,
          leading: IconButton(
              iconSize: 30,
              onPressed: () => isPickLocation
                  ? Get.rootDelegate.popRoute()
                  : Get.rootDelegate.offNamed('/detail_story'),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Center(
          child: BackButtonListener(
            onBackButtonPressed: () {
              if (isPickLocation) {
                return Get.rootDelegate.popRoute();
              } else {
                return Get.rootDelegate.offNamed('/detail_story');
              }
            },
            child: Stack(children: [
              GoogleMap(
                markers: markers,
                compassEnabled: true,
                tiltGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: locationStory,
                  zoom: 18,
                ),
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                myLocationButtonEnabled: false,
                myLocationEnabled: isPickLocation,
                onMapCreated: (controller) {
                  setState(() {
                    mapController = controller;
                  });
                },
                onTap: (LatLng latLng) {
                  if (isPickLocation) {
                    onTapGoogleMap(latLng);
                  }
                },
              ),
              if (isPickLocation)
                Positioned(
                    top: 16,
                    right: 16,
                    child: FloatingActionButton(
                        child: const Icon(Icons.my_location),
                        onPressed: () {
                          onMyLocation();
                        })),
              if (placemark == null)
                const SizedBox()
              else
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Placemark(
                    placemark: placemark!,
                    latLng: pickLocation, isPickLocation: isPickLocation,
                    
                  ),
                ),
            ]),
          ),
        ));
  }

  void defineMarker(LatLng latLng) {
    final marker = Marker(
      markerId: const MarkerId("source"),
      position: latLng,
    );
    setState(() {
      markers.clear();
      markers.add(marker);
    });
  }

  void _defineLocation() {
    final marker = Marker(
        markerId: const MarkerId('dicoding'),
        position: locationStory,
        onTap: () async {
          mapController.animateCamera(
            CameraUpdate.newLatLngZoom(locationStory, 18),
          );
          final info = await geo.placemarkFromCoordinates(
              locationStory.latitude, locationStory.longitude);
          final place = info[0];
          if (isPickLocation) {
            defineMarker(locationStory);
          }
          setState(() {
            placemark = placemark == null ? place : null;
            pickLocation['latitude'] = locationStory.latitude;
            pickLocation['longitude'] = locationStory.longitude;
          });
        });
    markers.add(marker);
  }

  void onTapGoogleMap(LatLng latLng) async {
    defineMarker(latLng);
    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
    try {
      final info =
          await geo.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      final place = info[0];
      setState(() {
        placemark = place;
        pickLocation['latitude'] = latLng.latitude;
        pickLocation['longitude'] = latLng.longitude;
      });
    } catch (e) {
      log("[${DateTime.now()}] $e",
          error: "There is error fetch location", name: 'Maps Widget');
    }
  }

  void onMyLocation() async {
    final Location location = Location();
    late bool serviceEnabled;
    late PermissionStatus permissionGranted;
    late LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print("Location services is not available");
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission is denied");
        return;
      }
    }

    locationData = await location.getLocation();
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);
    defineMarker(latLng);
    mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }
}
