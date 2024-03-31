part of 'pages.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Story story = Get.rootDelegate.arguments();

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
            margin: const EdgeInsets.only(top: defaultMargin),
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.blueAccent),
                            child: const Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(story.name,
                                  style: blackFontStyle14.copyWith(
                                      fontWeight: FontWeight.w600)),
                              Text(
                                  formatStringDate(story.createdAt,
                                      'EEEE, dd MMMM yyyy h:mm a'),
                                  style: greyFontStyle)
                            ],
                          )
                        ],
                      ),
                      Icon(Icons.more_vert_rounded, color: greyColor)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(story.photoUrl),
                            fit: BoxFit.cover),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "${story.name} ",
                          style: blackFontStyle14.copyWith(
                              fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                              text: story.description,
                              style: blackFontStyle14.copyWith(
                                  fontWeight: FontWeight.w300),
                            )
                          ])),
                  const SizedBox(height: 10),
                  story.lat != null || story.lon != null
                      ? Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Get.rootDelegate.toNamed('/maps', parameters: {
                                  'latitude': '${story.lat}',
                                  'longitude': '${story.lon}',
                                  'isPickLocation': 'false'
                                });
                              },
                              child: Text('detail_loc'.tr)),
                        )
                      : const Text('')
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
