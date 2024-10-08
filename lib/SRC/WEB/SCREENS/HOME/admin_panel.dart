import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:taskify/SRC/WEB/SECTIONS/MEMBER/manage_member.dart';
import 'package:taskify/SRC/WEB/SECTIONS/OVERVIEW/overview.dart';
import 'package:taskify/SRC/WEB/SECTIONS/DEPARTMENT/manage_department.dart';
import 'package:taskify/SRC/WEB/SECTIONS/TASK/manage_tasks.dart';
import 'package:taskify/SRC/WEB/WIDGETS/still_web_drawer.dart';
import 'package:taskify/THEME/theme.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int _selectedIndex = 0;
  late Widget _selectedWidget;

  // Define GlobalKeys
  final GlobalKey _createDepartmentKey = GlobalKey();
  final GlobalKey _viewEditSearchDepartmentsKey = GlobalKey();
  final GlobalKey _addMembersInDepartmentKey = GlobalKey();
  final GlobalKey _createTasksKey = GlobalKey();
  final GlobalKey _viewEditSearchTasksKey = GlobalKey();
  final GlobalKey _assignTasksToMembersKey = GlobalKey();
  final GlobalKey _evaluateTasksKey = GlobalKey();
  final GlobalKey manageUserRegistrations = GlobalKey();
  final GlobalKey membersAndDepartmentKey = GlobalKey();
  final GlobalKey assignedTasksKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedWidget = Overview(
      onItemTapped: _onItemTapped,
      createDepartmentKey: _createDepartmentKey,
      viewEditSearchDepartmentsKey: _viewEditSearchDepartmentsKey,
      addMembersInDepartmentKey: _addMembersInDepartmentKey,
      createTasksKey: _createTasksKey,
      viewEditSearchTasksKey: _viewEditSearchTasksKey,
      assignTasksToMembersKey: _assignTasksToMembersKey,
      evaluateTasksKey: _evaluateTasksKey,
      manageUserRegistrations: manageUserRegistrations,
      membersAndDepartmentKey: membersAndDepartmentKey,
      assignedTasksKey: assignedTasksKey,
    );
  }

  void _onItemTapped(int index, Widget widget) {
    setState(() {
      _selectedIndex = index;
      _selectedWidget = widget;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget is ManageDepartment) {
        switch (index) {
          case 1:
            _scrollToSection(_createDepartmentKey);
            break;
          case 2:
            _scrollToSection(_viewEditSearchDepartmentsKey);
            break;
          case 3:
            _scrollToSection(_addMembersInDepartmentKey);
            break;
          case 4:
            _scrollToSection(membersAndDepartmentKey);
            break;
        }
      } else if (widget is ManageTasks) {
        switch (index) {
          case 6:
            _scrollToSection(_createTasksKey);
            break;
          case 7:
            _scrollToSection(_viewEditSearchTasksKey);
            break;
          case 8:
            _scrollToSection(_assignTasksToMembersKey);
            break;
          case 9:
            _scrollToSection(assignedTasksKey);
            break;
          case 10:
            _scrollToSection(_evaluateTasksKey);
            break;
        }
      } else if (widget is ManageMember) {
        switch (index) {
          case 5:
            _scrollToSection(manageUserRegistrations);
            break;
        }
      }
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBgGrey,
      appBar: AppBar(
        backgroundColor: customDarkGrey,
        title: const Row(
          children: [
            Icon(
              SimpleIcons.task,
              color: customAqua,
            ),
            SizedBox(width: 8),
            Text(
              'Taskify AdminPanel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: customAqua,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add your onPressed code here!
            },
          ),
        ],
      ),
      body: Row(
        children: [
          DrawerWidget(
            selectedIndex: _selectedIndex,
            onItemTapped: _onItemTapped,
            createDepartmentKey: _createDepartmentKey,
            viewEditSearchDepartmentsKey: _viewEditSearchDepartmentsKey,
            addMembersInDepartmentKey: _addMembersInDepartmentKey,
            createTasksKey: _createTasksKey,
            viewEditSearchTasksKey: _viewEditSearchTasksKey,
            assignTasksToMembersKey: _assignTasksToMembersKey,
            evaluateTasksKey: _evaluateTasksKey,
            manageUserRegistrations: manageUserRegistrations,
            membersAndDepartmentKey: membersAndDepartmentKey,
            assignedTasksKey: assignedTasksKey,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: _selectedWidget,
            ),
          ),
        ],
      ),
    );
  }
}
