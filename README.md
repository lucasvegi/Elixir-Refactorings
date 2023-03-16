# [Catalog of Elixir-specific Refactorings][Elixir Refactorings]

## Table of Contents

* __[Introduction](#introduction)__
* __[Elixir Refactorings](#elixir-refactorings)__
  * [Rename an identifier](#rename-an-identifier)
  * [Moving a definition](#moving-a-definition)
* __[About](#about)__
* __[Acknowledgments](#acknowledgments)__

## Introduction

[Elixir][Elixir] is a functional programming language whose popularity is rising in the industry <sup>[link][ElixirInProduction]</sup>. However, there are few works in the scientific literature focused on studying the internal quality of systems implemented in this language.

... TODO ...

This catalog of Elixir-specific refactorings is presented below. Each refactoring is documented using the following structure:

* __Name:__ Unique identifier of the refactoring. This name is important to facilitate communication between developers;
* __Category:__ Scope of refactoring in relation to its application coverage;
* __Motivation:__ Description of the reason why this refactoring should be done and what this refactoring does to the code;
* __Examples:__ Illustrates the resulting code from the refactoring, showing versions of it before and after the transformation;
* __Side-conditions (*):__ Minimum requirements to perform refactoring without creating conflicts with other parts of the code that may depend on the transformations promoted;
* __Mechanics (*):__ Sequence of main steps for the promoted code transformations.

__Note:__ (*) not all refactorings have explicit definitions for these fields.

This catalog of refactorings aims to improve the quality of code developed in Elixir, helping developers promote the redesign of their code, making it simpler to understand, modify, or even improving performance. These transformations must be performed without changing the original behavior, thus preserving the code's functionality. For this reason, we are interested in knowing Elixir's community opinion about these refactorings: *Do you agree that these refactorings can be useful? Have you seen any of them in production code? Do you have any suggestions about some Elixir-specific refactorings not cataloged by us?...*

Please feel free to make pull requests and suggestions ([Issues][Issues] tab). We want to hear from you!

[▲ back to Index](#table-of-contents)

## Elixir Refactorings

### Rename an identifier

* __Category:__ Traditional Refactoring.

* __Motivation:__ It's important to keep in mind that although giving good names to things may not be a simple task, good names for code structures are essential to facilitate maintenance activities promoted by humans. When the name of an identifier does not clearly convey its purpose, it should be renamed to improve the code's readability, thus avoiding a developer from wasting too much time trying to understand code developed by someone else or even developed by themselves a long time ago. In Elixir, code identifiers can be ``functions``, ``modules``, ``macros``, ``variables``, ``map/struct fields``, registered processes (e.g. ``GenServer``), ``protocols``, ``behaviours callbacks``, ``module aliases``, ``module attributes``, ``function parameters``, etc.

* __Examples:__ The following code illustrates this refactoring in the context of ``renaming functions``. Before the refactoring, we have a function ``foo/2``, which receives two parameters and returns their sum. Although it is a simple function, it is evident that its name does not clearly convey its purpose.

  ```elixir
  # Before refactoring:

  def foo(value_1, value_2) do
    value_1 + value_2
  end
  ```

  We intend to rename this function to ``sum/2``, thus highlighting its purpose. To do so, we should create a new function with this name and copy the body of the ``foo/2`` function to it. Additionally, the body of the ``foo/2`` function should be replaced by a call to the new ``sum/2`` function:

  ```elixir
  # After refactoring:

  def sum(value_1, value_2) do
    value_1 + value_2
  end

  def foo(value_1, value_2) do  #<-- must be deleted in the future!
    sum(value_1, value_2)
  end
  ```

  The ``foo/2`` function acts as a wrapper that calls ``sum/2`` and should be kept in the code temporarily, only while the calls to it throughout the codebase are gradually replaced by calls to the new ``sum/2`` function. This mitigates the risk of this refactoring generating breaking changes. When there are no more calls to the ``foo/2``, it should be deleted from its module.

* __Side-conditions:__
  * The new name should not conflict with other pre-existing names;
  
  * In the specific case of ``renaming functions``, the new function name should not conflict with other functions of the same module, nor with those imported from another module.

* __Mechanics:__ This sequence of steps may vary depending on the type of identifier that will be renamed. In the specific case of ``renaming functions``, the sequence of steps for the transformation should be as follows.

  * Check if the function being renamed was not previously defined by an Elixir ``behaviour`` or ``protocol`` implemented by the module of the function;
    * If the name was originally defined in a ``behaviour`` or ``protocol``, these transformations should be promoted at the source of that function (``behaviour`` or ``protocol``) and in all modules of the codebase that implement that source.

  * Create a new function with a name that better indicates its purpose and copy the body of the original function (with a bad name) into the new function;

  * Replace the body of the original function with a call to the new function;

  * Test your code to check for the occurrence of breaking changes;

  * For each call to the original function, replace it with a call to the new renamed function and test your code again;

  * After all calls to the original function have been replaced with the new function, and the code has been tested to verify that there are no breaking changes, it is safe to delete the original function and its definitions in a ``behaviour`` or ``protocol`` (if applicable) to complete the refactoring process.

[▲ back to Index](#table-of-contents)
___

### Moving a definition

* __Category:__ Traditional Refactoring.

* __Motivation:__ Modules in Elixir are used to group related and interdependent definitions, promoting cohesion. A definition in Elixir can be a ``function``, ``macro``, or ``struct``, for example. When a definition accesses more data or calls more functions from another module other than its own, or is used more frequently by another module, we may have less cohesive modules with high coupling. To improve maintainability by grouping more cohesive definitions in modules, these definitions should be moved between modules when identified. This refactoring helps to eliminate the [Feature Envy][Feature Envy] code smell.

* __Examples:__ The following code illustrates this refactoring in the context of ``moving functions``. Before the refactoring, we have a function ``foo/2`` from ``ModuleA``, which besides not being called by any other function in its module, only makes calls to functions from another module (``ModuleB``). This function ``foo/2``, as it is clearly misplaced in ``ModuleA``, decreases the cohesion of this module and creates an avoidable coupling with ``ModuleB``, making the codebase harder to maintain.

  ```elixir
  # Before refactoring:

  defmodule ModuleA do
    alias ModuleB, as: B
    
    def foo(v1, v2) do
      B.baz(v1, v2)
      |> B.qux()
    end

    def bar(v1) do
      ...
    end
  end

  #...Use example...
  iex(1)> ModuleA.foo(1, 2)
  ```

  ```elixir
  # Before refactoring:

  defmodule ModuleB do   
    def baz(value_1, value_2) do
      ...
    end

    def qux(value_1) do
      ...
    end
  end
  ```

  We want to move ``foo/2`` to ``ModuleB`` to improve the grouping of related functions in our codebase. To do this, we should not only copy ``foo/2`` to ``ModuleB``, but also check if ``foo/2`` depends on other resources that should also be moved or if it has references that need to be updated when the function is positioned in its new module.

  ```elixir
  # After refactoring:

  defmodule ModuleA do
    def bar(v1) do
      ...
    end
  end
  ```

  ```elixir
  # After refactoring:

  defmodule ModuleB do   
    def baz(value_1, value_2) do
      ...
    end

    def qux(value_1) do
      ...
    end

    def foo(v1, v2) do #<-- moved function!
      baz(v1, v2)
      |> qux()
    end
  end
  
  #...Use example...
  iex(1)> ModuleB.foo(1, 2)
  ```

  All calls to ``ModuleA.foo/2`` should be updated to ``ModuleB.foo/2``. When there are no more calls to ``ModuleA.foo/2`` in the codebase, it should be deleted from ``ModuleA``. In addition, ``ModuleA`` will no longer need to import functions from ``ModuleB``, since this coupling has been undone.

[▲ back to Index](#table-of-contents)
___

## About

This catalog was proposed by Lucas Vegi and Marco Tulio Valente, from [ASERG/DCC/UFMG][ASERG].

Please feel free to make pull requests and suggestions ([Issues][Issues] tab).

[▲ back to Index](#table-of-contents)

## Acknowledgments

We are supported by __[Finbits][Finbits]__<sup>TM</sup>, a Brazilian Elixir-based fintech:

<div align="center">
  <a href="https://www.finbits.com.br/" alt="Click to learn more about Finbits!" title="Click to learn more about Finbits!"><img width="20%" src="https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/finbits.png?raw=true"></a>
  <br><br>
</div>

Our research is also part of the initiative called __[Research with Elixir][ResearchWithElixir]__ (in portuguese).

[▲ back to Index](#table-of-contents)

<!-- Links -->
[Elixir Refactorings]: https://github.com/lucasvegi/Elixir-Refactorings
[Issues]: https://github.com/lucasvegi/Elixir-Refactorings/issues
[Elixir]: http://elixir-lang.org
[ASERG]: http://aserg.labsoft.dcc.ufmg.br/
[ElixirInProduction]: https://elixir-companies.com/
[jose-valim]: https://github.com/josevalim
[Finbits]: https://www.finbits.com.br/
[ResearchWithElixir]: http://pesquisecomelixir.com.br/
[Feature Envy]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#feature-envy

[ICPC-ERA]: https://conf.researchr.org/track/icpc-2022/icpc-2022-era
[preprint-copy]: https://doi.org/10.48550/arXiv.2203.08877
[ICPC22-PDF]: https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/Code-Smells-in-Elixir-ICPC22-Lucas-Vegi.pdf
[ICPC22-YouTube]: https://youtu.be/3X2gxg13tXo
[Podcast-Spotify]: http://elixiremfoco.com/episode?id=lucas-vegi-e-marco-tulio
