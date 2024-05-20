import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites_provider.dart';

class FavouriteButton extends ConsumerStatefulWidget {
  const FavouriteButton(this.meal, {super.key});

  final Meal meal;

  @override
  ConsumerState<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends ConsumerState<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    final favouritesList = ref.watch(favouritesProvider);
    final isFavourite = favouritesList.contains(widget.meal);

    return IconButton(
      onPressed: () {
        final isAdded = ref
            .read(favouritesProvider.notifier)
            .toggleMealFavourite(widget.meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isAdded
                ? 'Added ${widget.meal.title} to favourites.'
                : 'Removed ${widget.meal.title} from favourites.'),
          ),
        );
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
            child: child,
          );
        },
        child: Icon(
          favouritesList.contains(widget.meal) ? Icons.star : Icons.star_border,
          key: ValueKey(isFavourite),
        ),
      ),
    );
  }
}
