import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/entities/message_chat.dart';
import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/chat/send_message_to_user.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ChatHomeRepositoryImpl extends Mock implements ChatHomeRepository {}

void main() {
  SendMessageToUser? usecase;
  ChatHomeRepository? repository;
  Params? params;
  setUp(() {
    repository = ChatHomeRepositoryImpl();
    usecase = SendMessageToUser(repository!);
    params = Params(
      idTokenContact: "151515",
      idTokenUser: "5151515",
      message: MessageChat(date: "1afafa", text: "oziel", tokenId: "moamfom"),
      name: "oziel",
      photo: "",
    );
  });

  test('Should send an message if usecase return success', () async {
    when(() => repository!.sendMessageToUser(
        message: params!.message,
        name: params!.name,
        photo: params!.photo,
        tokenIdContact: params!.idTokenContact,
        tokenIdUser: params!.idTokenUser)).thenAnswer((_) async => right(""));

    final result = await usecase!(params!);

    expect(result, right(""));
    verify(() => repository!.sendMessageToUser(
        message: params!.message,
        name: params!.name,
        photo: params!.photo,
        tokenIdContact: params!.idTokenContact,
        tokenIdUser: params!.idTokenUser));
    verifyNoMoreInteractions(repository);
  });

  test('Should returns ParamsEmptyFailure if params is empty', () async {
    when(() => repository!.sendMessageToUser(
        message: params!.message,
        name: "",
        photo: params!.photo,
        tokenIdContact: "",
        tokenIdUser: "")).thenAnswer((_) async => left(ParamsEmptyFailure()));

    final result = await usecase!(Params(
        message: params!.message,
        name: "",
        photo: params!.photo,
        idTokenContact: "",
        idTokenUser: ""));

    expect(result, left(ParamsEmptyFailure()));
  });
}
