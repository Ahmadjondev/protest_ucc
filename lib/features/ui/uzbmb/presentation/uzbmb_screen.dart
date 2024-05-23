import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/common/app_colors.dart';
import 'package:protest/common/app_text_styles.dart';
import 'package:protest/common/routes.dart';
import 'package:protest/features/ui/uzbmb/data/models/major_model.dart';
import 'package:protest/features/ui/uzbmb/service/major_service.dart';
import 'package:protest/features/widgets/gradient_button.dart';

class UzbmbScreen extends StatefulWidget {
  UzbmbScreen({super.key});

  @override
  State<UzbmbScreen> createState() => _UzbmbScreenState();
}

class _UzbmbScreenState extends State<UzbmbScreen> {
  ValueNotifier<String?> science1 = ValueNotifier(null);
  ValueNotifier<String?> science2 = ValueNotifier(null);
  ValueNotifier<StudyModel?> study = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UZBMB Test"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder(
            future: MajorService().getMajors(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Yo'nalish tanlang",
                      style: AppTextStyles.body20w6
                          .copyWith(color: Colors.black54),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: science1.value != null
                                  ? Colors.black54
                                  : AppColors.borderColor,
                              width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: ValueListenableBuilder(
                          valueListenable: study,
                          builder: (context, value, child) {
                            return DropdownButton(
                              items: snapshot.data?.map((e) {
                                return DropdownMenuItem(
                                  child: Text(
                                    e.studyName,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  value: e,
                                );
                              }).toList(),
                              value: study.value,
                              hint: Text(
                                "Yo'nalishlar",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              menuMaxHeight: 250,
                              underline: Container(),
                              icon: Icon(Icons.arrow_drop_down),
                              isExpanded: true,
                              onChanged: (value) {
                                study.value = value;
                              },
                            );
                          },
                        )),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Majburiy fanlar majmuasi",
                            style: TextStyle(
                                color: Colors.black45.withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ona tili",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "10 ta",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Matematika",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "10 ta",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "O'zbekiston tarixi",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "10 ta",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8),
                          child: Text(
                            "Yo'nalishdagi fanlar",
                            style: TextStyle(
                                color: Colors.black45.withOpacity(0.5),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: study,
                          builder: (context, value, child) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: value != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.sciences.science1,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "(3.1 ball) 30 ta",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "Yo'nalish tanlanmagan",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: study,
                          builder: (context, value, child) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: value != null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.sciences.science2,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "(2.1 ball) 30 ta",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "Yo'nalish tanlanmagan",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        GradientButton(
                          onPressed: () {
                            context.push(Routes.uzbmbStart,
                                extra: study.value?.sciencePairs ?? 1);
                          },
                          text: "Boshlash",
                          height: 50,
                          radius: 50,
                        )
                      ],
                    ),
                  ],
                );
              }
              return Container();
            },
          )),
    );
  }
}
