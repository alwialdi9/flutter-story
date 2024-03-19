part of 'pages.dart';

class PostStoryPages extends StatefulWidget {
  const PostStoryPages({super.key});

  @override
  State<PostStoryPages> createState() => _PostStoryPagesState();
}

class _PostStoryPagesState extends State<PostStoryPages> {
  TextEditingController descController = TextEditingController();
  bool isUpload = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
                      style: blackFontStyle22.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'title_post'.tr,
                      style:
                          greyFontStyle.copyWith(fontWeight: FontWeight.w300),
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
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, style: BorderStyle.solid),
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: context.watch<ImageCubit>().imagePath == null
                    ? const Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.upload_rounded, size: 150),
                      )
                    : _showImage(),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: 10),
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
                      hintText: "Description"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => _onGalleryView(),
                      child: const Text('Gallery')),
                  ElevatedButton(
                      onPressed: () => _onCameraView(),
                      child: const Text('Camera'))
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
            ],
          )),
        ],
      ),
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

    var uploadStory =
        await StoryServices.postImage(newBytes, fileName, descController.text);

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
      Get.to(const MainPage());
    }
    setState(() {
      isUpload = false;
    });
  }
}
