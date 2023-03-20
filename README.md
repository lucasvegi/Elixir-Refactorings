# [Catalog of Elixir-specific Refactorings][Elixir Refactorings]

## Table of Contents

* __[Introduction](#introduction)__
* __[Elixir Refactorings](#elixir-refactorings)__
  * [Rename an identifier](#rename-an-identifier)
  * [Moving a definition](#moving-a-definition)
  * [Generalise a function definition](#generalise-a-function-definition)
  * [Add or remove a parameter](#add-or-remove-a-parameter)
  * [Grouping parameters in tuple](#grouping-parameters-in-tuple)
  * [Introduce pattern matching over a parameter](#introduce-pattern-matching-over-a-parameter)
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

### Generalise a function definition

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring helps to eliminate the [Duplicated Code][Duplicated Code] code smell. In any programming language, this code smell can make the codebase harder to maintain due to restrictions on code reuse. When different functions have equivalent expression structures, that structure should be generalized into a new function, which will later be called in the body of the duplicated functions, replacing their original codes. After that refactoring, the programmer only needs to worry about maintaining these expressions in one place (generic function). The support for ``high-order functions`` in functional programming languages enhances the potential for generalizing provided by this refactoring.

* __Examples:__ In Elixir, as well as in other functional languages like Erlang and Haskell, functions are treated as first-class citizens, which means functions can be assigned to variables, making it possible to define ``high-order functions``, which are functions that take one or more functions as arguments or return a function as its result. The following code illustrates this refactoring using a high-order function. Before the refactoring, we have two functions in the ``Gen`` module. The ``foo/1`` function takes a list as an argument and transforms it in two steps. First, it squares each of its elements and then multiplies each element by 3, returning a new list. The ``bar/1`` function operates similarly, receiving a list as an argument and also transforming it in two steps. First, it doubles the value of each element in the list and then returns a list containing only the elements divisible by 4. Although these two functions transform lists in different ways, they have duplicated structures.

  ```elixir
  # Before refactoring:

  defmodule Gen do
    def foo(list) do
      list_comprehension = for x <- list, do: x * x

      list_comprehension
      |> Enum.map(&(&1 * 3))
    end

    def bar(list) do
      list_comprehension = for x <- list, do: x + x

      list_comprehension
      |> Enum.filter(&(rem(&1, 4) == 0))
    end
  end

  #...Use example...
  iex(1)> Gen.foo([1, 2, 3])  
  [3, 12, 27]

  iex(2)> Gen.bar([2, 3, 4])
  [4, 8]
  ```

  We want to generalize the functions ``foo/1`` and ``bar/1``. To do so, we must create a new function ``generic/4`` and replace the bodies of ``foo/1`` and ``bar/1`` with calls to ``generic/4``. Note that ``generic/4`` is a *__high-order function__*, since its last three arguments are functions that are called only within its body. Due to the use of high-order functions in this refactoring, we were able to create a smaller and easier-to-maintain new function than would be if we did not use this functional programming feature.

  ```elixir
  # After refactoring:

  defmodule Gen do
    def generic(list, generator_op, trans_op, trans_args) do
      list_comprehension = for x <- list, do: generator_op.(x,x)

      list_comprehension
      |> trans_op.(trans_args)
    end
    
    def foo(list) do
      # Body replaced
      generic(list, &Kernel.*/2, &Enum.map/2, &(&1 * 3))
    end

    def bar(list) do
      # Body replaced
      generic(list, &Kernel.+/2, &Enum.filter/2, &(rem(&1, 4) == 0))
    end
  end

  #...Use example...
  iex(1)> Gen.foo([1, 2, 3])  
  [3, 12, 27]

  iex(2)> Gen.bar([2, 3, 4])
  [4, 8]
  ```

  This refactoring preserved the behaviors of ``foo/1`` and ``bar/1``, without the need to modify their calls. In addition, we eliminated the duplicated code, allowing the developer to focus solely on maintaining the generic function in the ``Gen`` module. Finally, if there is a need to create a new function for transforming lists in two steps, we can possibly reuse the code from ``generic/4`` without creating new duplications.

[▲ back to Index](#table-of-contents)
___

### Add or remove a parameter

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring is used when it is necessary to request additional information from the callers of a function or the opposite situation, when some information passed by the callers is no longer necessary. The transformation promoted by this refactoring usually creates a new function with the same name as the original, but with a new parameter added or a parameter removed, and the body of the original function is replaced by a call to the new function, subsequently replacing the calls to the original function with calls to the new function. Thanks to the possibility of specifying default values for function parameters in Elixir, using the ``\\`` operator, we can simplify the mechanics of this refactoring, as shown in the following example.

* __Examples:__ The following code has a ``foo/1`` function that always adds the constant +1 to the value passed as a parameter.

  ```elixir
  # Before refactoring:

  def foo(value) do
    value + 1
  end
  ```

  We want to add a parameter to the function ``foo/1`` to generalize the constant used in the sum. To do this, we can add ``new_arg`` at the end of the parameter list, accompanied by the default value ``\\ 1``. In addition, we should modify the body of the function to use this new parameter, as shown below.

  ```elixir
  # After refactoring:

  def foo(value, new_arg \\ 1) do
    value + new_arg
  end
  ```

  Note that although we have now only explicitly implemented the ``foo/2`` function, in Elixir this definition generates two functions with the same name, but with different arities: ``foo/1`` and ``foo/2``. This will allow the callers of the original function to continue functioning without any changes. Although the example has only emphasized the addition of new parameters using default values, this feature can also be useful when we want to remove a parameter from a function, decreasing its arity. We can define a default value for the parameter to be removed when it is no longer used in the body of the function. This will keep the higher arity function callers working, even if providing an unused additional value. Additionally, new callers of the lower arity function can coexist in the codebase. When all old callers of the higher arity function are replaced by calls to the lower arity function, the parameter with the default value can finally be removed from the function without compromising any caller.

[▲ back to Index](#table-of-contents)
___

### Grouping parameters in tuple

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring can be useful to eliminate the [Long Parameter List][Long Parameter List] code smell. When functions have very long parameter lists, their interfaces can become confusing, making the code difficult to read and increasing the propensity for bugs. This refactoring concentrates on grouping a number of a function's sequential and related parameters into a ``tuple``, thereby shortening the list of parameters. The function`s callers are also modified by this refactoring to correspond to the new parameter list. ``Tuple`` is a data type supported by Elixir and is often used to group a fixed number of elements.

* __Examples:__ The following code presents the `Foo` module, composed only by the ``rand/2`` function. This function takes two values as a parameter and returns the random number present in the range defined by the two parameters. Although ``rand/2``'s parameter list is not necessarily long, try to imagine a scenario where a function has a list consisting of five or more parameters, for example. Furthermore, not always all parameters of a function can be grouped as in this example.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def rand(first, last) do
      Enum.random(first..last)
    end
  end

  #...Use examples...
  iex(1)> Foo.rand(1, 9) 
  4
  iex(2)> Foo.rand(2, 8)   
  2
  ```

  We want to find and group parameters that are related, thus decreasing the size of the list. Note that in this case, the two parameters in the list form an interval, so they are related and can be grouped to compose the function ``rand/1``, as shown below.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def rand({first, last} = group) do
      Enum.random(first..last)
    end
  end

  #...Use examples...
  iex(1)> g = {1, 9}  #<= tuple definition
  iex(2)> Foo.rand(g) 
  5
  
  iex(3)> g = {2, 8}  #<= tuple definition
  iex(4)> Foo.rand(g)   
  7

  iex(5)> g = {2, 8, 3} #<= wrong tuple definition!
  iex(6)> Foo.rand(g) 
  ** (FunctionClauseError) no function clause matching in Foo.rand/1
  ```

  The function ``rand/1`` performs pattern matching with the value of its single parameter. This, in addition to allowing the extraction of the values that make up the ``tuple``, allows for validating whether the format of the parameter received in the call is really that of the ``tuple`` of the expected length. Also, note that this refactoring updates all function callers to the new parameter list.
  
  __Important:__ Although this refactoring has grouped parameters using ``tuples``, we can find in different functions identical groups of parameters that could be grouped (i.e., Data Clumps). In that case, is better to create a ``struct`` to group these parameters and reuse this ``struct`` to refactor all functions where this group of parameters occurs.

[▲ back to Index](#table-of-contents)
___

### Introduce pattern matching over a parameter

* __Category:__ Functional Refactorings.

* __Motivation:__ Some functions have different branches that depend on the values passed to one or more parameters at call time to define the flow of execution. When these functions use classic conditional structures to implement these branches (e.g., ``if``, ``unless``, ``cond``, ``case``), they can get large bodies, becoming [Long Functions][Long Function], thus harming the maintainability of the code. This refactoring seeks to replace, when appropriate, these classic conditional structures that control the branches defined by parameter values, with pattern-matching features and multi-clause functions from functional languages such as Elixir, Erlang, and Haskell.

* __Examples:__ The following code presents the ``fibonacci/1`` function. This recursive function has three different branches that are defined by the value of its single parameter, two for its base cases and one for its recursive case. The control flow for each of these branches is done by a classic conditional structure (``case``).

  ```elixir
  # Before refactoring:

  def fibonacci(n) when is_integer(n) do
    case n do
      0 -> 0
      1 -> 1
      _ -> fibonacci(n-1) + fibonacci(n-2)
    end
  end

  #...Use examples...
  iex(1)> Foo.fibonacci(8) 
  21
  ```

  We want to replace the classic ``case`` conditional by using pattern matching on the function parameter. This will turn this function into a multi-clause function, assigning each branch to a clause. Note that in addition to reducing the size of the function body by distributing the branches across the clauses, it is not necessary to make any changes to the ``fibonacci/1`` callers, since their behavior has been preserved.

  ```elixir
  # After refactoring:

  def fibonacci(0), do: 0
  def fibonacci(1), do: 1
  def fibonacci(n) when is_integer(n) do
    fibonacci(n-1) + fibonacci(n-2)
  end

  #...Use examples...
  iex(1)> Foo.fibonacci(8) 
  21
  ```

  __Important:__ Although ``fibonacci/1`` is not a [Long Functions][Long Function] and originally has simple expressions in each of its branches, it serves to illustrate the purpose of this refactoring. Try to imagine a scenario where a function has many different branches, each of which is made up of several lines of code. This would indeed be an ideal scenario to apply the proposed refactoring.

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
[Duplicated Code]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#duplicated-code
[Long Parameter List]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#long-parameter-list
[Long Function]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#long-function

[ICPC-ERA]: https://conf.researchr.org/track/icpc-2022/icpc-2022-era
[preprint-copy]: https://doi.org/10.48550/arXiv.2203.08877
[ICPC22-PDF]: https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/Code-Smells-in-Elixir-ICPC22-Lucas-Vegi.pdf
[ICPC22-YouTube]: https://youtu.be/3X2gxg13tXo
[Podcast-Spotify]: http://elixiremfoco.com/episode?id=lucas-vegi-e-marco-tulio
