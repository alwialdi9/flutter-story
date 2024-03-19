part of 'widgets.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar(
      {super.key, required this.selectedIndex, required this.onTap});
  final int selectedIndex;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(0);
                context.read<StoryCubit>().resetStories();
              }
            },
            child: SizedBox(
              width: 36,
              height: 36,
              child: selectedIndex == 0
                  ? const LineIcon.home()
                  : const Icon(Icons.home),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(1);
                context.read<ImageCubit>().resetImage();
              }
            },
            child: SizedBox(
                width: 36,
                height: 36,
                child: selectedIndex == 1
                    ? const LineIcon.retroCamera()
                    : const Icon(Icons.photo_camera)),
          ),
          GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap(2);
              }
            },
            child: SizedBox(
                width: 36,
                height: 36,
                child: selectedIndex == 2
                    ? const LineIcon.cog()
                    : const Icon(Icons.settings_sharp)),
          )
        ],
      ),
    );
  }
}
