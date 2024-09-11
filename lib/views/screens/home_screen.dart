import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/extensions.dart';
import 'package:to_do_app/constants/strings.dart';
import 'package:to_do_app/controllers/to_do_controller.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/views/widgets/text_form_field_widget.dart';
import 'package:to_do_app/views/widgets/to_do_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isDone = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ToDoController toDoController = ModalRoute.of(context)!.settings.arguments as ToDoController;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.darkBlueColor,
        surfaceTintColor: AppColors.darkBlueColor,
        shape: RoundedRectangleBorder(
          borderRadius: 15.borderRadiusBottom,
        ),
        title: const Text(AppStrings.toDoListText),
        actions: [
          InkWell(
            onTap: () => displayBottomSheet(toDoController),
            child: const Icon(Icons.add),
          ),
          15.gap,
        ],
      ),
      body: toDoController.toDos.isEmpty
          ? const Center(
              child: Text(
                AppStrings.noToDosFoundText,
                style: TextStyle(
                  fontSize: 40,
                  color: AppColors.darkBlueColor,
                ),
              ),
            )
          : ListView.separated(
              padding: 10.edgeInsetsAll,
              itemCount: toDoController.toDos.length,
              itemBuilder: (_, int index) {
                ToDoModel toDo = toDoController.toDos[index];
                return ToDoItemWidget(
                  toDo,
                  onDelete: () => toDoController.deleteToDo(toDo.id).then(
                        (value) => setState(() {}),
                      ),
                  onUpdate: () => displayBottomSheet(
                    toDoController,
                    toDo: toDo,
                  ),
                );
              },
              separatorBuilder: (_, __) {
                return 10.gap;
              },
            ),
    );
  }

  void displayBottomSheet(ToDoController toDoController, {ToDoModel? toDo}) {
    if (toDo != null) {
      isDone = toDo.isDone;
      titleController.text = toDo.title;
      subtitleController.text = toDo.subtitle;
    } else {
      isDone = 0;
      titleController.clear();
      subtitleController.clear();
    }

    showModalBottomSheet(
      backgroundColor: AppColors.darkBlueColor,
      shape: RoundedRectangleBorder(
        borderRadius: 15.borderRadiusTop,
      ),
      isDismissible: true,
      showDragHandle: true,
      barrierColor: AppColors.darkBlueColor.withOpacity(0.5),
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: 10.edgeInsetsAll,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    toDo == null ? AppStrings.addToDoText : AppStrings.updateToDoText,
                    style: const TextStyle(
                      fontSize: 30,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  25.gap,
                  TextFormFieldWidget(
                    titleController,
                    labelText: AppStrings.titleText,
                  ),
                  20.gap,
                  TextFormFieldWidget(
                    subtitleController,
                    labelText: AppStrings.subtitleText,
                  ),
                  20.gap,
                  StatefulBuilder(
                    builder: (_, setModalState) {
                      return InkWell(
                        onTap: () {
                          isDone = isDone == 0 ? 1 : 0;
                          setModalState(() {});
                        },
                        child: Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: AnimatedContainer(
                                height: 20,
                                width: 20,
                                duration: const Duration(
                                  milliseconds: 250,
                                ),
                                decoration: BoxDecoration(
                                  color: isDone == 1 ? AppColors.whiteColor : AppColors.darkBlueColor,
                                  borderRadius: 5.borderRadiusAll,
                                  border: Border.all(
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                            20.gap,
                            const Expanded(
                              child: Text(
                                AppStrings.markAsDoneText,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  25.gap,
                  InkWell(
                    onTap: titleController.text.isNotEmpty || subtitleController.text.isNotEmpty
                        ? () {
                            if (toDo == null) {
                              toDoController
                                  .addToDo(
                                isDone: isDone,
                                titleController.text,
                                subtitle: subtitleController.text,
                              )
                                  .then(
                                (value) {
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            } else {
                              toDoController
                                  .updateToDo(
                                toDo.id,
                                isDone: isDone,
                                title: titleController.text,
                                subtitle: subtitleController.text,
                              )
                                  .then(
                                (value) {
                                  if (mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            }
                            setState(() {});
                          }
                        : () => AppStrings.pleaseFillAllTheFieldsText.showToast,
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: 15.borderRadiusAll,
                      ),
                      child: Text(
                        toDo == null ? AppStrings.addText : AppStrings.updateText,
                        style: const TextStyle(
                          color: AppColors.darkBlueColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
