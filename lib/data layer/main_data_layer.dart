import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_contact_list/models/contact_model.dart';

class MainData {
  List<Contact> contacts = [];
  ValueNotifier notfier = ValueNotifier(0);
  var locator = GetStorage();

  MainData() {
    loadContactList();
  }

  List<Contact> getAllContacts() {
    return contacts;
  }

  void addContact(Contact contact) {
    contacts.add(contact);
    uploadContactList();
  }

  void uploadContactList() {
    List<dynamic> uploadList =
        contacts.map((contact) => contact.toMap()).toList();
    locator.write("contacts", uploadList);
  }

  loadContactList() async {
    List<dynamic> loadList = locator.read("contacts") ?? [];
    contacts = loadList.map((contact) => Contact.fromMap(contact)).toList();
    notfier = ValueNotifier(contacts.length);
  }

  void clearContactList() {
    contacts = [];
    uploadContactList();
  }
}
