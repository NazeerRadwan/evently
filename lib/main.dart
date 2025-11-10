import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/resources/AppStyle.dart';
import 'package:evently/core/resources/RoutesManager.dart';
import 'package:evently/core/source/local/PrefsManager.dart';
import 'package:evently/models/onBoarding.dart';
import 'package:evently/providers/ThemeProvider.dart';
import 'package:evently/providers/UserProvider.dart';
import 'package:evently/ui/create_event/screen/create_event_screen.dart';
import 'package:evently/ui/forgot_pass/screen/forgot_pass_screen.dart';
import 'package:evently/ui/home/screen/home_screen.dart';
import 'package:evently/ui/home/tabs/home_tab/provider/home_tab_provider.dart';
import 'package:evently/ui/home/tabs/map_tab/providers/map_tab_provider.dart';
import 'package:evently/ui/login/screen/login_screen.dart';
import 'package:evently/ui/register/screen/register_screen.dart';
import 'package:evently/ui/splash/screen/splash_screen.dart';
import 'package:evently/ui/start/screen/onboarding_screen.dart';
import 'package:evently/ui/start/screen/start_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardingScreen(),
    );
  }
}
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefsManager.int();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en"), Locale("ar")],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      startLocale: Locale("en"),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider()..init(),
        child: MyApp(),
        //DevicePreview(builder: (context) => MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: AppStyle.lightTheme,
      darkTheme: AppStyle.darkTheme,
      themeMode: provider.mode,
      initialRoute: RoutesManager.splash,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.splash: (_) => SplashScreen(),
        RoutesManager.start: (_) => StartScreen(),
        RoutesManager.login: (_) => LoginScreen(),
        RoutesManager.register: (_) => RegisterScreen(),
        RoutesManager.onBoarding: (_) => OnBoardingScreen(),
        RoutesManager.forgotPass: (_) => ForgotPassScreen(),
        RoutesManager.createEvent: (_) => CreateEventScreen(),
        RoutesManager.home:
            (_) => ChangeNotifierProvider(
              create: (context) => UserProvider(),
              child: HomeScreen(),
            ),
      },
    );
  }
}































/*import 'package:evently/empty.dart';
import 'package:evently/models/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: onBoarding(),
    );
  }
}

class onBoarding extends StatefulWidget {
  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
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

            // Image(image: AssetImage(pages[_currentPage].image)),
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
                      MaterialPageRoute(builder: (context) => empty()),
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

*/