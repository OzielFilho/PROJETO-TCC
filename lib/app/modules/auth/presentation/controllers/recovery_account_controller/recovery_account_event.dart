abstract class RecoveryAccountEvent {
  const RecoveryAccountEvent();
}

class RecoveryAccountWithEmailEvent implements RecoveryAccountEvent {
  final String email;

  const RecoveryAccountWithEmailEvent({required this.email});
}
