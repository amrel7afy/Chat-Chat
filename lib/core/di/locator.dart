import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:new_chat_with_me/core/shared/shared_repo.dart';

import '../../features/information/presentation/view_model/information_cubit.dart';
import '../../features/login/presentation/view_model/login_cubit/login_cubit.dart';
import '../../features/login/presentation/view_model/otp_cubit/otp_cubit.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
 locator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  locator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  locator.registerLazySingleton<SharedRepository>(() => SharedRepository());
  // locator.registerLazySingleton<AddReceiverChatDataCubit>(() => AddReceiverChatDataCubit());
  //locator.registerLazySingleton<ListenToMessagesCubit>(() => ListenToMessagesCubit());
  locator.registerFactory<LoginCubit>(() => LoginCubit(locator<SharedRepository>()));
  locator.registerFactory<OTPCubit>(() => OTPCubit(locator<SharedRepository>()));
  locator.registerFactory<InformationCubit>(() => InformationCubit(locator<SharedRepository>()));
}