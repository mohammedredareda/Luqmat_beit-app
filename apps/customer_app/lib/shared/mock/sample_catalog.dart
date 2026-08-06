import 'package:core/core.dart';

import '../../features/home/domain/entities/home_feed_entity.dart';

/// Shared in-memory sample data reused across every feature's mock
/// datasource, so e.g. tapping a meal on Home navigates to a Meal Details
/// screen that resolves the same meal id. There is no backend yet — this
/// is the single seam every real `*_remote_data_source.dart` will replace.
abstract final class SampleCatalog {
  static const sellingOptionSingle = SellingOptionEntity(
    id: 'so-plate',
    label: 'صحن',
    price: 45,
  );

  static final meals = <MealEntity>[
    const MealEntity(
      id: 'meal-1',
      cookId: 'cook-1',
      cookName: 'أم أحمد للمأكولات الشامية',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'مقلوبة باذنجان باللحم',
      description: 'مقلوبة بيتية بالباذنجان واللحم البلدي، تُقدَّم مع سلطة ولبن.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDWoa0Rgp9xu91ZbgeJRLs1Ju33JrcfekrLh1GgBECDmZvAGOLFSkoxM25JQN14BUKPJ9rhRFxgAkuIcfGEu8VxI5w7B-05RpSTpWwv4RoMPDavgJGXk9QTiv-ODLeUM1nZ_MMWo6LIMwUf3oPpHYRXraWtE_efxuMczBzN8TauQ9WbOZnut77Cd0-Jj-5Q3I0xR2XxYbvtEyTOwfDx-xbvQKDMe8kNSA2W0uKcN0n0gRFzoVVemAgE',
      sellingOptions: [
        SellingOptionEntity(id: 'so1', label: 'صحن', price: 45),
        SellingOptionEntity(id: 'so1-m', label: 'صحن وسط', price: 60),
        SellingOptionEntity(id: 'so1-l', label: 'صحن كبير', price: 80),
      ],
      rating: 4.8,
      ratingCount: 210,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-2',
      cookId: 'cook-2',
      cookName: 'مطبخ سلمى الفلسطيني',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'لفائف مسخن دجاج',
      description: 'لفائف مسخن الدجاج التقليدي بالسماق والبصل والصنوبر.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDHC1-ibjsMdIRBcS8SPbXFT7pcHWdCAQyS_gfkYKsfEVPPNy04Zgs-xCWAxP_5COnyZYGNWLZecOui6nECV3Vq3NT-BPBKG89wpnyJAuDuHMZM7QSFhFz8o6DMEfQ2Jr-QHxnUEAxojhCsBVFe_jOrV-31RyI8rvSbTDo2ZrO_TCMmhe9VH8t1q3ye1M-2oRAY2IcM0aPn4LLbYffnGFIET1lih9zYV3kFhCn0f_9tuJmp4HR7cjTg',
      sellingOptions: [
        SellingOptionEntity(id: 'so2', label: 'صغير', price: 22),
        SellingOptionEntity(id: 'so2-m', label: 'وسط', price: 32),
        SellingOptionEntity(id: 'so2-l', label: 'كبير', price: 42),
      ],
      rating: 4.9,
      ratingCount: 340,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-3',
      cookId: 'cook-1',
      cookName: 'أم أحمد للمأكولات الشامية',
      name: 'شوربة عدس فاخرة',
      description: 'شوربة عدس أصفر بالكمون والليمون.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA_T50-Ybv9jlSr0mmILjDvoewDTopN2b_6l9m5xFyxe_4qAtCl93ek4DWbFKBc8WDyS2fN7Cc6pyY5von8_zOwH28eSNhZ7Xt7eXyeRQJM04a6YY8gDWcsZwX8dESdnSXDhxBY06OmxFL0GHRie9mdlRMBsX1LTKIMCjowgenbZzaMLRwE-KQglr9iGJGYdxXhpcucmMfEmLbcvXhq-NaXbzu_rKuij4Dm-uuELnR_60CwvTBgpcKw',
      sellingOptions: [SellingOptionEntity(id: 'so3', label: 'صحن', price: 18)],
      rating: 4.6,
      ratingCount: 88,
      tags: ['مقبلات'],
    ),
    const MealEntity(
      id: 'meal-4',
      cookId: 'cook-3',
      cookName: 'بيت الفلافل',
      name: 'بوكس فلافل منزلي',
      description: 'بوكس فلافل طازج مقرمش مع طحينة وسلطة.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCAe2qyhOsqRpsy8jCZ3E2DIeay5GlSa9eRiAnEJrxA7nO0bM7GM9JrfnDyhL3Skpw1shfHZS4SDgYLlEPFSNnRNZIil5gn0vh-AFZrXLps6PPZby6KtdjFmJtEdns9j4wc09zFrILc5Dq4FklGfnH9L8z4LckvLu1tTU6j6MEuD3jgL0mc2EaNkkbFr8ONP2xIb3T4AlYoNhn0pXh5YXnvI1KpnEehsd61Xg2mSQL9BqU_7cwm034f',
      sellingOptions: [SellingOptionEntity(id: 'so4', label: 'بوكس', price: 20)],
      rating: 4.7,
      ratingCount: 150,
      tags: ['مقبلات'],
    ),
    // meal-5..meal-12 added for the Search & Filters feature (CU-08), which
    // needs a convincing dataset to exercise cursor pagination. Reuses the
    // image/avatar URLs above rather than inventing new remote assets.
    const MealEntity(
      id: 'meal-5',
      cookId: 'cook-1',
      cookName: 'أم أحمد للمأكولات الشامية',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'كبسة لحم بلدي',
      description: 'لحم خروف بلدي طازج مع أرز بسمتي بالبهارات الخاصة ومكسرات محمصة.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBsoiDilewsq_w2zIi7Rdy6CvKKRn3f5w9G1Ea8yes20dyhc8H604MNhpCd27Y_B6B8foUM-rWzZhTvpjUxc8OEc9-gPJJWPVgiCKcGJ4cj6Patm6qS4jGfH6_5Mw366D3AQkZ9e8NAK_pNIpOQBI-X36hBhru-yN-9GDKlZsPAFeScFYw7LBNnXXCQxNIfFOU0sZI6wCJ_3YTB4gsuFf6qkW0G0Pek7JhnqVYleOsBBtKWHVA3v5ai',
      sellingOptions: [SellingOptionEntity(id: 'so5', label: 'صحن', price: 85)],
      rating: 4.9,
      ratingCount: 260,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-6',
      cookId: 'cook-5',
      cookName: 'مطبخ عائشة',
      name: 'كبسة دجاج محمر',
      description: 'دجاج محمر بالفرن مع أرز الكبسة الشهي ودقوس حار.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuD7MlVWAjcJfA2uoJGbikCiDGMZK7KrJQ-Ev4QyGUpil6vk3eL7rmAp3-YdguwkEd-BCbnsZRYEf6eWxm--FqPtiW8XRan0uyDyjnstNVlrEc6Tr_dGrH5H4gt9A2ZAE5SkN4viuPT4uXK_izFwk-fvHGo8TikhLvZV6A3jaKc4NCfkYQh4fdNLZkXSGh7oUh4zfIOYa40mVmoxxtTMlirmOCABkF3ouT3Z5NUzxNrzUS62GVaxKpwL',
      sellingOptions: [SellingOptionEntity(id: 'so6', label: 'صحن', price: 45)],
      rating: 4.7,
      ratingCount: 190,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-7',
      cookId: 'cook-4',
      cookName: 'الشيف رامي',
      name: 'صينية كبسة عائلية',
      description: 'تكفي 5-6 أشخاص، مع 3 دجاجات كاملة وسلطات متنوعة.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAGsZUZJzcUhuSi2FB37wfjjYWL2vJy1rZlaztiSCmUsiB264CWHIg8TqRCw6c3At0e0qdzUkMvEBIPeMOz5BaI5brjdXqQD8xYcwxz7p9LevrskiUppZZC_msJ5hipzBSk0h-1AmgUJPRf58FguayCbDnm8VUAfU42mvt1NTIucFXGHeg_l43Guq0Wx4SyRLPEX1iuvNMJqE-tk5tOcRlEbLr4Ou-H7Jn5RUpTfR7G8gquvHLHZx0F',
      sellingOptions: [SellingOptionEntity(id: 'so7', label: 'صينية', price: 150)],
      rating: 4.8,
      ratingCount: 140,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-8',
      cookId: 'cook-2',
      cookName: 'مطبخ سلمى الفلسطيني',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'مسخن دجاج كامل',
      description: 'دجاجة كاملة مع خبز الطابون والسماق والبصل المحمر.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDHC1-ibjsMdIRBcS8SPbXFT7pcHWdCAQyS_gfkYKsfEVPPNy04Zgs-xCWAxP_5COnyZYGNWLZecOui6nECV3Vq3NT-BPBKG89wpnyJAuDuHMZM7QSFhFz8o6DMEfQ2Jr-QHxnUEAxojhCsBVFe_jOrV-31RyI8rvSbTDo2ZrO_TCMmhe9VH8t1q3ye1M-2oRAY2IcM0aPn4LLbYffnGFIET1lih9zYV3kFhCn0f_9tuJmp4HR7cjTg',
      sellingOptions: [SellingOptionEntity(id: 'so8', label: 'كامل', price: 60)],
      rating: 4.9,
      ratingCount: 310,
      tags: ['أطباق رئيسية'],
    ),
    const MealEntity(
      id: 'meal-9',
      cookId: 'cook-5',
      cookName: 'مطبخ عائشة',
      name: 'كنافة نابلسية',
      description: 'كنافة نابلسية أصلية بالجبنة والقطر، تُقدَّم ساخنة.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuA_T50-Ybv9jlSr0mmILjDvoewDTopN2b_6l9m5xFyxe_4qAtCl93ek4DWbFKBc8WDyS2fN7Cc6pyY5von8_zOwH28eSNhZ7Xt7eXyeRQJM04a6YY8gDWcsZwX8dESdnSXDhxBY06OmxFL0GHRie9mdlRMBsX1LTKIMCjowgenbZzaMLRwE-KQglr9iGJGYdxXhpcucmMfEmLbcvXhq-NaXbzu_rKuij4Dm-uuELnR_60CwvTBgpcKw',
      sellingOptions: [SellingOptionEntity(id: 'so9', label: 'صحن', price: 30)],
      rating: 4.9,
      ratingCount: 275,
      tags: ['حلويات'],
    ),
    const MealEntity(
      id: 'meal-10',
      cookId: 'cook-1',
      cookName: 'أم أحمد للمأكولات الشامية',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'معجنات زعتر وجبنة',
      description: 'صينية معجنات منزلية بالزعتر الأخضر والجبنة البلدية.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCAe2qyhOsqRpsy8jCZ3E2DIeay5GlSa9eRiAnEJrxA7nO0bM7GM9JrfnDyhL3Skpw1shfHZS4SDgYLlEPFSNnRNZIil5gn0vh-AFZrXLps6PPZby6KtdjFmJtEdns9j4wc09zFrILc5Dq4FklGfnH9L8z4LckvLu1tTU6j6MEuD3jgL0mc2EaNkkbFr8ONP2xIb3T4AlYoNhn0pXh5YXnvI1KpnEehsd61Xg2mSQL9BqU_7cwm034f',
      sellingOptions: [SellingOptionEntity(id: 'so10', label: 'صينية', price: 40)],
      rating: 4.6,
      ratingCount: 95,
      tags: ['معجنات'],
    ),
    const MealEntity(
      id: 'meal-11',
      cookId: 'cook-4',
      cookName: 'الشيف رامي',
      name: 'أرز بالحليب بالقرفة',
      description: 'حلا أرز بالحليب بالقرفة والفستق الحلبي، بارد ومنعش.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAAtYFtj91nDFVghdupvgvAWxE5PvulCD8SNV63CnrlmZSbtvs0iiQQ1wj3Q2DybSV2dDdEre70XKCRHH28Bi1eruFDAf_G_VyBsLyxNj_q5pxvZm6q8V3SWb0P2tJrGD6f5FgsQcvpyY8_wehMJcsewfXanO7y6b8_Z_2QGNjewf212H-RHnEC4qP4VeNoPHThcqijFZlknP0IdapdE8Gc9n8FgjRCw2l6QTnyWtsJXMaX2292FWOk',
      sellingOptions: [SellingOptionEntity(id: 'so11', label: 'كوب', price: 15)],
      rating: 4.5,
      ratingCount: 60,
      tags: ['حلويات'],
    ),
    const MealEntity(
      id: 'meal-12',
      cookId: 'cook-2',
      cookName: 'مطبخ سلمى الفلسطيني',
      cookAvatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      name: 'حمص بالطحينة',
      description: 'حمص بيتي كريمي بزيت الزيتون والصنوبر المحمص.',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDWoa0Rgp9xu91ZbgeJRLs1Ju33JrcfekrLh1GgBECDmZvAGOLFSkoxM25JQN14BUKPJ9rhRFxgAkuIcfGEu8VxI5w7B-05RpSTpWwv4RoMPDavgJGXk9QTiv-ODLeUM1nZ_MMWo6LIMwUf3oPpHYRXraWtE_efxuMczBzN8TauQ9WbOZnut77Cd0-Jj-5Q3I0xR2XxYbvtEyTOwfDx-xbvQKDMe8kNSA2W0uKcN0n0gRFzoVVemAgE',
      sellingOptions: [SellingOptionEntity(id: 'so12', label: 'صحن', price: 22)],
      rating: 4.6,
      ratingCount: 130,
      tags: ['مقبلات'],
    ),
  ];

  static MealEntity mealById(String id) =>
      meals.firstWhere((m) => m.id == id, orElse: () => meals.first);

  static final chefs = <ChefSummaryEntity>[
    const ChefSummaryEntity(
      id: 'cook-1',
      name: 'أم أحمد للمأكولات الشامية',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCkD8-eLNtXO1AAv80KI49zuHLEKWmpKgkpzppLfWgPwOGLpPeMS7FHS2ZBBdzg2ZxHE3ZgBFNgXc80yL94SoUTXYaFNskpyqxczpwjxPiu7kvSTxCi6PEqXBBgw85K4Qb7eIAKX6vn4bpfapH1wOg3vNkawROvvq44rs9OdK7pyXwEYlplWIeOk-rWyH-5mbcx6kRZysERvLSqtEYGqf2coND2JokIYPmEngY_jwEfbZ_YMd4hJ58A',
      rating: 4.9,
      ratingCount: 120,
      distanceKm: 2.4,
    ),
  ];

  static const categories = <CategoryEntity>[
    CategoryEntity(id: 'main', label: 'أطباق رئيسية', iconName: 'restaurant'),
    CategoryEntity(id: 'pastry', label: 'معجنات', iconName: 'bakery_dining'),
    CategoryEntity(id: 'dessert', label: 'حلويات', iconName: 'icecream'),
    CategoryEntity(id: 'appetizer', label: 'مقبلات', iconName: 'tapas'),
  ];

  static final discountsByMealId = <String, DiscountEntity>{
    'meal-3': DiscountEntity(
      id: 'disc-1',
      mealId: 'meal-3',
      type: DiscountType.percentage,
      value: 50,
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 5)),
    ),
    'meal-4': DiscountEntity(
      id: 'disc-2',
      mealId: 'meal-4',
      type: DiscountType.percentage,
      value: 35,
      startDate: DateTime.now().subtract(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 5)),
    ),
  };
}
