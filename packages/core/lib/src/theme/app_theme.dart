// ============================================================================
//  سُمّاق Design System — v1.0
//  Home Chef App · Flutter Material 3 · RTL-first
//
//  هذا الملف مطابق حرفياً لـ
//  `AI_INSTRUCTIONS/Design system reference/app_theme.dart` (المصدر المعتمد
//  للتوكِنز في هذا المشروع) — أي تعديل على قيمة هنا يجب أن يُعدَّل هناك،
//  والعكس صحيح. الفرق الوحيد عن النسخة الأصلية: الخطوط هنا تُحمَّل عبر
//  google_fonts (Alexandria/Tajawal) بدل fontFamily نصي مباشر، لأنه لا توجد
//  أصول خطوط محلية (assets) في هذا المشروع بعد — نفس المقاسات والأوزان
//  والـ line-height تماماً.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1) الألوان الخام — لا تُستخدم مباشرة في الشاشات، بل عبر ColorScheme
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  // سُمّاق — Primary
  static const sumac = Color(0xFFA83226);
  static const sumacPressed = Color(0xFF8A281E);
  static const sumacContainer = Color(0xFFFADDD7);
  static const onSumacContainer = Color(0xFF6E1A11);

  // زعتر — Secondary
  static const zaatar = Color(0xFF5A7233);
  static const zaatarContainer = Color(0xFFE4EDD3);
  static const onZaatarContainer = Color(0xFF33421A);

  // عسل — Tertiary
  static const honey = Color(0xFFB97A1E);
  static const honeyContainer = Color(0xFFF7E7CC);
  static const onHoneyContainer = Color(0xFF5F3C08);

  // الخطأ
  static const error = Color(0xFFD93025);
  static const errorContainer = Color(0xFFFCE3E0);
  static const onErrorContainer = Color(0xFF8A1D14);

  // طحينة — الأسطح الفاتحة
  static const bgLight = Color(0xFFFBF7F1);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceVariantLight = Color(0xFFF2EBE1);
  static const outlineLight = Color(0xFFD9CEC1);
  static const outlineVariantLight = Color(0xFFEAE1D6);
  static const inkLight = Color(0xFF2A211A);
  static const inkMutedLight = Color(0xFF71655B);

  // الوضع الداكن
  static const bgDark = Color(0xFF1E1712);
  static const surfaceDark = Color(0xFF271F19);
  static const surfaceVariantDark = Color(0xFF362C24);
  static const outlineDark = Color(0xFF55483D);
  static const outlineVariantDark = Color(0xFF3A2F26);
  static const inkDark = Color(0xFFEDE5DC);
  static const inkMutedDark = Color(0xFFC8BCB0);

  static const sumacDark = Color(0xFFF2A093);
  static const onSumacDark = Color(0xFF571209);
  static const sumacContainerDark = Color(0xFF7C2318);
  static const zaatarDark = Color(0xFFBDD298);
  static const onZaatarDark = Color(0xFF2A3A12);
  static const zaatarContainerDark = Color(0xFF43552A);
  static const honeyDark = Color(0xFFECC07E);
  static const onHoneyDark = Color(0xFF4A2E05);
  static const honeyContainerDark = Color(0xFF8F5C12);
  static const errorDark = Color(0xFFFFB4AB);
  static const onErrorDark = Color(0xFF690005);
  static const errorContainerDark = Color(0xFF93000A);

  // ألوان دلالية عامة (خارج ColorScheme)
  static const success = Color(0xFF337B4B);
  static const warning = Color(0xFFB7791F);
  static const info = Color(0xFF2B6CB0);
}

// ─────────────────────────────────────────────────────────────────────────────
// 2) المسافات — شبكة 4pt · لا تُستخدم أي قيمة خارج هذه القائمة
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppSpace {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16; // هوامش الشاشة الجانبية
  static const double xl = 24; // بين الأقسام
  static const double xxl = 32;

  /// حشوة قياسية داخل البطاقات
  static const cardPadding = EdgeInsets.all(14);

  /// هوامش الشاشة القياسية
  static const screenPadding = EdgeInsetsDirectional.symmetric(horizontal: l);
}

// ─────────────────────────────────────────────────────────────────────────────
// 3) نصف القطر
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppRadius {
  static const double badge = 8;
  static const double button = 12;
  static const double input = 12;
  static const double image = 12;
  static const double card = 16;
  static const double sheet = 24;
  static const double pill = 999;

  static final btnShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(button),
  );
  static final cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(card),
  );
  static const sheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(sheet)),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 4) الظلال — دافئة اللون، ليست سوداء
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppShadow {
  static const _shadowBase = Color(0xFF2B211A);

  /// بطاقات ساكنة
  static final e1 = [
    BoxShadow(
        color: _shadowBase.withValues(alpha: .06),
        blurRadius: 2,
        offset: const Offset(0, 1)),
    BoxShadow(
        color: _shadowBase.withValues(alpha: .08),
        blurRadius: 3,
        offset: const Offset(0, 1)),
  ];

  /// عناصر عائمة · تنقل سفلي
  static final e2 = [
    BoxShadow(
        color: _shadowBase.withValues(alpha: .10),
        blurRadius: 12,
        offset: const Offset(0, 4)),
  ];

  /// Sheets · Dialogs
  static final e3 = [
    BoxShadow(
        color: _shadowBase.withValues(alpha: .16),
        blurRadius: 32,
        offset: const Offset(0, 12)),
  ];
}

// ─────────────────────────────────────────────────────────────────────────────
// 5) ألوان حالات الطلب — ThemeExtension
//    الترجمة البصرية الحرفية لحالات الـ Activity Diagram
// ─────────────────────────────────────────────────────────────────────────────
@immutable
class OrderStatusColors extends ThemeExtension<OrderStatusColors> {
  const OrderStatusColors({
    required this.pending,
    required this.onPending,
    required this.inProgress,
    required this.onInProgress,
    required this.readyToDeliver,
    required this.onReadyToDeliver,
    required this.delivering,
    required this.onDelivering,
    required this.delivered,
    required this.onDelivered,
    required this.cancelled,
    required this.onCancelled,
  });

  final Color pending, onPending; // بانتظار الموافقة
  final Color inProgress, onInProgress; // قيد التحضير
  final Color readyToDeliver, onReadyToDeliver; // جاهز للتوصيل
  final Color delivering, onDelivering; // قيد التوصيل
  final Color delivered, onDelivered; // تم التسليم
  final Color cancelled, onCancelled; // مرفوض / ملغى

  static const light = OrderStatusColors(
    pending: Color(0xFFF7E7CC),
    onPending: Color(0xFF5F3C08),
    inProgress: Color(0xFFDBE8F6),
    onInProgress: Color(0xFF1D4E85),
    readyToDeliver: Color(0xFFE4EDD3),
    onReadyToDeliver: Color(0xFF33421A),
    delivering: Color(0xFFDBE8F6),
    onDelivering: Color(0xFF1D4E85),
    delivered: Color(0xFFD9EBDF),
    onDelivered: Color(0xFF1E5232),
    cancelled: Color(0xFFFCE3E0),
    onCancelled: Color(0xFF8A1D14),
  );

  static const dark = OrderStatusColors(
    pending: Color(0xFF4A3512),
    onPending: Color(0xFFF3D9A8),
    inProgress: Color(0xFF1E3A5C),
    onInProgress: Color(0xFFB9D4F2),
    readyToDeliver: Color(0xFF32411C),
    onReadyToDeliver: Color(0xFFD5E5B8),
    delivering: Color(0xFF1E3A5C),
    onDelivering: Color(0xFFB9D4F2),
    delivered: Color(0xFF1C4029),
    onDelivered: Color(0xFFB6DFC4),
    cancelled: Color(0xFF5C1A12),
    onCancelled: Color(0xFFF6C6BF),
  );

  @override
  OrderStatusColors copyWith({
    Color? pending,
    Color? onPending,
    Color? inProgress,
    Color? onInProgress,
    Color? readyToDeliver,
    Color? onReadyToDeliver,
    Color? delivering,
    Color? onDelivering,
    Color? delivered,
    Color? onDelivered,
    Color? cancelled,
    Color? onCancelled,
  }) {
    return OrderStatusColors(
      pending: pending ?? this.pending,
      onPending: onPending ?? this.onPending,
      inProgress: inProgress ?? this.inProgress,
      onInProgress: onInProgress ?? this.onInProgress,
      readyToDeliver: readyToDeliver ?? this.readyToDeliver,
      onReadyToDeliver: onReadyToDeliver ?? this.onReadyToDeliver,
      delivering: delivering ?? this.delivering,
      onDelivering: onDelivering ?? this.onDelivering,
      delivered: delivered ?? this.delivered,
      onDelivered: onDelivered ?? this.onDelivered,
      cancelled: cancelled ?? this.cancelled,
      onCancelled: onCancelled ?? this.onCancelled,
    );
  }

  @override
  OrderStatusColors lerp(OrderStatusColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return OrderStatusColors(
      pending: l(pending, other.pending),
      onPending: l(onPending, other.onPending),
      inProgress: l(inProgress, other.inProgress),
      onInProgress: l(onInProgress, other.onInProgress),
      readyToDeliver: l(readyToDeliver, other.readyToDeliver),
      onReadyToDeliver: l(onReadyToDeliver, other.onReadyToDeliver),
      delivering: l(delivering, other.delivering),
      onDelivering: l(onDelivering, other.onDelivering),
      delivered: l(delivered, other.delivered),
      onDelivered: l(onDelivered, other.onDelivered),
      cancelled: l(cancelled, other.cancelled),
      onCancelled: l(onCancelled, other.onCancelled),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6) الخطوط — Alexandria للعناوين · Tajawal للنصوص
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppFonts {
  static const display = 'Alexandria';
  static const body = 'Tajawal';
}

TextTheme _textTheme(Color ink, Color inkMuted) {
  TextStyle display(TextStyle style) => GoogleFonts.alexandria(textStyle: style);
  TextStyle body(TextStyle style) => GoogleFonts.tajawal(textStyle: style);

  return TextTheme(
    // Display — شاشات الترحيب
    displaySmall: display(TextStyle(
        fontSize: 28, fontWeight: FontWeight.w800, height: 1.35, color: ink)),
    // Headline — عنوان الشاشة
    headlineSmall: display(TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, height: 1.4, color: ink)),
    // Title — عنوان بطاقة
    titleMedium: display(TextStyle(
        fontSize: 17, fontWeight: FontWeight.w700, height: 1.45, color: ink)),
    // Body
    bodyLarge: body(TextStyle(
        fontSize: 15.5, fontWeight: FontWeight.w500, height: 1.7, color: ink)),
    bodyMedium: body(TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, height: 1.7, color: ink)),
    // Caption
    bodySmall: body(TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, height: 1.5, color: inkMuted)),
    // Label — أزرار وحقول
    labelLarge: body(TextStyle(
        fontSize: 14, fontWeight: FontWeight.w700, height: 1.2, color: ink)),
  );
}

/// أنماط خارج سلّم Material — مثل الأسعار
abstract final class AppText {
  /// الأسعار: 16 / w800 / أرقام لاتينية / لون Primary
  static TextStyle price(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Theme.of(context).colorScheme.primary,
      );

  /// السعر قبل الخصم — مشطوب
  static TextStyle priceOld(BuildContext context) => GoogleFonts.tajawal(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.lineThrough,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// 7) الـ ColorSchemes
// ─────────────────────────────────────────────────────────────────────────────
const _lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.sumac,
  onPrimary: Colors.white,
  primaryContainer: AppColors.sumacContainer,
  onPrimaryContainer: AppColors.onSumacContainer,
  secondary: AppColors.zaatar,
  onSecondary: Colors.white,
  secondaryContainer: AppColors.zaatarContainer,
  onSecondaryContainer: AppColors.onZaatarContainer,
  tertiary: AppColors.honey,
  onTertiary: Colors.white,
  tertiaryContainer: AppColors.honeyContainer,
  onTertiaryContainer: AppColors.onHoneyContainer,
  error: AppColors.error,
  onError: Colors.white,
  errorContainer: AppColors.errorContainer,
  onErrorContainer: AppColors.onErrorContainer,
  surface: AppColors.surfaceLight,
  onSurface: AppColors.inkLight,
  surfaceContainerHighest: AppColors.surfaceVariantLight,
  onSurfaceVariant: AppColors.inkMutedLight,
  outline: AppColors.outlineLight,
  outlineVariant: AppColors.outlineVariantLight,
  shadow: Color(0xFF2B211A),
  scrim: Color(0xCC2B211A),
  inverseSurface: AppColors.inkLight,
  onInverseSurface: AppColors.bgLight,
  inversePrimary: AppColors.sumacDark,
);

const _darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: AppColors.sumacDark,
  onPrimary: AppColors.onSumacDark,
  primaryContainer: AppColors.sumacContainerDark,
  onPrimaryContainer: AppColors.sumacContainer,
  secondary: AppColors.zaatarDark,
  onSecondary: AppColors.onZaatarDark,
  secondaryContainer: AppColors.zaatarContainerDark,
  onSecondaryContainer: AppColors.zaatarContainer,
  tertiary: AppColors.honeyDark,
  onTertiary: AppColors.onHoneyDark,
  tertiaryContainer: AppColors.honeyContainerDark,
  onTertiaryContainer: AppColors.honeyContainer,
  error: AppColors.errorDark,
  onError: AppColors.onErrorDark,
  errorContainer: AppColors.errorContainerDark,
  onErrorContainer: Color(0xFFFFDAD5),
  surface: AppColors.surfaceDark,
  onSurface: AppColors.inkDark,
  surfaceContainerHighest: AppColors.surfaceVariantDark,
  onSurfaceVariant: AppColors.inkMutedDark,
  outline: AppColors.outlineDark,
  outlineVariant: AppColors.outlineVariantDark,
  shadow: Colors.black,
  scrim: Color(0xE6000000),
  inverseSurface: AppColors.inkDark,
  onInverseSurface: AppColors.bgDark,
  inversePrimary: AppColors.sumac,
);

// ─────────────────────────────────────────────────────────────────────────────
// 8) الثيم الكامل
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTheme {
  static ThemeData get light => _build(
        scheme: _lightScheme,
        scaffoldBg: AppColors.bgLight,
        statusColors: OrderStatusColors.light,
      );

  static ThemeData get dark => _build(
        scheme: _darkScheme,
        scaffoldBg: AppColors.bgDark,
        statusColors: OrderStatusColors.dark,
      );

  static ThemeData _build({
    required ColorScheme scheme,
    required Color scaffoldBg,
    required OrderStatusColors statusColors,
  }) {
    final textTheme = _textTheme(scheme.onSurface, scheme.onSurfaceVariant);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffoldBg,
      textTheme: textTheme,
      fontFamily: GoogleFonts.tajawal().fontFamily,
      extensions: [statusColors],

      // ── AppBar: بلون الخلفية، بلا ظل، العنوان Alexandria
      appBarTheme: AppBarTheme(
        backgroundColor: scaffoldBg,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineSmall,
      ),

      // ── الزر الأساسي: ممتلئ سُمّاق · 48px · واحد فقط بالشاشة
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.surfaceContainerHighest,
          disabledForegroundColor: scheme.onSurfaceVariant,
          minimumSize: const Size(64, 48),
          shape: AppRadius.btnShape,
          elevation: 1,
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── الزر الثانوي: مفرّغ بحد سُمّاق — وللتدميري مرِّر error يدوياً
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary, width: 1.5),
          minimumSize: const Size(64, 48),
          shape: AppRadius.btnShape,
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(48, 48),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // ── الحقول: حد خارجي · Label طافٍ · خطأ تحت الحقل
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: scheme.outline, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: scheme.outline, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.input),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        labelStyle: textTheme.bodySmall,
        hintStyle: textTheme.bodyMedium!.copyWith(color: scheme.onSurfaceVariant),
        errorStyle: textTheme.bodySmall!.copyWith(color: scheme.error),
      ),

      // ── البطاقات
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 1,
        shadowColor: scheme.shadow.withValues(alpha: .25),
        shape: AppRadius.cardShape,
        margin: EdgeInsets.zero,
      ),

      // ── Chips: الفلاتر والـ variations
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surface,
        selectedColor: scheme.primary,
        disabledColor: scheme.surfaceContainerHighest,
        labelStyle: textTheme.bodyMedium!,
        secondaryLabelStyle: textTheme.labelLarge!.copyWith(color: scheme.onPrimary),
        side: BorderSide(color: scheme.outline, width: 1.5),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),

      // ── Bottom Sheet: زوايا 24 علوية + مقبض
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        shape: AppRadius.sheetShape,
        showDragHandle: true,
        dragHandleColor: scheme.outline,
        modalBarrierColor: scheme.scrim,
      ),

      // ── Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: textTheme.titleMedium,
        contentTextStyle:
            textTheme.bodyMedium!.copyWith(color: scheme.onSurfaceVariant),
      ),

      // ── التنقل السفلي: 4 وجهات · التبويب النشط بحبة Container
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.primaryContainer,
        height: 68,
        labelTextStyle: WidgetStatePropertyAll(textTheme.bodySmall),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? scheme.onPrimaryContainer
                : scheme.onSurfaceVariant,
          ),
        ),
      ),

      // ── Tabs (فلاتر الطلبات)
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.onSurface,
        unselectedLabelColor: scheme.onSurfaceVariant,
        indicatorColor: scheme.primary,
        labelStyle: textTheme.labelLarge,
        unselectedLabelStyle: textTheme.bodyMedium,
      ),

      // ── Switch: الأخضر = تشغيل (حالة البيع)
      switchTheme: SwitchThemeData(
        thumbColor: const WidgetStatePropertyAll(Colors.white),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.secondary
              : scheme.outline,
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : Colors.transparent,
        ),
        side: BorderSide(color: scheme.outline, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.outline,
        ),
      ),

      // ── Snackbar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.inverseSurface,
        contentTextStyle:
            textTheme.bodyMedium!.copyWith(color: scheme.onInverseSurface),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button)),
      ),

      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant,
        thickness: 1,
        space: AppSpace.l,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHighest,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// الاستخدام:
//
//   MaterialApp(
//     theme: AppTheme.light,
//     darkTheme: AppTheme.dark,
//     locale: const Locale('ar'),
//     // ...
//   );
//
//   // لون حالة طلب:
//   final st = Theme.of(context).extension<OrderStatusColors>()!;
//   Chip(backgroundColor: st.delivering, label: Text('قيد التوصيل',
//        style: TextStyle(color: st.onDelivering)));
//
//   // سعر:
//   Text('45,000 ل.س', style: AppText.price(context));
// ─────────────────────────────────────────────────────────────────────────────
