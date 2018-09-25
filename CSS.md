# WIP PROPOSAL

# SCSS

* Prefer SASS `@import` over Sprockets `require`, `require_tree`, and `require_self`
  As per [this documentation](https://github.com/rails/sass-rails#important-note)

  > DO NOT USE THEM IN YOUR SASS/SCSS FILES.
  > They are very primitive and do not work well with Sass files.
  > Instead, use Sass's native @import directive which sass-rails has customized to
  > integrate with the conventions of your Rails projects.

* Avoid `@extend` because it decreases maintainability

  ```sass
  // bad
  @extend .warning
  ```

# Media queries

* Avoid using third-party mixins directly
  because they make upgrading the library very hard

```scss
 // bad
  import foundation/util;
  import foundation/calc;
  @include responsive(medium up) {
    color: $orange;
  }

  // good
  @include my-responsive-wrapper(medium up) {
    color: $orange;
  }
```

## Mobile first

CSS properties are established for the *smallest breakpoint* by default. By avoiding the `only` and `down` keywords we create consistency. This consistency improves readability and leads to easier refactoring (fewer side-effects, and it is easier to add another breakpoint when they only go in one direction). And, when edge-cases happen, it is generally preferrable to show a mobile layout on a large screen, than a desktop layout on a mobile device.

```scss
// BAD
.c-menu {
  font-size: 20px;

  @include bukwoskis-responsive(small only) {
    font-size: 15px;
  }
}

// GOOD
.c-menu {
  font-size: 15px;

  @include bukwoskis-responsive(medium) {
    font-size: 20px;
  }
}
```

## Unidirectional Margins

Inspired by [this article](https://csswizardry.com/2012/06/single-direction-margin-declarations/) we try as much as we can to only use margins in one direction. This way we keep consistency when putting together a puzzle of many divs as they now relate predictably to one another.

```scss
// BAD
.c-banner {
  margin-top: 10px;
}

// GOOD
.c-banner {
  margin-bottom: 10px
}
```

You may need to divert from this rule if it makes sense. For example, a headline **usually** has a top margin and **sometimes** has none. So you default to a top margin but allow for it to be overriden. For example, if a page begins with a headline, that headline would have the class `h1.o-h.o-h--first` and all others `h2.o-h`

```scss
// GOOD
.o-h {
  margin-top: 10px;

   &--first {
     margin-top: 0;
   }
 }
```

Anecdotely, a paragraph **usually** has a bottom margin, but the **sometimes** none. You would apply `p.o-p` to all paragraphs and `p.o-p--compact` e.g. to the last one. The same is generally true for `o-button`.

```scss
// GOOD
.o-p {
  margin-bottom: 10px;

   &--compact {
     margin-bottom: 0;
   }
 }
```

# Spacing

* Prefer spacing helpers over explicit size definitions, because it increases design consistency

  ```sass
  # bad
  margin-left: 11px
  padding-top: 20px
  padding-bottom: 20px
  width: 200px
  font-size: 9px

  # good
  @include scaled-margin-left--small
  @include scaled-padding-vertical
  @include scale(width, 200px)
  @include scaled-font-size--tiny
  ```

* When defining sizes explicitly, prefer `px` over `em`/`rem` because it decreases coupling

  ```sass
  # bad
  height: 1.5em

  # better
  height: 25px

  # good
  @include scale(height, 25px)

  # exceptions allowed where it makes sense
  # and you want sizing relative to the parent
  small
    font-size: 0.8em
  ```

## Namespacing

Inspired by [this blog post](https://csswizardry.com/2015/03/more-transparent-ui-code-with-namespaces/) we prefix our CSS classes. But it's not always easy to know which prefix to use, so here are some examples.

The most difficult distinction is between **components** and **objects**. Because there are different interpretations in the community. For example, is a button a component or an object? Likewise, is a page wrapper div a component or an object? There is room for error. But since the general idea is "maintainability" and "refactorability", I suggest the following rules.

#### Components

Generally, if you change a component, it has no effect on other components or objects. That means, you can safely refactor e.g. the top-menu because you can be sure of the effects, you see exactly what's changing. Components give you most confidence when refactoring.

* `c-menu` `c-lots` `c-banner` `c-footer`
* `c-admin` `c-admin__content` (general page layout wrappers)

#### Objects

Objects alter the way an element looks, they are often inserted into components on various pages. So if you change an object, you can expect side-effects. Some button, on some page, may look terrible after your refactoring, but you maybe wouldn't notice it.

* `o-p` (paragraph, sets font-size and spacing)
* `o-h` (headline, sets font-size and spacing)
* `o-action` `o-action--edit` (e.g. for CRUD links in an admin interface)
* `o-table` (base styles for any CSS-grid-based table, e.g. for hover effects and checkboxes)
* `o-button` `o-button--positive` (this could also be a component because of it's simplicity, but then again this changes almost every page in a different way, so I consider it an object. For example, changing the margin of a button can fix one page, but break another. So it's "dangerous" enough to count as object.)

##### Utilities

You know how Bootstrap and Foundation allow you to design your page right in the HTML DOM by providing you with classes such as `position-static`, `text-dark` and `float-right`. That is an anti-pattern we're trying to get away from. All design should be in CSS not in HTML.

Utilities are vicious in that they invite you to use anti-patterns. It is very easy to add a `u-right` class to your button to have it on the right side, but don't do that, it will make our code unmaintainable. If you create a utility, you better be sure, because they will be used as a general pattern all across your page. If you can, avoid them.

There are very few legit use-cases and you should not overuse them either. A legitimate example would be that you apply a left margin to a list to separate it visually, when it is not justifiable to create a separate component or object just for this list. Or when you want to hide the mega menu on on printed pages, you could apply `u-no-print`.

* `u-no-print` (hide when printing the page)
* `u-quote` (helper to wrap a string in "quotes" with the CSS `quotes` property)
* `u-ml` (add left margin, use with care) `u-mb--large` etc.

##### Quality Assurance

Sometimes you cannot detect an element in capybara. For example, a modal JS button might be ambiguous, so you can add a one-time `qa-` class to it only so that you can test it better.

* `qa-item-not-found` `qa-dismiss-bid-button`

##### Scopes

Sometimes we don't have direct control over the HTML rendering engine. Such as when rendering markdown or third-party form or pagination helpers. You can mark these areas with a scope to indicate that you bind your design to the immediate elements in this scope.

```slim
.s-markdown
  h1 I am rendered by a third-party gem
  p Me too
```

```scss
// BAD
// This would conflict with the rest of the age
h1 {
  color: #ccc;
}

// GOOD
// Keeping the beast in a fence.
.s-markdown {
  h1 {
    color: #ccc;
  }
}

// EVEN BETTER
// If you can, get control over the rendering process and
// teach it to add CSS classes in a way we like.
.o-headline-by-markdown {
  color: #ccc;
}
```

##### Themes

A good example for a theme is that a headline sometimes uses our font and sometimes the Systembolaget font.

```slim
/ BAD
h1.o-h.u-comic-font Whiskey
h1.o-h.o-h--systembolaget

/ GOOD
h1.o-h.t-systembolaget
```

```scss
// GOOD
// This is reusable
.t-systembolaget {
  font-family: "Comic Sans";
}

// BAD
// What if we wanted to change the font of some paragraph as well?
.o-h {
  &--systembolaget
    font-family: "Comic Sans";
  }
 }
```

Do not use the `.js-` prefix, because we use data attributes instead:

  ```slim
  / bad
  a.js-trigger

  / good
  a data-trigger=true
  ```

# BEM

Consequently use BEM syntax as defined [here](http://getbem.com) and used [here](https://github.com/inuitcss/inuitcss) and blogged

* Do not style elements directly
  because it ties you to the DOM and cannot be overriden

  ```slim
  # bad
  .menu > ul
    font-weight: bold;

  # good
  .c-menu__item
    font-weight: bold;
  ```

* Do not nest CSS
  because it creates bad specificity

  ```sass
  # bad
  .nav-primary .nav-primary__item
    color: $snow-white

  # good
  .nav-primary

    &__item
      color: $snow-white
  ```

* Avoid element descendants in BEM
  because it couples DOM too tightly to CSS

  ```slim
  / bad
  .block
    .block__elem1
      .block__elem1__elem2
        . block__elem1__elem2__elem3


  / good
  .block
    .block__elem1
      .block__elem2
        . block__elem3
  ```

# Fonts

* Only use `.woff` because it has best compatibility with all browsers. We do not win much speed by *additionally* providing true type or woff2 for modern browsers but it adds complexity.

# Colors

* Give every color a prefix to distinguish them

  ```scss
  // bad
  $warning: #f00
  $headline: #333
  $blue: #00f

  // good
  $laurel-green: #070
  $maroon-red: #a00
  $carrot-orange: #f68a28
  $moon-gray: #ddd
  $snow-gray: #eee
  ```

* Prefix corporate design colors with the company name

  ```scss
  // good
  $bukowskis-granite-gray: #403f41
  $bukowskis-rose-pink: #f9cfc7
  ```
