part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SafeArea(
              child: Container(
            color: 'FAFAFC'.toColor(),
          )),
          SafeArea(
              child: PageView(
            controller: pageController,
            onPageChanged: (value) {
              setState(() {
                selectedPage = value;
              });
            },
            children: const [
              HomePage(),
              UploadPostPage(),
              SettingsPage(),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavbar(
                selectedIndex: selectedPage,
                onTap: (index) {
                  setState(() {
                    selectedPage = index;
                  });
                  pageController.jumpToPage(selectedPage);
                }),
          )
        ],
      ),
    );
  }

  void isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == '' || prefs.getString('token') == null) {
      Get.rootDelegate.offAndToNamed('/signin');
    }
  }
}
