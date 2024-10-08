import 'package:flutter/material.dart';
import 'package:taskify/SRC/COMMON/UTILS/Utils.dart';
import 'package:taskify/SRC/WEB/MODEL/department.dart';
import 'package:taskify/SRC/COMMON/SERVICES/department.dart';
import 'package:taskify/SRC/WEB/WIDGETS/hoverable_stretched_aqua_button.dart';
import 'package:taskify/THEME/theme.dart';

class CreateDepartmentWidget extends StatefulWidget {
  const CreateDepartmentWidget({super.key});

  @override
  _CreateDepartmentWidgetState createState() => _CreateDepartmentWidgetState();
}

class _CreateDepartmentWidgetState extends State<CreateDepartmentWidget> {
  final TextEditingController _departmentNameController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DepartmentService _departmentService = DepartmentService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Department',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Department Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _departmentNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: customLightGrey,
                hintText: 'Department Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a department name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            HoverableElevatedButton(
              text: 'Create Department',
              onPressed: _isLoading
                  ? null
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        final departmentName = _departmentNameController.text;
                        final now = DateTime.now().millisecondsSinceEpoch;

                        final department = Department(
                          name: departmentName,
                          createdAt: now,
                          updatedAt: now,
                        );

                        try {
                          await _departmentService.createDepartment(department);
                          Utils().SuccessSnackBar(
                              context,
                              'The department "$departmentName" has been successfully created!'
                          );
                          _formKey.currentState!.reset();
                          _departmentNameController.clear();
                        } catch (e) {
                          Utils().ErrorSnackBar(
                              context, 'Failed to create department, $e');
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _departmentNameController.dispose();
    super.dispose();
  }
}
