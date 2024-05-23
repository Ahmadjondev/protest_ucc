import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protest/common/routes.dart';

class ProTest extends StatelessWidget {
  const ProTest({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
        child: MaterialApp.router(
          routerConfig: AppRoutes.router,
          theme: ThemeData(
            // scaffoldBackgroundColor: Colors.white,
          ),
          title: 'ProTest',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
        ),
      ),
      builder: (context, child) {
        return child!;
      },
    );
  }
}
