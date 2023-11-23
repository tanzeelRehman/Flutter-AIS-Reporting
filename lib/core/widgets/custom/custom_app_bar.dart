// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:get_it/get_it.dart';

// import '../../router/app_state.dart';
// import '../../utils/constants/app_assets.dart';




// class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
//   const CustomAppBar({required this.title, this.showBackButton = true, Key? key}) : super(key: key);

//   final String title;
//   final bool showBackButton;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       titleSpacing: 0.3,
//       leading: showBackButton
//           ? GestureDetector(
//               onTap: () {
//                 GetIt.I.get<AppState>().moveToBackScreen();
//               },
//               child: CircleAvatar(
//                 radius: 10.r,
//                 backgroundColor: Colors.white.withOpacity(0.85),
//                 child: Icon(Icons.chevron_left_rounded, color: Theme.of(context).primaryColor),
//               ),
//             )
//           : null,
//       title: Padding(
//         padding: EdgeInsets.only(left: showBackButton ? 0 : 20),
//         child: Text(title, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white.withOpacity(0.85))),
//       ),
//       actions: [
//         // SvgPicture.asset(AppAssets.uremitLogoSvg, width: 75.w),
//         SizedBox(width: 22.w),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
