# Volume-to-weight Converter

This app uses the values from [King Arthur Baking Company's](https://www.kingarthurbaking.com)
[Ingredient Weight Chart](https://www.kingarthurbaking.com/learn/ingredient-weight-chart) to
convert volumetric measurements to weight measurements for baking.

## Scraping the Ingredient Weight Chart Page

The better way to do this would be to create a cron job in Firebase functions.
I decided to do it the quick way.

jQuerify the page. In the console:

```javascript
var extractText, rows, values;
extractText = (row, i) => $(row).children()[i].textContent;
rows = $("table tr").slice(1).toArray();
values = rows.map((row) => ({
  ingredient: extractText(row, 0),
  volume: extractText(row, 1),
  ounces: extractText(row, 2),
  grams: extractText(row, 3),
}));
copy(values);
```

Paste the values into `data.json`.

## Volumetric measurements

The site uses the following volumes:

- cup/cups
- tablespoon/tablespoons
- teaspoon/teaspoons
- large (eggs)
- large head (garlic)

All of the volumetric measurements are whole values (integers)
or proper fractions (e.g., "1/4") except yeast, which is "2 1/4 teaspoons."

[ianmckenzie/elm-units](https://github.com/ianmackenzie/elm-units) offers easy conversions.
It has both dry and fluid US volumes. Measuring cups use fluid ounces.
