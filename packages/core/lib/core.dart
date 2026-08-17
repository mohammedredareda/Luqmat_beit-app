// Theme
export 'src/theme/app_theme.dart';

// Network / error handling
export 'src/network/api_client.dart';
export 'src/network/dio_client.dart';
export 'src/network/result.dart';
export 'src/network/exceptions/app_exception.dart';
export 'src/network/exceptions/exception_mapper.dart';
export 'src/network/interceptors/auth_interceptor.dart';
export 'src/network/interceptors/logging_interceptor.dart';
export 'src/network/jwt_payload.dart';

// Storage
export 'src/storage/secure_token_storage.dart';
export 'src/storage/local_cache_box.dart';
export 'src/storage/onboarding_status_store.dart';

// DI
export 'src/di/core_module.dart';

// Auth (shared between apps — login/OTP/reset-password; registration stays
// per-app since the required fields differ by role)
export 'src/auth/otp_purpose.dart';
export 'src/auth/auth_session_repository.dart';
export 'src/auth/auth_session_repository_impl.dart';

// Location (device GPS + reverse geocoding, used by registration)
export 'src/location/detected_location_entity.dart';
export 'src/location/location_repository.dart';
export 'src/location/location_repository_impl.dart';
export 'src/location/device_location_data_source.dart';
export 'src/location/detect_current_location.dart';

// Routing
export 'src/routing/go_router_refresh_stream.dart';

// l10n
export 'src/l10n/locale_cubit.dart';

// Validators
export 'src/validators/phone_validator.dart';
export 'src/validators/password_validator.dart';
export 'src/validators/image_upload_validator.dart';
export 'src/validators/note_length_validator.dart';

// Constants
export 'src/constants/session_constants.dart';
export 'src/constants/notification_constants.dart';
export 'src/constants/order_status.dart';
export 'src/constants/weekday.dart';
export 'src/constants/pagination_constants.dart';

// Pagination
export 'src/pagination/paginated_result.dart';
export 'src/pagination/pagination_state_mixin.dart';
export 'src/pagination/paginated_list_view.dart';

// Entities
export 'src/entities/user_entity.dart';
export 'src/entities/meal_entity.dart';
export 'src/entities/food_category_entity.dart';
export 'src/entities/selling_option_entity.dart';
export 'src/entities/cook_profile_entity.dart';
export 'src/entities/order_entity.dart';
export 'src/entities/order_meal_item_entity.dart';
export 'src/entities/order_offer_item_entity.dart';
export 'src/entities/order_returned_meal_item_entity.dart';
export 'src/entities/cart_entity.dart';
export 'src/entities/cart_meal_item_entity.dart';
export 'src/entities/cart_offer_item_entity.dart';
export 'src/entities/cart_returned_meal_item_entity.dart';
export 'src/entities/discount_entity.dart';
export 'src/entities/offer_entity.dart';
export 'src/entities/offer_meal_entity.dart';
export 'src/entities/returned_meal_entity.dart';
export 'src/entities/notification_entity.dart';

// Blocs
export 'src/blocs/auth/session_cubit.dart';
export 'src/blocs/auth/session_state.dart';
export 'src/blocs/connectivity/connectivity_cubit.dart';

// Shared widgets
export 'src/widgets/meal_card.dart';
export 'src/widgets/confirmation_dialog.dart';
export 'src/widgets/loading_skeleton.dart';
export 'src/widgets/empty_state.dart';
export 'src/widgets/form_section_card.dart';
export 'src/widgets/order_status_badge.dart';
export 'src/widgets/auth_card_scaffold.dart';
export 'src/widgets/auth_text_field.dart';
