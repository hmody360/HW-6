import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_contact_list/assets/colors.dart';
import 'package:my_contact_list/data%20layer/main_data_layer.dart';
import 'package:my_contact_list/helpers/extensions/screen_helper.dart';
import 'package:my_contact_list/helpers/extensions/snackbar_helper.dart';
import 'package:my_contact_list/models/contact_model.dart';
import 'package:my_contact_list/widgets/button_cute.dart';
import 'package:my_contact_list/widgets/icon_button_cute.dart';
import 'package:my_contact_list/widgets/text_field_cute.dart';
import 'package:email_validator/email_validator.dart';

// ignore: must_be_immutable
class FormSection extends StatelessWidget {
  FormSection({
    super.key,
  });

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: context.getHeight() * .5,
      decoration: BoxDecoration(
          color: colors[1],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldCute(
                  labelText: "Name",
                  hintText: "Enter your name",
                  controller: nameController,
                  icon: const Icon(Icons.person),
                ),
                IconButtonCute(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    nameController.clear();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFieldCute(
                  labelText: "Email",
                  hintText: "Enter your email",
                  controller: emailController,
                  icon: const Icon(Icons.alternate_email),
                ),
                IconButtonCute(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    emailController.clear();
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonCute(
                    text: "Add Contact",
                    onClick: () {
                      if (nameController.text.trim() == "" ||
                          emailController.text.trim() == "") {
                        context.showSnackBar(
                            "Please enter valid input, empty fields not allowed!",
                            context);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        context.showSnackBar(
                            "Email not valid, please change email.", context);
                      } else {
                        GetIt.I.get<MainData>().addContact(Contact(
                            name: nameController.text.trim(),
                            email: emailController.text.trim()));

                        context.showSnackBar(
                            "${nameController.text} has been added!", context);
                        nameController.text = "";
                        emailController.text = "";
                        GetIt.I.get<MainData>().notfier.value =
                            GetIt.I.get<MainData>().contacts.length;
                      }
                    }),
                ButtonCute(
                    text: "Clear List",
                    onClick: () {
                      if (GetIt.I.get<MainData>().contacts.isEmpty) {
                        context.showSnackBar("List is already empty!", context);
                      } else {
                        GetIt.I.get<MainData>().clearContactList();
                        GetIt.I.get<MainData>().notfier.value =
                            GetIt.I.get<MainData>().contacts.length;
                        context.showSnackBar("List cleared!", context);
                      }
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
