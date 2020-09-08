import 'package:flutter/material.dart';

// import meal
import './models/meal.dart';
// import dummy data
import './dummy_data.dart';
// import screen on flutter
import 'screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  // remove favorite
  void _toggleFavorite(String mealID) {
    final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealID);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    } else {
      _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
    }
  }

  bool _isMainFavorite(String id) {
    return _favoriteMeal.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MEALS APP',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 24,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/', //default home is /
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMainFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },

      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   if (settings.name == '/meal-detail') {
      //     return ..;
      //   } esle if(settings.name == '/someting-else'){
      //     return ...;
      //   };
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      // },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
