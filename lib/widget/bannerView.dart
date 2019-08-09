import 'package:flutter/material.dart';
import 'package:cool_music_player/base/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cool_music_player/entity/bannerEntity.dart';


class BannerView extends StatefulWidget {
  
  final List<BannerEntity> banners;


  BannerView({this.banners});

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  PageController _pageController;
  SwiperController _swipeController;

  @override
  void initState() {
    _pageController= new PageController();
    _swipeController= SwiperController();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    return Container(
      width: Constant.screenWidth,
      height: Constant.screenWidth * 0.46,
      child: Swiper(
        itemCount: widget.banners.length,

        controller: _swipeController,
        itemBuilder: (context,index){
          return Container(
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.banners[index].picUrl,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        autoplay: true,
        autoplayDelay: 7000,
        onTap: (index){
          print("click ${index.toString()}");
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.all(15),
          builder: const DotSwiperPaginationBuilder(
            size: 10.0,
            activeSize: 10.0,
            space: 3.0,
            activeColor: Color(0x99FF0000),
            color: Color(0x66FFFFFF)
          )
        ),

      ),
//      child: PageView.builder(
//        itemBuilder: ((context, index) {
//          return Container(
//            margin: EdgeInsets.all(10),
//            child: ClipRRect(
//              borderRadius: BorderRadius.circular(10),
//              child: Image.network(
//                widget.banners[index].picUrl,
//                fit: BoxFit.cover,
//              ),
//            ),
//          );
//        }),
//        scrollDirection: Axis.horizontal,
//        reverse: false,
//        itemCount: widget.banners.length,
//        controller: _pageController,
//        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
//        onPageChanged: (index) {
//          print(index);
//        },
//      ),
    );
  }
}
