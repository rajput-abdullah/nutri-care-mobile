import 'package:flutter/material.dart';
import '../../../../../res/assets.dart';

// Define a simple data model for meals
class Meal {
  final String mealType;
  final String foodSuggestion;
  final String time;

  Meal({
    required this.mealType,
    required this.foodSuggestion,
    required this.time,
  });
}

class FoodTimingSuggestions extends StatelessWidget {
   FoodTimingSuggestions({super.key});

  // Define a list of meals with different types, food suggestions, and times
  final List<Meal> meals = [
    Meal(
      mealType: 'Breakfast',
      foodSuggestion: 'Scrambled Eggs',
      time: '8:00 am',
    ),
    Meal(
      mealType: 'Lunch',
      foodSuggestion: 'Grilled Chicken Salad',
      time: '1:00 pm',
    ),
    Meal(
      mealType: 'Dinner',
      foodSuggestion: 'Salmon with Veggies',
      time: '7:00 pm',
    ),
    Meal(
      mealType: 'Snack',
      foodSuggestion: 'Greek Yogurt with Berries',
      time: '4:00 pm',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Food Timing Suggestions',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Image.asset(
                  Assets.lightbulb,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Eating meals at regular times improves energy levels & metabolism.',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: meals.length, // Use the length of the meals list
              itemBuilder: (context, index) {
                final meal = meals[index]; // Get the meal data for the current index
                return Container(
                  width: 183,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.timeIcon,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        meal.mealType, // Use the meal type from the data
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meal.foodSuggestion, // Use the food suggestion from the data
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  meal.time, // Use the time from the data
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              Assets.forwardArrowIcon,
                              width: 35,
                              height: 35,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}