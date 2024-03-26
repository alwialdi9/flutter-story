part of 'pages.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool enableID = false;

  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  void _storeEnableId(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('enableID', value);
  }

  void _getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      enableID = prefs.getBool('enableID') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      title: 'Settings',
      subtitle: '',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'title_setting'.tr,
                      style: blackFontStyle16.copyWith(
                          fontWeight: FontWeight.w300),
                    ),
                    Text('subtitle_setting'.tr,
                        style:
                            greyFontStyle.copyWith(fontWeight: FontWeight.w300))
                  ],
                ),
                Switch.adaptive(
                    value: enableID,
                    activeColor: Colors.lightBlue,
                    onChanged: (value) async {
                      setState(() {
                        _storeEnableId(value);
                        enableID = value;
                        if (value) {
                          Get.updateLocale(const Locale('id', 'ID'));
                        } else {
                          Get.updateLocale(const Locale('en', 'US'));
                        }
                      });
                    }),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    UserService().setLogin(false);
                    Get.rootDelegate.offNamed('/signin');
                  },
                  child: Text('logout'.tr)),
            )
          ],
        ),
      ),
    );
  }
}
