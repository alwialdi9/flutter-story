part of 'pages.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  TextEditingController descController = TextEditingController();
  bool isUpload = false;
  Map<String, double>? pickLocation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
          height: 80,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ASL",
                    style:
                        blackFontStyle22.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'title_post'.tr,
                    style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.person)],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                      border: Border.all(width: 0, color: Colors.white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(25))),
                  child: context.watch<ImageCubit>().imagePath == null
                      ? const Align(
                          alignment: Alignment.center,
                          child: Icon(Icons.upload_rounded, size: 40),
                        )
                      : _showImage(),
                ),
                Container(
                  width: 230,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black)),
                  child: TextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: greyFontStyle,
                        hintText: 'hint_desc'.tr),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (pickLocation != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${'coordinate'.tr} : ${pickLocation!['latitude']}, ${pickLocation!['longitude']}",
                  style: greyFontStyle,
                ),
              ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _onGalleryView(),
                    child: Text('btn_gallery'.tr)),
                ElevatedButton(
                    onPressed: () => _onCameraView(),
                    child: Text('btn_camera'.tr)),
                ElevatedButton(
                    onPressed: () async {
                      if (FlavorConfig.instance.flavor.name == 'free') {
                        Get.snackbar("", "",
                            backgroundColor: "D9435E".toColor(),
                            icon: Icon(
                              MdiIcons.closeCircleOutline,
                              color: Colors.white,
                            ),
                            titleText: Text(
                              'select_location_cannot_used'.tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            messageText: Text('select_location_cannot_used_desc'.tr,
                                style:
                                    GoogleFonts.poppins(color: Colors.white)));
                        return;
                      }
                      final Location location = Location();
                      late bool serviceEnabled;
                      late PermissionStatus permissionGranted;
                      late LocationData locationData;

                      serviceEnabled = await location.serviceEnabled();
                      if (!serviceEnabled) {
                        serviceEnabled = await location.requestService();
                        if (!serviceEnabled) {
                          log("Location services is not available");
                          Get.snackbar("", "",
                              backgroundColor: Colors.red,
                              icon: Icon(
                                MdiIcons.closeCircleOutline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                'location_service'.tr,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text('location_not_available'.tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white)));
                          return;
                        }
                      }

                      permissionGranted = await location.hasPermission();
                      if (permissionGranted == PermissionStatus.denied) {
                        permissionGranted = await location.requestPermission();
                        if (permissionGranted != PermissionStatus.granted) {
                          log("Location permission is denied");
                          Get.snackbar("", "",
                              backgroundColor: Colors.red,
                              icon: Icon(
                                MdiIcons.closeCircleOutline,
                                color: Colors.white,
                              ),
                              titleText: Text(
                                'location_service'.tr,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              messageText: Text('location_permission_denied'.tr,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white)));
                          return;
                        }
                      }

                      locationData = await location.getLocation();
                      final dataParams = {
                        'latitude': '${locationData.latitude!}',
                        'longitude': '${locationData.longitude!}',
                        'isPickLocation': 'true'
                      };
                      var result = await Get.rootDelegate
                          .toNamed('/maps', parameters: dataParams);
                      setState(() {
                        pickLocation = result;
                      });
                    },
                    child: Text('pick_location'.tr))
              ],
            ),
            Center(
              child: isUpload
                  ? loadingIndicator
                  : ElevatedButton(
                      onPressed: () async {
                        _onUpload(context);
                      },
                      child: Text('post_btn'.tr)),
            )
          ]),
        )
      ]),
    );
  }

  _onGalleryView() async {
    final stateImage = context.read<ImageCubit>();

    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    final isLinux = defaultTargetPlatform == TargetPlatform.linux;
    if (isMacOS || isLinux) return;
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);
    if (pickedFile != null) {
      stateImage.setImageFile(pickedFile);
      stateImage.setImagePath(pickedFile.path);
    }
  }

  _onCameraView() async {
    final stateCamera = context.read<ImageCubit>();
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );

    final isAndroid = defaultTargetPlatform == TargetPlatform.android;
    final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
    final isNotMobile = !(isAndroid || isiOS);
    if (isNotMobile) return;

    if (pickedFile != null) {
      stateCamera.setImageFile(pickedFile);
      stateCamera.setImagePath(pickedFile.path);
    }
  }

  Widget _showImage() {
    final imagePath = context.read<ImageCubit>().imagePath;
    return kIsWeb
        ? Image.network(
            imagePath.toString(),
            fit: BoxFit.contain,
          )
        : Image.file(
            File(imagePath.toString()),
            fit: BoxFit.contain,
          );
  }

  void _onUpload(BuildContext context) async {
    setState(() {
      isUpload = true;
    });
    final uploadProvider = context.read<ImageCubit>();
    final imagePath = uploadProvider.imagePath;
    final imageFile = uploadProvider.imageFile;

    if (imagePath == null || imageFile == null) return;

    final fileName = imageFile.name;
    final bytes = await imageFile.readAsBytes();

    final newBytes = await StoryServices.compressImage(bytes);

    var uploadStory = await StoryServices.postImage(
        newBytes, fileName, descController.text, pickLocation!);

    if (uploadStory.error!) {
      Get.snackbar("", "",
          backgroundColor: "D9435E".toColor(),
          icon: Icon(
            MdiIcons.closeCircleOutline,
            color: Colors.white,
          ),
          titleText: Text(
            "Upload Story Failed",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          messageText: Text(uploadStory.message!,
              style: GoogleFonts.poppins(color: Colors.white)));
    } else {
      Get.snackbar("", "",
          backgroundColor: Colors.green,
          icon: Icon(
            MdiIcons.closeCircleOutline,
            color: Colors.white,
          ),
          titleText: Text(
            "Post Story Success",
            style: GoogleFonts.poppins(
                color: Colors.white, fontWeight: FontWeight.w600),
          ),
          messageText: Text(uploadStory.message!,
              style: GoogleFonts.poppins(color: Colors.white)));
      setState(() {
        context.read<StoryCubit>().resetStories();
        context.read<StoryCubit>().getStories();
      });
      Get.to(const MainPage());
    }
    setState(() {
      isUpload = false;
    });
  }
}
