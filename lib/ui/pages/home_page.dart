part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  bool isFetchMore = false;
  List<Story> stories = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    fetchStories();
  }

  @override
  void dispose() {
    resetWidget();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: scrollController,
      scrollDirection: Axis.vertical,
      children: [
        Column(
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
                        'title'.tr,
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
            Container(
              margin: const EdgeInsets.only(bottom: defaultMargin + 20),
              padding: const EdgeInsets.symmetric(
                  horizontal: defaultMargin, vertical: defaultMargin),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Skeleton(height: 300, width: 344,),
                  //   ],
                  // ),
                  // CardDetail(),
                  BlocBuilder<StoryCubit, StoryState>(builder: (_, state) {
                    if (state is StoryLoadedSuccess) {
                      List<Story> stories = state.props.map((obj) {
                        if (obj is Story) {
                          return obj;
                        } else {
                          throw ArgumentError('Object is not a Story');
                        }
                      }).toList();
                      return Column(
                        children: stories
                            .map((items) => isFetchMore
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 300),
                                    child: const Skeleton(
                                      width: double.infinity,
                                      height: 300,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      Get.to(() => DetailPage(
                                          story:
                                              stories[stories.indexOf(items)]));
                                    },
                                    child: CardStory(
                                        story: stories[stories.indexOf(items)]),
                                  ))
                            .toList(),
                      );
                    } else {
                      return Center(
                          child: state is StoryInitial
                              ? loadingIndicator
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                      Text(
                                        'title_error'.tr,
                                        style: blackFontStyle16,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'subtitle_error'.tr,
                                        style: greyFontStyle,
                                        textAlign: TextAlign.center,
                                      )
                                    ]));
                    }
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )
      ],
    );
  }

  void fetchStories() {
    context.read<StoryCubit>().getStories();
  }

  void _scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      setState(() {
        isFetchMore = true;
      });
      fetchStories();
      setState(() {
        isFetchMore = false;
      });
    }
    // log("[${DateTime.now()}] Scroll called");
  }

  void resetWidget() {
    scrollController.removeListener(_scrollListener);
    stories = [];
  }
}
