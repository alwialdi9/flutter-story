part of 'widgets.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({super.key, required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                        borderRadius: BorderRadius.all(Radius.circular(50)),
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
                      Text("${story.lat}, ${story.lon}", style: greyFontStyle)
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
                borderRadius: const BorderRadius.all(Radius.circular(15))),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              text: story.name,
              style: blackFontStyle14.copyWith(fontWeight: FontWeight.w700),
              children: [
                TextSpan(
                  text: story.description,
                  style: blackFontStyle14.copyWith(fontWeight: FontWeight.w300),
                )
              ]
            )
          ),
          const SizedBox(height: 10),
          Text(
            story.createdAt, 
            style: greyFontStyle.copyWith(fontSize: 12)
          )
        ],
      ),
    );
  }
}