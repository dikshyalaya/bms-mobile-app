import 'package:beacon_flutter/common/extension/extension.dart';
import 'package:beacon_flutter/common/widgets/builder/ifbuilder.dart';
import 'package:beacon_flutter/features/auth/domain/auth_provider.dart';
import 'package:beacon_flutter/utils/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BeaconAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingIcon;
  final double? height;
  final String title;
  final List<Widget>? action;
  const BeaconAppBar({
    Key? key,
    this.leadingIcon,
    this.height = 56,
    this.title = "",
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 5),
      child: AppBar(
        elevation: 4,
        shadowColor: Colors.grey,
        backgroundColor: const Color(0xff4579FF),
        automaticallyImplyLeading: true,
        leadingWidth: leadingIcon == null ? 0 : 54,
        leading: IfBuilder(
          condition: leadingIcon != null,
          builder: (context) => leadingIcon!,
        ),
        centerTitle: true,
        title: Align(
          alignment:
              leadingIcon == null ? Alignment.centerLeft : Alignment.center,
          child: Padding(
            padding: leadingIcon == null
                ? const EdgeInsetsDirectional.only(top: 17, start: 14)
                : EdgeInsets.zero,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 0.013.res(context),
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        actions: [
          if (action?.isNotEmpty ?? false) ...[
            ...action!
                .map((e) => Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: leadingIcon != null ? 0 : 17),
                    child: e))
                .toList(),
            const SizedBox(
              width: 10,
            )
          ],
          Padding(
            padding: EdgeInsetsDirectional.only(
                end: 17, top: leadingIcon != null ? 0 : 17),
            child: GestureDetector(
              onTap: () async {
                //  final changePassword=
                await DialogueUtils.onProfileIconClickDialogue(
                    context: context,
                    userName:
                        "${auth.bmsUserModel?.empFirstName} ${auth.bmsUserModel?.empLastName}");
              },
              child: Image.asset(
                "profile".pngImage(),
                height: 0.04.h(context),
                width: 0.04.h(context),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 56);
}
