import 'package:flutter/material.dart';
import 'package:udemy_demo_1/drawers/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Map<String, bool> currentFilter;
  final Function(Map<String, bool>) saveFilters;

  FiltersScreen(this.currentFilter, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFee = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  @override
  void initState() {
    _glutenFee = widget.currentFilter['gluten'] as bool;
    _lactoseFree = widget.currentFilter['lactose'] as bool;
    _vegetarian = widget.currentFilter['vegetarian'] as bool;
    _vegan = widget.currentFilter['vegan'] as bool;
    super.initState();
  }

  Widget _buildSwitch(
    String title,
    String description,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              widget.saveFilters({
                'gluten': _glutenFee,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              });
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFee,
                  (value) => setState(() {
                    _glutenFee = value;
                  }),
                ),
                _buildSwitch(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (value) => setState(() {
                    _lactoseFree = value;
                  }),
                ),
                _buildSwitch(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                  (value) => setState(() {
                    _vegan = value;
                  }),
                ),
                _buildSwitch(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                  (value) => setState(() {
                    _vegetarian = value;
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
