import 'package:flutter/material.dart';

class JsonBreadcrumbs extends StatelessWidget {
  final List<String> path;
  final Function(String) onPathSelected;

  const JsonBreadcrumbs({
    required this.path,
    required this.onPathSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            for (int i = 0; i < path.length; i++) ...[
              if (i > 0)
                const Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.grey,
                ),
              InkWell(
                onTap: () => onPathSelected(
                  path.sublist(0, i + 1).join('.'),
                ),
                child: Chip(
                  label: Text(path[i]),
                  backgroundColor: i == path.length - 1
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : null,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}