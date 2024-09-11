import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/constants/extensions.dart';
import 'package:to_do_app/models/to_do_model.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoModel toDo;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const ToDoItemWidget(
    this.toDo, {
    required this.onDelete,
    required this.onUpdate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.edgeInsetsAll,
      decoration: BoxDecoration(
        color: AppColors.darkBlueColor,
        borderRadius: 15.borderRadiusAll,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Icon(
                toDo.isDone == 0 ? Icons.close : Icons.done,
                color: AppColors.darkBlueColor,
              ),
            ),
          ),
          10.gap,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toDo.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                5.gap,
                Text(
                  toDo.subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                InkWell(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                  ),
                ),
                10.gap,
                InkWell(
                  onTap: onUpdate,
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
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
