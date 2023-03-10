import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/size_configs.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            width: SizeConfig.screenWidth! * 0.65,
            height: SizeConfig.screenWidth! * 0.2,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Record retro music',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.quicksand(
                      color: Colors.black54,
                      fontSize: SizeConfig.screenWidth! * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '10 March, 2023',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.quicksand(
                      color: Colors.black45,
                      fontSize: SizeConfig.screenWidth! * 0.035,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  'After recording the music it should deliver by evening to the master ji in the gitvaban',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.quicksand(
                      color: Colors.black45,
                      fontSize: SizeConfig.screenWidth! * 0.035,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.transparent,
            width: SizeConfig.screenWidth! * 0.245,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: (() {}),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black54,
                  ),
                ),
                InkWell(
                  onTap: (() {}),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
