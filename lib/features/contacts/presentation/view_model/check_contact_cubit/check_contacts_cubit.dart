import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/constants/methods.dart';
import '../../../../../core/shared/shared_repo.dart';
import '../../../../../core/shared/user_model.dart';
import 'check_contacts_state.dart';

class CheckContactsCubit extends Cubit<CheckContactsState> {
  final SharedRepository sharedRepository;

  CheckContactsCubit(this.sharedRepository) : super(CheckContactsInitial());
  List<Contact> contacts = [];
  List<UserModel> matchedUsersWithContacts = [];

  getContacts() async {
    // Request permission to access contacts
    emit(CheckContactsLoading());
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      try {
        contacts = [];
        List<Contact> data = await ContactsService.getContacts();
        log("List<Contact> => ${data.map((e) => e.phones?.first.value ?? '')}");
        contacts.addAll(data);
      } catch (e, s) {
        log("Error get contacts $e ,,, $s");
        emit(
            CheckNoContactsState(removeSubString(e.toString(), 'Exception: ')));
      }
    } else {
      return [];
    }
  }

  getMatchedUsersWithContacts(BuildContext context) {
    Set contactPhoneNumbers = contacts
        .expand((contact) => contact.phones ?? [])
        .map((phone) => _cleanPhoneNumber(phone.value) ?? '')
        .toSet();

    //log('contactPhoneNumbers: ${contactPhoneNumbers.length.toString()}');
    if (contactPhoneNumbers.isNotEmpty) {
      matchedUsersWithContacts = sharedRepository.users
          .where((user) => contactPhoneNumbers.contains(user.phoneNumber))
          .toList();
      //log('matchedUsersWithContacts: ${matchedUsersWithContacts.length.toString()}');
      removeCurrentUserFromList();
      if (matchedUsersWithContacts.isEmpty) {
        emit(CheckNoMatchedContactsState(
            'Hmm 😐, you can invite your contacts to our app! '));
      } else {
        matchedUsersWithContacts.removeWhere((element) =>
            element.phoneNumber == sharedRepository.userModel.phoneNumber);
        emit(CheckGetContactsSuccessState(matchedUsersWithContacts));
      }
    } else {
      emit(CheckNoContactsState('Hmm 😐, you need to save a new contact. '));
    }
  }

  void removeCurrentUserFromList() {
    List<UserModel> filteredList = List.from(matchedUsersWithContacts);
    for (var user in filteredList) {
      if (user.phoneNumber == sharedRepository.userModel.phoneNumber) {
        matchedUsersWithContacts.remove(user);
      }
    }
  }

  String _cleanPhoneNumber(String phoneNumber) {
    // Remove spaces and dashes from phone number
    log('before: $phoneNumber');
    String cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[ -]'), '');
    log('after: $cleanedPhoneNumber');
    return cleanedPhoneNumber;
  }
}
