import 'package:freezed_annotation/freezed_annotation.dart';

part 'delivery_acceptance_event.freezed.dart';

@freezed
sealed class DeliveryAcceptanceEvent with _$DeliveryAcceptanceEvent {
  /// Loads the delivered order for [orderId] when the page opens.
  const factory DeliveryAcceptanceEvent.started(String orderId) =
      DeliveryAcceptanceStarted;

  /// Customer taps "قبول واستلام" (accept & receive).
  const factory DeliveryAcceptanceEvent.confirmReceiptRequested() =
      ConfirmReceiptRequested;

  /// Customer taps "رفض الطلب" (reject) — reveals/hides the reason panel.
  const factory DeliveryAcceptanceEvent.reportIssueToggled() =
      ReportIssueToggled;

  /// Reason textarea content changed.
  const factory DeliveryAcceptanceEvent.reasonChanged(String reason) =
      ReasonChanged;

  /// Customer taps "إرسال السبب" (submit reason).
  const factory DeliveryAcceptanceEvent.reportIssueSubmitted() =
      ReportIssueSubmitted;
}
