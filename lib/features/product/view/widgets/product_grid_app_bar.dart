import 'package:bookie_buddy_web/utils/extensions/context_extensions.dart';
import 'package:bookie_buddy_web/utils/extensions/number_extensions.dart';
import 'package:bookie_buddy_web/core/ui/widgets/custom_icon_button.dart';
import 'package:bookie_buddy_web/features/product/view/add_or_edit_product_screen.dart';
import 'package:bookie_buddy_web/features/product/view_model/bloc_product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGridAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductGridAppBar({
    required this.serviceId,
    required this.name,
    super.key,
  });
  final int serviceId;
  final String name;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(name),
      actions: [
        CustomIconButton(
          height: 35.w,
          width: null,
          padding: 8.padding,
          icon: Icon(
            Icons.add,
            size: 20.sp,
          ),
          label: Text(
            'Add',
            style: TextStyle(fontSize: 14.sp),
          ),
          onTap: () async {
            await context.push(AddOrEditProductScreen(
              serviceId: serviceId,
            ));

            context
                .read<ProductBloc>()
                .add(ProductEvent.loadProducts(serviceId));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
