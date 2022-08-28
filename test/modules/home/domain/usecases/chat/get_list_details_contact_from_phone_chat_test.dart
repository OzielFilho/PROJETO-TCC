import 'package:app/app/core/error/failure.dart';
import 'package:app/app/modules/home/domain/entities/details_contact_chat.dart';
import 'package:app/app/modules/home/domain/repositories/chat_home_repository.dart';
import 'package:app/app/modules/home/domain/usecases/chat/get_list_details_contact_from_phone_chat.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class ChatHomeRepositoryImpl extends Mock implements ChatHomeRepository {}

void main() {
  GetListDetailsContactFromPhoneChat? usecase;
  ChatHomeRepository? repository;
  List<DetailsContactChat>? resultUsecase;
  setUp(() {
    repository = ChatHomeRepositoryImpl();
    usecase = GetListDetailsContactFromPhoneChat(repository!);
    resultUsecase = [
      DetailsContactChat(
          email: 'oziel@hotmail.com',
          name: 'oziel',
          phone: '85985548411',
          photo: '',
          tokenId: '411515')
    ];
  });

  test('Should send an message if usecase return success', () async {
    when(() => repository!
            .getListDetailsContactFromPhoneChat(phones: ["85985548411"]))
        .thenAnswer((_) async => right(resultUsecase!));

    final result = await usecase!(["85985548411"]);

    expect(result, right(resultUsecase));
    verify(() => repository!
        .getListDetailsContactFromPhoneChat(phones: ["85985548411"]));
    verifyNoMoreInteractions(repository);
  });

  test('Should returns ListPhoneEmptyFailure if phones is empty', () async {
    when(() => repository!.getListDetailsContactFromPhoneChat(phones: []))
        .thenAnswer((_) async => left(ListPhoneEmptyFailure()));

    final result = await usecase!([]);

    expect(result, left(ListPhoneEmptyFailure()));
  });
}
