part of 'app_part.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case LoginScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => LoginBloc(),
              lazy: true,
              child: const LoginScreen()
            ),
        );

      case HomeScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => const HomeScreen(),
        );

      case RegisterScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => RegisterBloc(),
              child: const RegisterScreen(),
            ),
        );

      case ForgotPasswordScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => ForgotPassCubit(),
              child: const ForgotPasswordScreen()
            ),
        );

      case MultiViewScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => HomeBloc(), lazy: true),
              BlocProvider(create: (_) => MultiViewBloc(), lazy: true),
              BlocProvider(create: (_) => CustomBloc(), lazy: true),
              BlocProvider(create: (_) => BookBloc(), lazy: true),
              BlocProvider(create: (_) => WidgetChartCubit(), lazy: true),

              BlocProvider(create: (_) => CustomCateCubit(), lazy: true),
              BlocProvider(create: (_) => CustomSourceCubit(), lazy: true),
            ],
            child: const MultiViewScreen(),
          )
        );

      case CustomScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => CustomBloc(),
              child: const CustomScreen()
            )
        );

      case CustomerAddOrEditScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_)=> CustomerAddEditBloc(),
              child: const CustomerAddOrEditScreen()
            )
        );

      case NewPassScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => NewPassBloc(),
              child: const NewPassScreen()
            ),
        );

      case ChangePassScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => ChangePassCubit(),
              child: const ChangePassScreen()
            ),
        );

      case ChangeMyInfoScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => ChangeMyInfoCubit(),
              child: const ChangeMyInfoScreen(),
            ),
        );

      case SpaAddEditScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => SpaAddEditBloc(),
              child: const SpaAddEditScreen()
            ),
        );

      case BookScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => BookBloc(),
              child: const BookScreen()
            ),
        );

      case BookAddEditScreen.router:
        return CupertinoPageRoute(
            settings: settings,
            builder: (_) => BlocProvider(
              create: (_) => BookAddEditBloc(),
              child: const BookAddEditScreen()
            ),
        );

      case StaffScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_)=> StaffBloc(),
            child: const StaffScreen()
          ),
        );

      case StaffAddEditScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => WidgetDropCheckBoxCubit(), lazy: true),
              BlocProvider(create: (_) => StaffAddEditBloc(), lazy: true),
            ],
            child: const StaffAddEditScreen()
          ),
        );

      case BedRoomScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => BedRoomBloc(),
            child: const BedRoomScreen()
          ),
        );

      case ServiceScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ServiceBloc(),
            child: const ServiceScreen()
          ),
        );

      case ServiceAddEditScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ServiceAddEditCubit(),
            child: const ServiceAddEditScreen()
          ),
        );

      case ProductScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => ProductCategoryCubit()),
              BlocProvider(create: (_) => ProductCubit()),
              BlocProvider(create: (_) => ProductTrademarkCubit()),
              BlocProvider(create: (_) => ProductItemCubit()),
              BlocProvider(create: (_) => ProductPartnerCubit()),
            ],
            child: const ProductScreen(),
          ),
        );

      case ProductItemAddEditScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ProductItemAddEditBloc(),
            child: const ProductItemAddEditScreen()
          ),
        );

      case SpaScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => SpaBloc(),
            child: const SpaScreen()
          ),
        );

      case BookDetailScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => BookDetailCubit(),
            child: const BookDetailScreen()
          ),
        );

      case SubscriptionScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => SubscriptionCubit(),
            child: const SubscriptionScreen()
          ),
        );

      case OrderScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => OrderProductCubit()),
              BlocProvider(create: (_) => OrderServiceCubit()),
              BlocProvider(create: (_) => OrderTreatmentCubit()),
              BlocProvider(create: (_) => OrderCubit()),
              BlocProvider(create: (_) => OrderPrepaidCardCubit()),
            ],
            child: const OrderScreen(),
          ),
        );

      case OrderProductDetailScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => OrderProductDetailCubit(),
            child: const OrderProductDetailScreen()
          ),
        );

      case CustomCateScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => CustomCateCubit(),
            child: const CustomCateScreen()
          ),
        );

      case CustomSourceScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => CustomSourceCubit(),
            child: const CustomSourceScreen()
          ),
        );

      case OrderAddCartScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => OrderAddCartBloc(),
            child: const OrderAddCartScreen()
          ),
        );

      case OrderCreateInfoScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => OrderCreateInfoCubit(),
            child: const OrderCreateInfoScreen()
          ),
        );

      case WarehouseScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => WarehouseCubit(),
            child: const WarehouseScreen()
          ),
        );

      case WarehouseHistoryScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => WarehouseHistoryCubit(),
            child: const WarehouseHistoryScreen()
          ),
        );

      case WarehouseImportScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => WarehouseImportBloc(),
            child: const WarehouseImportScreen()
          ),
        );

      case ProductPartnerScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const ProductPartnerScreen(),
        );

      case ProductPartnerAddEditScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ProductPartnerAddEditCubit(),
            child: const ProductPartnerAddEditScreen()
          ),
        );

      case OrderServiceDetailScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => OrderServiceDetailCubit(),
            child: const OrderServiceDetailScreen()
          ),
        );

      case DiagramRoomBedScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => DiagramRoomBedCubit(),
            child: const DiagramRoomBedScreen()
          ),
        );

      case ComboTreatmentScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ComboTreatmentCubit(),
            child: const ComboTreatmentScreen()
          ),
        );

      case ComboAddEditScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => ComboAddEditCubit(),
            child: const ComboAddEditScreen()
          ),
        );

      case DebtManagementScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => DebtManagementCubit(),
            child: const DebtManagementScreen()
          ),
        );

      case DebtPaymentScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const DebtPaymentScreen(),
        );

      case PrepaidCardScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => PrepaidCardCubit(),
            child: const PrepaidCardScreen()
          ),
        );

      case PrepaidCardAddScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => PrepaidCardAddCubit(),
            child: const PrepaidCardAddScreen()
          ),
        );

      case StaffBonusAddScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => StaffBonusAddCubit(),
            child: const StaffBonusAddScreen()
          ),
        );

      case StatisticalScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => WidgetChartCubit(), lazy: true),
              BlocProvider(create: (_) => StatisticalCubit(), lazy: true),
            ],
            child: const StatisticalScreen()
          ),
        );

      case DebtAddCollectionScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => DebtAddCollectionCubit(),
            child: const DebtAddCollectionScreen()
          ),
        );

      case StaffWageAddScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => StaffWageAddCubit(),
            child: const StaffWageAddScreen()
          ),
        );

      case StaffWageDetailScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => StaffWageDetailCubit(),
            child: const StaffWageDetailScreen()
          ),
        );

      case BillCollectAddScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => BillCollectAddCubit(),
            child: const BillCollectAddScreen()
          ),
        );

      case BillSpendAddScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => BillSpendAddCubit(),
            child: const BillSpendAddScreen()
          ),
        );

      case OrderTreatmentDetailScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (_) => OrderTreatmentDetailCubit(),
            child: const OrderTreatmentDetailScreen()
          ),
        );

      case ChoseSpaScreen.router:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ChoseSpaScreen(),
        );

      default:
        return null;
    }
  }
}