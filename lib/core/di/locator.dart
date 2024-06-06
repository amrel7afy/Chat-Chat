import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';
import 'package:new_chat_with_me/features/chatting/presentation/view_model/listen_all_users_cubit/listen_to_all_users_cubit.dart';

import '../../features/chatting/presentation/view_model/add_reciever_chat_data_cubit/add_reciever_chat_data_cubit.dart';
import '../../features/chatting/presentation/view_model/listen_to_all_chats_cubit/listen_to_all_chats_cubit.dart';
import '../../features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
import '../../features/chatting/presentation/view_model/unread_messages_count/unread_messages_count_cubit.dart';
import '../../features/contacts/presentation/view_model/check_contact_cubit/check_contacts_cubit.dart';
import '../../features/information/presentation/view_model/information_cubit.dart';
import '../../features/login/presentation/view_model/login_cubit/login_cubit.dart';
import '../../features/login/presentation/view_model/otp_cubit/otp_cubit.dart';
// import '../../features/chatting/presentation/view_model/add_receiver_chat_data_cubit/add_receiver_chat_data_cubit.dart';
// import '../../features/profile/presentation/view_model/edit_profile_cubit/edit_profile_cubit.dart';
// import '../../features/chatting/presentation/view_model/listen_to_messages_cubit/listen_to_messages_cubit.dart';
// import '../../features/chatting/presentation/view_model/unread_messages_count_cubit/unread_messages_count_cubit.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
 locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
 locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
 locator.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
 locator.registerLazySingleton<SharedRepository>(() => SharedRepository());

 locator.registerFactory<LoginCubit>(() => LoginCubit(locator<SharedRepository>()));
 locator.registerFactory<OTPCubit>(() => OTPCubit(locator<SharedRepository>()));
 locator.registerFactory<InformationCubit>(() => InformationCubit(locator<SharedRepository>()));
 locator.registerFactory<ListenToAllChatsCubit>(() => ListenToAllChatsCubit(locator<SharedRepository>()));
 locator.registerFactory<CheckContactsCubit>(() => CheckContactsCubit(locator<SharedRepository>()));
 locator.registerFactory<ListenToAllUsersCubit>(() => ListenToAllUsersCubit(locator<SharedRepository>()));
 locator.registerFactory<ListenToMessagesCubit>(() => ListenToMessagesCubit(locator<SharedRepository>()));
 locator.registerFactory<AddReceiverChatDataCubit>(() => AddReceiverChatDataCubit(locator<SharedRepository>()));
 locator.registerFactory<UnreadMessagesCountCubit>(() => UnreadMessagesCountCubit(locator<SharedRepository>()));

 // locator.registerFactory<AddReceiverChatDataCubit>(() => AddReceiverChatDataCubit(locator<SharedRepository>()));
 // locator.registerFactory<EditProfileCubit>(() => EditProfileCubit(locator<SharedRepository>()));
 // locator.registerFactory<UnreadMessagesCountCubit>(() => UnreadMessagesCountCubit(locator<SharedRepository>()));
}
