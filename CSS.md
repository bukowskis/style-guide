# WIP PROPOSAL

## SCSS

* Prefer SASS `@import` over Sprockets `require`, `require_tree`, and `require_self`
  As per [this documentation](https://github.com/rails/sass-rails#important-note)

  > DO NOT USE THEM IN YOUR SASS/SCSS FILES.
  > They are very primitive and do not work well with Sass files.
  > Instead, use Sass's native @import directive which sass-rails has customized to
  > integrate with the conventions of your Rails projects.

* Avoid `@extend` because it decreases maintainability

  ```sass
  # bad
  @extend .warning
  ```

## Media queries

* Avoid using third-party mixins directly
  because they make upgrading the library very hard

  ```scss
  # bad
  import foundation/util;
  import foundation/calc;
  @include responsive(medium up) {
    color: $orange;
  }

  # good
  @include my-responsive-wrapper(medium up) {
    color: $orange;
  }
  ```

## Spacing

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

## Namespaces

We follow [this article](https://csswizardry.com/2015/03/more-transparent-ui-code-with-namespaces/) and the corresponding [inuit framework](https://github.com/inuitcss/inuitcss#css-directory-structure) with some minor modifications as described below.

* Do not use the `.js-` prefix
  because we use data attributes instead

  ```slim
  / bad
  a.js-trigger

  / good
  a data-trigger=true
  ```

## BEM

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

## Fonts

* Only use `.woff` because it has best compatibility with all browsers. We do not win much speed by *additionally* providing true type or woff2 for modern browsers but it adds complexity.

## Colors

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
