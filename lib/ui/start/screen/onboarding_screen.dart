import 'package:evently/models/onBoarding.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> pages = [
    OnBoarding(
      image: "assets/images/Onboarding1.png",
      title: "Find Events That Inspire You",
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
    ),
    OnBoarding(
      image: "assets/images/Onboarding2.png",
      title: "Effortless Event Planning",
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
    ),
    OnBoarding(
      image: "assets/images/Onboarding3.png",
      title: "Connect with Friends & Share Moments",
      description:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
    ),
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image(
            image: AssetImage('assets/images/Evently.png'),
            height: 45,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 25),
            Container(
              height: 340,
              width: 370,
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(pages[index].image, fit: BoxFit.cover);
                },
              ),
            ),

            SizedBox(height: 45),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                pages[_currentPage].title,

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5669FF),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              pages[_currentPage].description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF1C1C1C),
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Row(
          children: [
            (_currentPage > 0)
                ? IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/arrow_back.svg'),
                )
                : SizedBox(width: 48),
            Spacer(),
            (_currentPage == 2)
                ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: SvgPicture.asset('assets/images/arrow_forward.svg'),
                )
                : IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/images/arrow_forward.svg'),
                ),
          ],
        ),
      ),
    );
  }
}
