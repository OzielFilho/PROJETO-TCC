import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/chat/send_message_emergence_with_chat.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ChatHomeRepositoryImpl extends Mock implements ChatHomeRepository {}

void main() {
  SendMessageEmergenceWithChat? usecase;
  ChatHomeRepository? repository;

  setUp(() {
    repository = ChatHomeRepositoryImpl();
    usecase = SendMessageEmergenceWithChat(repository!);
  });

  test('Should send an message if usecase return success', () async {
    when(() => repository!.sendMessageEmergenceWithChat(
        phones: ["85988245564"],
        tokenId: "8484545")).thenAnswer((_) async => right(""));

    final result = await usecase!(
        Params(contacts: ["85988245564"], idTokenUser: "8484545"));

    expect(result, right(""));
    verify(() => repository!.sendMessageEmergenceWithChat(
        phones: ["85988245564"], tokenId: "8484545"));
    verifyNoMoreInteractions(repository);
  });

  test('Should returns ParamsEmptyFailure if params is empty', () async {
    when(() =>
            repository!.sendMessageEmergenceWithChat(phones: [], tokenId: ""))
        .thenAnswer((_) async => left(ParamsEmptyFailure()));

    final result = await usecase!((Params(contacts: [""], idTokenUser: "")));

    expect(result, left(ParamsEmptyFailure()));
  });
}
