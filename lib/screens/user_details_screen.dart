import 'package:flutter/material.dart';
import 'package:flutter_mastering_course/core/services/preferences_manager.dart';
import 'package:flutter_mastering_course/core/widgets/custom_text_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final TextEditingController userNameController;

  late final TextEditingController motivationQuoteController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Joe',
                controller: userNameController,
                title: 'User Name',
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                hintText: 'One task at a time. One step closer.',
                controller: motivationQuoteController,
                title: 'Motivation Quote',
                maxLines: 5,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter motivation quote';
                  }
                  return null;
                },
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await PreferencesManager().setString(
                        'username',
                        userNameController.value.text,
                      );
                      await PreferencesManager().setString(
                        'motivation_quote',
                        motivationQuoteController.value.text,
                      );
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('Save Changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
