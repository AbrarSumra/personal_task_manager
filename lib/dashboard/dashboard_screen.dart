import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_task_manager/app/app_theme/app_theme.dart';
import 'package:personal_task_manager/app/custom_widget/button_l.dart';
import 'package:personal_task_manager/app/custom_widget/custom_text_field.dart';
import 'package:personal_task_manager/app/custom_widget/text_constant.dart';
import 'package:personal_task_manager/app/custom_widget/widgets.dart';
import 'package:personal_task_manager/provider/auth_service_provider.dart';
import 'package:personal_task_manager/provider/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../app/common_pages/app_bar/custom_app_bar.dart';
import '../model/task_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardProvider =
          Provider.of<DashboardProvider>(context, listen: false);
      dashboardProvider.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthServiceProvider>(context, listen: false);
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColor.kAppMainColor,
      appBar: CustomAppBar(
        title: 'Dashboard',
        subtitle: 'Welcome Back!',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColor.kAppLightBlueColor,
                  title: const NormalText(
                    title: "Confirm Logout",
                    color: AppColor.kAppMainColor,
                  ),
                  content: const NormalText(
                    title: "Are you sure you want to logout?",
                    fontSize: 12,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const NormalText(
                        title: "Cancel",
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop(); // close dialog
                        await auth.logout(context);
                      },
                      child: const NormalText(
                        title: "Log Out",
                        color: AppColor.kAppMainColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: dashboardProvider.tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NormalText(
                    title: 'Tasks not added yet',
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  NormalText(
                    title: 'Add new tasks',
                    color: AppColor.kAppYellowColor,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  children: [
                    heightBox(20),
                    Consumer<DashboardProvider>(
                      builder: (_, provider, child) {
                        if (provider.isLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColor.kAppYellowColor,
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: provider.tasks.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final task = provider.tasks[index];
                            final taskId = task.id;
                            final title = task.title;
                            final status = task.status;

                            return Dismissible(
                              key: Key(taskId.toString()),
                              onDismissed: (_) {
                                provider.deleteTask(taskId!);
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                child: Center(
                                    child: Icon(Icons.delete,
                                        color: Colors.white)),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(5.w),
                                margin: EdgeInsets.only(bottom: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColor.kAppTextFieldColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        NormalText(title: title!),
                                        GestureDetector(
                                          onTap: () {
                                            provider.toggleTaskStatus(
                                                taskId!, status!);
                                          },
                                          child: Icon(
                                            status == 'pending'
                                                ? Icons.check_box_outline_blank
                                                : Icons.check_box,
                                            color: AppColor.kAppYellowColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    NormalText(
                                      title: task.description!,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.kAppLightBlueColor,
                                    ),
                                    heightBox(10),
                                    Divider(
                                      height: 0,
                                      color: AppColor.kAppLightBlueColor,
                                    ),
                                    heightBox(10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    AppColor.kAppLightBlueColor,
                                                title: const NormalText(
                                                  title: "Confirm Delete",
                                                  color: AppColor.kAppMainColor,
                                                ),
                                                content: const NormalText(
                                                  title:
                                                      "Are you sure you want to delete this task?",
                                                  fontSize: 12,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const NormalText(
                                                      title: "Cancel",
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop(); // close dialog
                                                      await provider
                                                          .deleteTask(taskId!);
                                                    },
                                                    child: const NormalText(
                                                      title: "Delete",
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: NormalText(
                                            title: 'Delete',
                                            color: AppColor.kBlackColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                          child: VerticalDivider(),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _openAddTaskDialog(context,
                                                task: task);
                                          },
                                          child: NormalText(
                                            title: 'Update',
                                            color: AppColor.kAppYellowColor,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                          child: VerticalDivider(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kAppYellowColor,
        onPressed: () => _openAddTaskDialog(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.h,
        ),
      ),
    );
  }

  void _openAddTaskDialog(BuildContext context, {TaskModel? task}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.kAppMainColor,
      builder: (context) {
        final dashboardProvider =
            Provider.of<DashboardProvider>(context, listen: false);

        // Pre-fill fields if updating
        if (task != null) {
          dashboardProvider.titleController.text = task.title ?? "";
          dashboardProvider.descriptionController.text = task.description ?? "";
        } else {
          dashboardProvider.titleController.clear();
          dashboardProvider.descriptionController.clear();
        }

        return Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
            top: 10.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: NormalText(
                  title: task != null ? 'Update Task' : 'Create New Task',
                  fontSize: 18,
                ),
              ),
              heightBox(20),
              const NormalText(
                title: 'Task Title',
                fontSize: 14,
              ),
              CustomTextField(
                controller: dashboardProvider.titleController,
                hintText: 'Task title',
              ),
              heightBox(20),
              const NormalText(
                title: 'Task Description',
                fontSize: 14,
              ),
              CustomTextField(
                controller: dashboardProvider.descriptionController,
                hintText: 'Task description',
              ),
              heightBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const NormalText(
                      title: 'Cancel',
                      fontSize: 14,
                    ),
                  ),
                  widthBox(10),
                  Consumer<DashboardProvider>(
                    builder: (_, provider, child) {
                      return ButtonL(
                        title: task != null ? 'Update' : 'Create',
                        width: 80,
                        height: 35,
                        isLoading: dashboardProvider.isLoading,
                        onTap: () async {
                          if (dashboardProvider
                                  .titleController.text.isNotEmpty &&
                              dashboardProvider
                                  .descriptionController.text.isNotEmpty) {
                            if (task != null) {
                              /// Update existing task
                              await dashboardProvider.updateTask(task.id ?? 0);
                            } else {
                              /// Add new task
                              await dashboardProvider.addTask();
                            }
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
