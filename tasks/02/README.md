# Snake

![snake](http://stm32f4-discovery.com/wp-content/uploads/snake.jpg)

Играли ли сте [Snake](https://en.wikipedia.org/wiki/Snake_(video_game\))?

Има една змия и със стрелките ѝ променяте посоката на движение. Целта е змията
да похапва и да става все по-голяма. Обаче ако се блъсне в стена или се захапе,
играта приключва.

Какво ви обясняваме... Естествено, че сте я играли!

В тази задача ще реализираме част от ядрото на играта. Не се плашете, по-лесно
е от колкото звучи!

## Общи

Играта се развива върху поле, което ще наричаме игрално поле. В него се движи
змията и се появява храна. Може да си го представим като координатна система с
начало в долния, ляв ъгъл.

Ще реализираме няколко функции, които или ще трансформират данни, или ще ни
дават информация за събития.

**Всяка функция ще връща нова стойност. Няма да променя подадените ѝ данни.**

## Данните

Предстои описание на данните, които ще бъдат подавани на функциите:

*   `dimensions` - хеш с два ключа - `:width` и `:height` - съответно ширината и
    височината на игралното поле. Ширината е по абсцисата (`x`), а височината е
    по ординатата (`y`). Това ще рече, че ако главата на змията се намира на
    позиция `(x, y)`, за която едно от следните е изпълнено:

    *   `x < 0` (змията се е блъснала в лявата стена)
    *   `x >= width` (змията се е блъснала в дясната стена)
    *   `y < 0` (змията се е блъснала в долната стена)
    *   `y >= height` (змията се е блъснала в горната стена)

    То змията се е блъснала в стена и играта приключва.

    **Пример:** `{width: 10, height: 10}`

*   `snake` - масив с всички последователни позиции, на които е разположена
    змията, като на последната позиция се намира главата.

    **Пример:** `[[4, 5], [4, 6], [5, 6], [5, 7]]`

*   `direction` - масив от две числа (`-1`, `0` или `1`), описващ посоката на
    движение. Първият елемент е промяната по абсцисата (`x`), а вторият - по
    ординатата (`y`). Тоест:

    * `[0, 1]` - нагоре
    * `[0, -1]` - надолу
    * `[1, 0]` - надясно
    * `[-1, 0]` - наляво

    **Забележка:** Посоката може да бъде само нагоре, надолу, наляво
    и надясно.

    **Пример:** `[0, 1]`

*   `food` - масив с всички позиции, на които има храна за ядене.

    **Пример:** `[[3, 2], [1, 1], [0, 5]]`

## Позицията пред змията

Позицията пред змията е позицията пред главата на змията в посоката на движение.
Тоест ако `snake` e `[[1, 1], [1, 2], [2, 2], [2, 3], [2, 4], [2, 5]]` и
`direction` e `[1, 0]` (надясно), то позицията пред змията е `[3, 5]`.

    y ^
      |                        Легенда:
    7 | [ ][ ][ ][ ][ ]        * - тяло на змията
    6 | [ ][ ][ ][ ][ ]        @ - глава на змията
    5 | [ ][ ][@][X][ ]        X - позиция пред змията
    4 | [ ][ ][*][ ][ ]
    3 | [ ][ ][*][ ][ ]
    2 | [ ][*][*][ ][ ]
    1 | [ ][*][ ][ ][ ]
    0 | [ ][ ][ ][ ][ ]
      ------------------->
         0  1  2  3  4   x

## Функциите

### `move`

Дефинирайте функцията `move(snake, direction)`, която приема съответниете данни
и връща **нова** змия, но преместена позиция напред: първата точка (края на змията)
от `snake` се маха, а на последно място се добавя позицията пред змията.

**Пример:**

```ruby
move([[4, 5], [4, 6], [5, 6], [5, 7]], [0, 1]) # => [[4, 6], [5, 6], [5, 7], [5, 8]]
```

### `grow`

Дефинирайте функцията `grow(snake, direction)`, която приема съответниете данни
и връща **нова**, току-що похапнала змия: първата точка (края на змията) от
`snake` **не се** маха, а на последно място се добавя позицията пред змията.

**Пример:**

```ruby
grow([[4, 6], [5, 6], [5, 7]], [0, 1]) # => [[4, 6], [5, 6], [5, 7], [5, 8]]
```

### `new_food`

Дефинирайте функцията `new_food(food, snake, dimensions)`, която приема
съответниете данни и връща позицията на нова, току-що генерирана, храна на полето.

**Позицията не трябва да бъде върху змията, друга храна или извън полето.**

**Пример:**

```ruby
new_food([[1, 2]], [[3, 4], [3, 5]], {width: 10, height: 10}) # => [5, 5]
```

### `obstacle_ahead?`

Дефинирайте функцията `obstacle_ahead?(snake, direction, dimensions)`, която приема
съответниете данни и връща:

*   `true`, ако позицията пред змията е част от змията или стена
*   `false`, иначе

**Пример:**

```ruby
obstacle_ahead?([[3, 8], [3, 9]], [0, 1], {width: 10, height: 10}) # => true
```

### `danger?`
Дефинирайте функцията `danger?(snake, direction, dimensions)`, която приема
съответниете данни и проверява дали ако змията продължава да се движи в същата
посока ще умре след един или два хода.

**Пример:**

```ruby
danger?([[3, 8], [3, 9]], [0, 1], {width: 10, height: 10}) # => true
```

## Бележки

*   Функциите **не трябва** да променят подадените им стойности!
*   Няма да подаваме невалидни данни.
*   Имате право да дефинирате и други функции, освен описаните по-горе
    задължителни такива.

## Стилови конвенции

Много държим на [стиловите конвенции](https://github.com/fmi/ruby-style-guide).
Обещаваме да бъдем строги и да ви взимаме точки, ако не ги спазвате.

## Примерни тестове

Написали сме примерни тестове, които може да намерите [в хранилището с домашните](http://github.com/fmi/ruby-homework/blob/master/tasks/02/sample_spec.rb). Как да си ги пуснете може да [видите в ръководството](/tasks/guide).
Когато проверяваме предадените решения, ще включим и допълнителни тестове.

Преди да предадете решение се уверете, че тестовете ви се изпълняват без грешки. Това ще ви гарантира, че не сте сбъркали нещо тривиално. Например да използвате низове вместо символи за ключовете на `dimensions`, или да принтирате резултат на екрана, вместо да го връщате.

**Забележка:** Няма да ви бъдат подавани грешни данни. Няма нужда да правите допълнителни проверки за некоректни аргументи или да връщате специални стойности в случай на грешка.