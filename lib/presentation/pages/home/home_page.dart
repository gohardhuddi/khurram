import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:nimbus/controller/getxController.dart';
import 'package:nimbus/model/projectsModel.dart';
import 'package:nimbus/presentation/layout/adaptive.dart';
import 'package:nimbus/presentation/pages/home/sections/about_me_section.dart';
import 'package:nimbus/presentation/pages/home/sections/awards_section.dart';
import 'package:nimbus/presentation/pages/home/sections/blog_section.dart';
import 'package:nimbus/presentation/pages/home/sections/footer_section.dart';
import 'package:nimbus/presentation/pages/home/sections/header_section/header_section.dart';
import 'package:nimbus/presentation/pages/home/sections/nav_section/nav_section_mobile.dart';
import 'package:nimbus/presentation/pages/home/sections/nav_section/nav_section_web.dart';
import 'package:nimbus/presentation/pages/home/sections/projects_section.dart';
import 'package:nimbus/presentation/pages/home/sections/skills_section.dart';
import 'package:nimbus/presentation/pages/home/sections/statistics_section.dart';
import 'package:nimbus/presentation/widgets/app_drawer.dart';
import 'package:nimbus/presentation/widgets/nav_item.dart';
import 'package:nimbus/presentation/widgets/spaces.dart';
import 'package:nimbus/utils/functions.dart';
import 'package:nimbus/values/values.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  // bool isFabVisible = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  final List<NavItemData> navItems = [
    NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
    NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
    NavItemData(name: StringConst.SKILLS, key: GlobalKey()),
    NavItemData(name: StringConst.PROJECTS, key: GlobalKey()),
    // NavItemData(name: StringConst.AWARDS, key: GlobalKey()),
    // NavItemData(name: StringConst.BLOG, key: GlobalKey()),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final counterController = Get.put(Controller());
    List<ProjectsModel> pl=counterController.projectsData;
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.10;
    double elevation = 4.0;
    double scale = 1.0;
    Offset translate = Offset(0,0);
    bool ishover= false;
    return Scaffold(
      key: _scaffoldKey,
      drawer: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < RefinedBreakpoints().desktopSmall) {
            return AppDrawer(
              menuList: navItems,
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            // Scroll to header section
            scrollToSection(navItems[0].key.currentContext!);
          },
          child: Icon(
            FontAwesomeIcons.arrowUp,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          ResponsiveBuilder(
            refinedBreakpoints: RefinedBreakpoints(),
            builder: (context, sizingInformation) {
              double screenWidth = sizingInformation.screenSize.width;
              if (screenWidth < RefinedBreakpoints().desktopSmall) {
                return NavSectionMobile(scaffoldKey: _scaffoldKey);
              } else {
                return NavSectionWeb(
                  navItems: navItems,
                );
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset(ImagePath.BLOB_BEAN_ASH),
                        ),
                      ),
                      Column(
                        children: [
                          HeaderSection(
                            key: navItems[0].key,
                          ),
                          SizedBox(height: spacerHeight),
                          VisibilityDetector(
                            key: Key("about"),
                            onVisibilityChanged: (visibilityInfo) {
                              double visiblePercentage =
                                  visibilityInfo.visibleFraction * 100;
                              if (visiblePercentage > 10) {
                                _controller.forward();
                              }
                            },
                            child: Container(
                              key: navItems[1].key,
                              child: AboutMeSection(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: spacerHeight),
                  Stack(
                    children: [
                      Positioned(
                        top: assignWidth(context, 0.1),
                        left: -assignWidth(context, 0.05),
                        child: Image.asset(ImagePath.BLOB_FEMUR_ASH),
                      ),
                      Positioned(
                        right: -assignWidth(context, 0.5),
                        child: Image.asset(ImagePath.BLOB_SMALL_BEAN_ASH),
                      ),
                      Column(
                        children: [
                          Container(
                            key: navItems[2].key,
                            child: SkillsSection(),
                          ),
                          SizedBox(height: spacerHeight),
                          StatisticsSection(),
                          SizedBox(height: spacerHeight),
                          Container(
                            key: navItems[3].key,
                            // child: ProjectsSection(),
                            // child: Container(
                            //   color: Colors.red,
                            //   width: MediaQuery.of(context).size.width,
                            //   height: 300,
                            //   child: InteractiveViewer(
                            //     panEnabled: false, // Set it to false
                            //     boundaryMargin: EdgeInsets.all(100),
                            //     minScale: 0.5,
                            //     maxScale: 2,
                            //     child: GridView.builder(itemCount:40,
                            //       scrollDirection: Axis.horizontal,
                            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisCount: 1,
                            //           crossAxisSpacing: 4.0,
                            //           mainAxisSpacing: 4.0
                            //       ),
                            //       itemBuilder: (BuildContext context, int index){
                            //         //return Image.network(pl[index].proImageUrl);
                            //         return Image.network("https://firebasestorage."
                            //             "googleapis.com/v0/b/khurramshahzad-37e0c."
                            //             "appspot.com/o/test.jpeg?alt=media&token="
                            //             "e66fad91-97b1-46e1-b7b1-2156980da43e");
                            //       },  ),
                            //   ),
                            // ),
                              child:MouseRegion(
                                onEnter: (_){
                                  setState(() {
                                  ishover=true;
                                  });print("hover");
                                },
                                onExit: (_){
                                  setState(() {
                                    ishover=false;
                                  });

                                },
                                child:ishover==true? Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU',
                                ):Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.redAccent,
                                )
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: spacerHeight),
                  Stack(
                    children: [
                      Positioned(
                        left: -assignWidth(context, 0.6),
                        child: Image.asset(ImagePath.BLOB_ASH),
                      ),
                      Column(
                        children: [
                          // Container(
                          //   key: navItems[4].key,
                          //   child: AwardsSection(),
                          // ),
                          SpaceH40(),
                          // Container(
                          //   key: navItems[5].key,
                          //   child: BlogSection(),
                          // ),
                          FooterSection(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
