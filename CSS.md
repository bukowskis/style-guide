# WIP PROPOSAL

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

## SASS vs. SCSS

We prefer SASS syntax. The primary advantage over SCSS is that we can skip all `;` and `{` and `}`. Thus it is faster to write and easier to read without all the noise.

(In the unlikely event of defining a multiline map, create a separate `.scss` file with it as per [this suggestion](https://github.com/sass/sass/issues/1088#issuecomment-76408340) to avoid a bug in the SASS syntax interpreter)

Apart from semicolons and winged brackets, we prefer SCSS syntax. See examples below.

* Prefer `$` over `!`
  because it feels closer to CSS

  ```sass
  # bad
  !orange= #ff9900
    
  # good
  $orange: #ff9900
  ```

* Prefer `@mixin` over `=`
  because it is more readable

  ```sass
  # bad
  =shadow
    box-shadow: 4px
    
  # good
  @mixin shadow
    box-shadow: 4px
  ```
  
* Prefer `@include` over `+`
  because it is more readable

  ```sass
  # bad
  .hero
    +shadow
    
  # good
  .hero
    @include shadow
  ```

* Avoid `@extend` because it decreases maintainability

  ```sass
  # bad
  @extend .warning
  ```

## Media queries

* Avoid using third-party mixins directly
  because they make upgrading the library very hard

  ```sass
  # bad
  import foundation/util
  import foundation/calc
  @include responsive(medium up)
    color: $orange

  # good
  @include my-responsive-wrapper(medium up)
    color: $orange
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
