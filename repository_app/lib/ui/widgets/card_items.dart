import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repository/ui/widgets/items_card.dart';

class CardItems extends StatelessWidget {
  final String title;
  final String? lastUpdateTime;
  final String? excerpt;
  final String? assetImage;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;
  final double titleSize;
  final double excerptSize;

  final Function()? onTap;
  final double aspectRatio;

  const CardItems({
    Key? key,
    required this.title,
    this.lastUpdateTime,
    this.assetImage,
    this.excerpt,
    this.minWidth = double.infinity,
    this.minHeight = 178,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
    this.titleSize = 18,
    this.excerptSize = 14,
    this.onTap,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);

  Widget _buildImage() {
    if (assetImage?.isNotEmpty != true) {
      return Container();
    }
    return SvgPicture.asset(assetImage ?? '', fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      child: _build(context),
      aspectRatio: aspectRatio,
    );
  }

  Widget _build(BuildContext context) {
    return ItemsCard(
      backgroundColor: Colors.white,
      minWidth: minWidth,
      minHeight: minHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      onTap: onTap,
      background: Stack(
        children: <Widget>[
          Positioned.fill(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: _buildImage(),
            clipBehavior: Clip.antiAlias,
          )),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xCC2A2A30),
                    Color(0x1F8A8B9A),
                    Color(0x00C4C4C4),
                    Color(0x00C4C4C4),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.11, 0.55, 1, 1],
                ),
              ),
            ),
          )
        ],
      ),
      foreground: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            lastUpdateTime ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          if (excerpt != null)
            Text(
              excerpt!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
