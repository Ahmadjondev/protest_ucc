import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:protest/common/app_colors.dart';
import 'package:protest/common/assets.dart';
import 'package:protest/features/ui/uzbmb/data/models/quiz_model.dart';
import 'package:protest/features/ui/uzbmb/data/models/science_model.dart';
import 'package:protest/features/ui/uzbmb/service/major_service.dart';
import 'package:sticky_headers/sticky_headers.dart';

class UzbmbQuizScreen extends StatefulWidget {
  const UzbmbQuizScreen({super.key, required this.id});

  final int id;

  @override
  State<UzbmbQuizScreen> createState() => _UzbmbQuizScreenState();
}

class _UzbmbQuizScreenState extends State<UzbmbQuizScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  Timer? timer;
  int countDownTimer = 0;
  ValueNotifier<String> timerStr = ValueNotifier('');

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  ValueNotifier<List<ScienceModel>> sciencesQuiz = ValueNotifier([]);

  void getQuestions() async {
    MajorService().getQuizzes(widget.id).then((value) {
      sciencesQuiz.value = value.toList();
      startTimer(60 * 120);
    });
  }

  void startTimer(int second) {
    countDownTimer = second;
    timerStr.value = formatTime(second);
    countDownTimer--;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (countDownTimer == 0) {
        // quizEnd();
      } else {
        timerStr.value = formatTime(countDownTimer);
        countDownTimer--;
      }
    });
  }

  String formatTime(int vaqt) {
    String timeStr = '';
    String hours = '${(vaqt / 60 / 60).toInt()}';
    String minutes = '${(vaqt / 60 % 60).toInt()}';
    String seconds = '${(vaqt % 60).toInt()}';
    if (hours.length < 2) hours = '0${hours}';
    if (minutes.length < 2) minutes = '0${minutes}';
    if (seconds.length < 2) seconds = '0${seconds}';
    timeStr = '$hours:$minutes:$seconds';
    return timeStr;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // bool? exit = await proDialog(
        //     context: context,
        //     title: 'Chiqish',
        //     msg: 'Testni yakunlamoqchimisiz?');
        // if (exit) {
        //   return true;
        // }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Assets.iconsTimer)),
              ValueListenableBuilder(
                valueListenable: timerStr,
                builder: (context, value, child) {
                  return Text(
                    timerStr.value,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  );
                },
              )
            ],
          ),
          centerTitle: true,
          // elevation: 1,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  print('Yakunlash');
                },
                child: const Text(
                  "Yakunlash",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
              ),
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: sciencesQuiz,
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: sciencesQuiz.value.length + 1,
              shrinkWrap: true,
              itemBuilder: (context, index1) {
                if (sciencesQuiz.value.length == index1) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: size.width * .2, bottom: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Yakunlash",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.75, 52),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  );
                }
                return StickyHeader(
                    header: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 18),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${sciencesQuiz.value[index1].science}",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Text(
                            "${sciencesQuiz.value[index1].questions.length} ta savol",
                            style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    content: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sciencesQuiz.value[index1].questions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index2) {
                        QuizModel data =
                            sciencesQuiz.value[index1].questions[index2];

                        return DtmTopicItem(data,
                            title:
                                '${index2 + 1}/${sciencesQuiz.value[index1].questions.length} • ${sciencesQuiz.value[index1].science}',
                            answerFunc: (i) {
                          sciencesQuiz.value[index1].questions[index2].checked =
                              i;
                          print(sciencesQuiz
                              .value[index1].questions[index2].checked);
                        });
                      },
                    ));
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showQuizBottomSheet();
          },
          backgroundColor: AppColors.primaryColor.withOpacity(0.8),
          child: const Icon(CupertinoIcons.eye, color: Colors.white),
        ),
      ),
    );
  }

  void showQuizBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 16, right: 20, bottom: 8),
                child: Text(
                  "Test Holati",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade200),
                          ),
                          const SizedBox(width: 3),
                          const Text("Ishlanmagan test savoli"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(width: 3),
                          const Text("Ishlangan test savoli"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "DTM Imtihon",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    Text(
                      "${90} ta savol",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: sciencesQuiz.value.map<Widget>((e) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${e.science}",
                                    style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "${e.questions.length} ta",
                                    style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7,
                                      crossAxisSpacing: 4,
                                      mainAxisSpacing: 4),
                              itemCount: e.questions.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                // int? checked = controller.quizzes[index].checked;
                                return InkWell(
                                  onTap: () {
                                    // scrollController.jumpTo(index * 300.h);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: null == null
                                          ? Colors.grey.shade200
                                          : AppColors.primaryColor,
                                    ),
                                    child: Text(
                                      "${index + 1}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: null == null
                                              ? null
                                              : Colors.white),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}

class DtmTopicItem extends StatefulWidget {
  DtmTopicItem(this.data,
      {required this.title, required this.answerFunc, super.key});

  Function answerFunc;
  QuizModel data;
  String title;

  @override
  State<DtmTopicItem> createState() => _DtmTopicItemState();
}

class _DtmTopicItemState extends State<DtmTopicItem> {
  int? clickAnswer;

  @override
  void initState() {
    super.initState();
    clickAnswer = widget.data.checked;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        widget.data.questionText,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                answerDesign('A. ' + widget.data.varAName, widget.data.varAId),
                answerDesign('B. ' + widget.data.varBName, widget.data.varBId),
                widget.data.varCName != null && widget.data.varCId != null
                    ? answerDesign(
                        'C. ' + widget.data.varCName!, widget.data.varCId!)
                    : Container(),
                widget.data.varDName != null && widget.data.varDId != null
                    ? answerDesign(
                        'D. ' + widget.data.varDName!, widget.data.varDId!)
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget answerDesign(String txt, int index) {
    return InkWell(
      onTap: () {
        clickAnswer = index;
        widget.answerFunc(index);
        setState(() {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: Colors.white,
            border: clickAnswer != null && clickAnswer == index
                ? Border.all(width: 2, color: AppColors.primaryColor)
                : null,
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: Text(
          txt,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
