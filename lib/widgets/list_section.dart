import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_contact_list/data%20layer/main_data_layer.dart';
import 'package:my_contact_list/helpers/extensions/screen_helper.dart';
import 'package:my_contact_list/widgets/contact_card.dart';
import 'package:my_contact_list/widgets/no_contacts_message.dart';

// ignore: must_be_immutable
class ListSection extends StatelessWidget {
  const ListSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getHeight() * .4,
      child: ValueListenableBuilder(
        valueListenable: GetIt.I.get<MainData>().notfier,
        builder: (context, value, _) {
          return (GetIt.I.get<MainData>().contacts.isEmpty)
              ? const NoContactsMessage()
              : ListView(
                  children: List.generate(
                      GetIt.I.get<MainData>().contacts.length, (index) {
                    return ContactCard(
                        name: GetIt.I.get<MainData>().contacts[index].name,
                        email: GetIt.I.get<MainData>().contacts[index].email);
                  }),
                );
        },
      ),
    );
  }
}
