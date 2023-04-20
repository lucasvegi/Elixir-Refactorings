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
  * [Reorder parameter](#reorder-parameter)
  * [Extract function](#extract-function)
  * [Turning anonymous into local functions](#turning-anonymous-into-local-functions)
  * [Merging multiple definitions](#merging-multiple-definitions)
  * [Splitting a definition](#splitting-a-definition)
  * [Inline function](#inline-function)
  * [Inline macro substitution](#inline-macro-substitution)
  * [Folding against a function definition](#folding-against-a-function-definition)
  * [Extract constant](#extract-constant)
  * [Temporary variable elimination](#temporary-variable-elimination)
  * [Merge expressions](#merge-expressions)
  * [Splitting a large module](#splitting-a-large-module)
  * [Behaviour extraction](#behaviour-extraction)
  * [Behaviour inlining](#behaviour-inlining)
  * [Generate function specification](#generate-function-specification)
  * [Transforming list appends and subtracts](#transforming-list-appends-and-subtracts)
  * [Transform to list comprehension](#transform-to-list-comprehension)
  * [Nested list functions to comprehension](#nested-list-functions-to-comprehension)
  * [List comprehension simplifications](#list-comprehension-simplifications)
  * [From tuple to struct](#from-tuple-to-struct)
  * [Struct guard to matching](#struct-guard-to-matching)
  * [Struct field access elimination](#struct-field-access-elimination)
  * [Equality guard to pattern matching](#equality-guard-to-pattern-matching)
  * [Static structure reuse](#static-structure-reuse)
  * [Simplifying guard sequences](#simplifying-guard-sequences)
  * [Converts guards to conditionals](#converts-guards-to-conditionals)
  * [Eliminate single branch](#eliminate-single-branch)
  * [Simplifying nested conditional statements](#simplifying-nested-conditional-statements)
  * [Move file](#move-file)
  * [Remove dead code](#remove-dead-code)
  * [Introduce or remove a duplicate definition](#introduce-or-remove-a-duplicate-definition)
  * [Introduce overloading](#introduce-overloading)
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

* __Examples:__ In Elixir, as well as in other functional languages such as Erlang and Haskell, functions are considered as first-class citizens. This means that functions can be assigned to variables, allowing the definition of ``higher-order functions``. Higher-order functions are those that take one or more functions as arguments or return a function as a result. The following code illustrates this refactoring using a ``high-order function``. Before the refactoring, we have two functions in the ``Gen`` module. The ``foo/1`` function takes a list as an argument and transforms it in two steps. First, it squares each of its elements and then multiplies each element by 3, returning a new list. The ``bar/1`` function operates similarly, receiving a list as an argument and also transforming it in two steps. First, it doubles the value of each element in the list and then returns a list containing only the elements divisible by 4. Although these two functions transform lists in different ways, they have duplicated structures.

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

* __Examples:__ The following code has a ``foo/1`` function that always sum the constant +1 to the value passed as a parameter.

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

### Reorder parameter

* __Category:__ Traditional Refactoring.

* __Motivation:__ Although the order of parameters does not change the complexity of executing a code for the machine, when a function has parameters defined in an order that does not group similar semantic concepts, the code can become more confusing for programmers, making it difficult to read and also becoming more prone to errors during its use. When we find functions with poorly organized parameters, we must reorder them in a way that allows for better readability and meaning for programmers.

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have a function ``area/3``, responsible for calculating the area of a trapezoid. Although the body of this function is correct, the two bases of the trapezoid are not sequential parameters, so this can confuse a programmer when this function is called. The area of a trapezoid that has ``major_base`` = 24 cm, ``minor_base`` = 9 cm, and ``height`` = 15 cm equals 247.5 cm^2. In the first call of ``area/3`` in the example, the programmer imagined that the values of the bases would be the first two parameters of the function and thus had a calculation error that could easily go unnoticed.

  ```elixir
  # Before refactoring:

  def area(major_base, height, minor_base) do
    ((major_base + minor_base) * height) / 2
  end

  #...Use examples...
  iex(1)> Trapezoid.area(24, 9, 15) #<- misuse
  175.5

  iex(2)> Trapezoid.area(24, 15, 9)
  247.5
  ```

  We want to reorder the parameters of ``area/3`` to make them semantically organized. To do so, we should create a new function ``new_area/3``, which will have the parameters reordered and copy the body of the ``area/3`` to it. Additionally, the body of the ``area/3`` should be replaced by a call to the ``new_area/3``:

  ```elixir
  # After refactoring:

  def new_area(major_base, minor_base, height) do  #<-- can be renamed in the future!
    ((major_base + minor_base) * height) / 2
  end

  def area(major_base, height, minor_base) do      #<-- must be deleted in the future!
    new_area(major_base, minor_base, height)
  end

  #...Use examples...
  iex(1)> Trapezoid.new_area(24, 9, 15)
  247.5

  iex(2)> Trapezoid.area(24, 15, 9)
  247.5
  ```

  The ``area/3`` acts as a wrapper that calls ``new_area/3`` and should be kept in the code temporarily, only while the calls to it throughout the codebase are gradually replaced by calls to ``new_area/3``. This mitigates the risk of this refactoring generating breaking changes. When there are no more calls to the ``area/3``, it should be deleted from its module and ``new_area/3`` can be renamed to ``area/3`` using [Rename an identifier](#rename-an-identifier).

[▲ back to Index](#table-of-contents)
___

### Extract function

* __Category:__ Traditional Refactoring.

* __Motivation:__ For us to have code with easy readability, it is important that its purpose be clearly exposed, not requiring a developer to spend too much time to understand its purpose. Sometimes we come across functions that concentrate on many purposes and therefore become long ([Long Functions][Long Function]), making their maintenance difficult. It is common in such functions to find code comments used to explain the purpose of a sequence of lines. Whenever we encounter functions with these characteristics, we should extract these code sequences into a new function that has a name that clearly explains its purpose. In the original function, the extracted code block should be replaced by a call to the new function. This refactoring makes functions smaller and more readable, thus facilitating their maintenance.

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have a function ``ticket_booking/5``, responsible for booking an airline ticket for a passenger. All the main steps of the booking are done through a sequence of operations chained by pipe operators. After payment confirmation, the booking process is finalized by returning a tuple containing important reservation data that must be informed to the passenger. We can observe that the last 3 lines of the ``ticket_booking/5`` function are responsible for presenting a report. Note that these lines were preceded by a comment attempting to explain their purposes, highlighting that these expressions are misplaced within ``ticket_booking/5`` and even require documentation to help understand the code.

  ```elixir
  # Before refactoring:

  def ticket_booking(passenger, air_line, date, credit_card, seat) do
    {company, contact_info, cancel_policy} = check_availability(air_line, date)
                                              |> documents_validation(passenger)
                                              |> select_seat(seat)
                                              |> payment(credit_card)
    #print booking report
    IO.puts("Booking made at the company: #{company}")
    IO.puts("Any doubt, contact: #{contact_info}")
    IO.puts("For cancellations, see company policies: #{cancel_policy}")
  end
  ```

  We want to make this code more concise, reducing the size of ``ticket_booking/5`` and improving its readability. To achieve this, we should create a new function ``report/1`` that will receive a tuple as a parameter, extract the values from the tuple to variables via pattern matching, and finally present the report containing these values. In addition, the body of ``ticket_booking/5`` should be updated to include a call to ``report/1`` to replace the extracted lines of code.

  ```elixir
  # After refactoring:

  def report({company, contact_info, cancel_policy} = confirmation) do
    IO.puts("Booking made at the company: #{company}")
    IO.puts("Any doubt, contact: #{contact_info}")
    IO.puts("For cancellations, see company policies: #{cancel_policy}")
  end
  
  def ticket_booking(passenger, air_line, date, credit_card, seat) do
    check_availability(air_line, date)
    |> documents_validation(passenger)
    |> select_seat(seat)
    |> payment(credit_card)
    |> report()  #<- extracted function call!
  end
  ```

  This refactoring not only improves the readability of ``ticket_booking/5``, but also enables more code reuse, since ``report/1`` may eventually be called by other functions in the codebase.

[▲ back to Index](#table-of-contents)
___

### Turning anonymous into local functions

* __Category:__ Functional Refactorings.

* __Motivation:__ In Elixir, as well as in other functional languages like Erlang and Haskell, functions are considered as first-class citizens, which means that they can be assigned to variables. This enables the creation of anonymous functions, also called lambda functions, that can be assigned to variables and called from them. Although anonymous functions are very useful in many situations, they have less potential for reuse than local functions and cannot, for example, be exported to other modules. When we encounter the same anonymous function being defined in different points of the codebase ([Duplicated Code][Duplicated Code]), these anonymous functions should be transformed into a local function, and the locations where the anonymous functions were originally implemented should be updated to use the new local function. In functional languages, this refactoring is also referred to as lambda lifting and is a specific instance of [Extract Function](#extract-function). With this refactoring, we can reduce occurrences of duplicated code, enhancing code reuse potential.

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have two functions in the ``Lambda`` module. The ``foo/1`` function takes a list as an argument and doubles the value of each element, returning a new list. The ``bar/1`` function operates similarly, receiving a list as an argument and also doubles the value of each three elements, then returns a list. Note that both local functions ``foo/1`` and ``bar/1`` internally define the same anonymous function ``fn x -> x * 2 end`` for doubling the desired list values.

  ```elixir
  # Before refactoring:

  defmodule Lambda do
    def foo(list) do
      Enum.map(list, fn x -> x * 2 end)
    end

    def bar(list) do
      Enum.map_every(list, 3, fn x -> x * 2 end)
    end
  end

  #...Use examples...
  iex(1)> Lambda.foo([1, 2, 3])
  [2, 4, 6]

  iex(2)> Lambda.bar([3, 4, 5, 6, 7, 8, 9])
  [6, 4, 5, 12, 7, 8, 18]
  ```

  We want to avoid the duplicated implementation of anonymous functions. To achieve this, we will create a new local function ``double/1``, responsible for performing the same operation previously performed by the duplicated anonymous functions. In addition, the Elixir capture operator (``&``) will be used in the places of ``foo/1`` and ``bar/1`` which originally implement anonymous functions, to replace their use with the new local function ``double/1``.

  ```elixir
  # After refactoring:

  defmodule Lambda do
    def double(x) do  #<- lambda lifted to a local function!
      x * 2
    end

    def foo(list) do
      Enum.map(list, &double/1)
    end

    def bar(list) do
      Enum.map_every(list, 3, &double/1)
    end
  end

  #...Use examples...
  iex(1)> Lambda.foo([1, 2, 3])
  [2, 4, 6]

  iex(2)> Lambda.bar([3, 4, 5, 6, 7, 8, 9])
  [6, 4, 5, 12, 7, 8, 18]
  ```

  Note that although in this example the new local function ``double/1``, defined to replace the duplicated anonymous functions, was only used in the ``Lambda`` module, nothing prevents it from being reused in other parts of the codebase, as ``double/1`` can be imported by any other module.

[▲ back to Index](#table-of-contents)
___

### Merging multiple definitions

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring is also an option for removing [Duplicated Code][Duplicated Code] and can optimize a codebase by sharing that code in a single location, avoiding multiple traversals over the same data structure. There are situations where a codebase may have distinct functions that are complementary. Because they are complementary, these functions may have identical code snippets. When identified, these functions should be merged into a new function that will simultaneously perform the processing done by the original functions separately. The new function created by this refactoring will always return a tuple, where each original return provided by the merged functions will be contained in different elements of the tuple returned by the new function. In functional languages, this refactoring is also referred to as ``tupling``.

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have two functions in the ``MyList`` module. The ``take/2`` function takes an integer value ``n`` and a list as parameters, returning a new list composed of the first ``n`` elements of the original list. The ``drop/2`` function also takes an integer value ``n`` and a list as parameters, but ignores the first ``n`` elements of the original list, returning a new list composed of the remaining elements. Note that although ``take/2`` and ``drop/2`` return different values, they are complementary multi-clause functions and therefore have many nearly identical code snippets.

  ```elixir
  # Before refactoring:

  defmodule MyList do
    def take(0, _), do: []
    def take(_, []), do: []
    def take(n, [h | t]) when n > 0 do
      [h | take(n-1, t)]
    end
    def take(_, _), do: :error_take_negative

    def drop(0, list), do: list
    def drop(_, []), do: []
    def drop(n, [h | t]) when n > 0 do
      drop(n-1, t)
    end
    def drop(_, _), do: :error_drop_negative
  end

  #...Use examples...
  iex(1)> list = [1, 2, 3, 4, 5 , 6]
  
  iex(2)> MyList.take(2, list)
  [1, 2]

  iex(3)> MyList.drop(2, list) 
  [3, 4, 5, 6]
  ```

  If we analyze the examples of using the code above, we can clearly see how these functions are complementary. Both received the same list as a parameter and by joining the lists returned by them, we will have the same elements of the original list, in other words, it is as if we had split the original list after the second element and ignored one of the two sub-lists in each of the functions.
  
  Thinking about this, we can merge these two complementary functions into a new function called ``split_at/2``. This function will remove duplicate expressions by introducing code sharing. In addition, it will return a tuple composed of two elements. The first element will contain the value that would originally be returned by ``take/2`` and the second element will contain the value that would be returned by ``drop/2``.

  ```elixir
  # After refactoring:

  defmodule MyList do
    def take(0, _), do: []        #<- can be deleted in the future!
    def take(_, []), do: []
    def take(n, [h | t]) when n > 0 do
      [h | take(n-1, t)]
    end
    def take(_, _), do: :error_take_negative

    def drop(0, list), do: list   #<- can be deleted in the future!
    def drop(_, []), do: []
    def drop(n, [h | t]) when n > 0 do
      drop(n-1, t)
    end
    def drop(_, _), do: :error_drop_negative

    # Merging take and drop!
    def split_at(0, list), do: {[], list}
    def split_at(_, []), do: {[], []}
    def split_at(n, [h | t]) when n > 0 do
      {ts, zs} = split_at(n-1, t)
      {[h | ts], zs}
    end
    def split_at(_, _), do: {:error_take_negative, :error_drop_negative}
  end

  #...Use examples...
  iex(1)> list = [1, 2, 3, 4, 5 , 6]
  
  iex(2)> MyList.split_at(2, list)
  {[1, 2], [3, 4, 5, 6]}
  ```

  In the refactored code above, we kept the functions ``take/2`` and ``drop/2`` in the ``MyList`` module just so the reader could more easily compare how this merge allowed code sharing. They were not modified. From a practical point of view, the calls to ``take/2`` and ``drop/2`` can be replaced by calls to ``split_at/2``, with their respective returns being extracted via pattern matching, as in the example below:

  ```elixir
  iex(1)> {take, drop} = MyList.split_at(2, [1,2,3,4,5,6])

  iex(2)> take
  [1, 2]

  iex(3)> drop
  [3, 4, 5, 6]
  ```

  The functions ``take/2`` and ``drop/2`` can be deleted from ``MyList`` once all their calls have been replaced by calls to ``split_at/2``.

  These examples are based on Haskell code written in two papers. Source: [[1]](https://dl.acm.org/doi/10.1145/1706356.1706378), [[2]](https://www.cs.kent.ac.uk/pubs/2010/3009/index.html).

[▲ back to Index](#table-of-contents)
___

### Splitting a definition

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring is the inverse of [Merging multiple definitions](#merging-multiple-definitions). While merge multiple definitions aims to group recursive functions into a single recursive function that returns a tuple, splitting a definition aims to separate a recursive function by creating new recursive functions, each of them responsible for individually generating a respective element originally contained in a tuple.

* __Examples:__ Take a look at the example in [Merging multiple definitions](#merging-multiple-definitions) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

### Inline function

* __Category:__ Traditional Refactoring.

* __Motivation:__ This refactoring is the inverse of [Extract Function](#extract-function). We typically extract functions to reduce their size, making them more readable and easier to maintain. However, in some situations, the body of a function basically just delegates to the call of another function. In these cases, the purpose of the function body is as clear as its name, and there is no benefit in keeping the declaration of this function. In fact, excessive delegation may create code with very indirect execution flows that are difficult to debug. In these situations, an inline function can be used, replacing all calls to the function with its body, and then getting rid of the function.

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have a module called ``Order`` composed of the private function ``sum_list/1`` and the public function ``get_amount/1``. The function ``get_amount/1`` receives a list of items in an order and delegates the sum of all item values to the ``sum_list/1`` function. As we can see, the ``sum_list/1`` function simply calls the ``Enum.sum/1`` function provided natively by Elixir, thus being an example of excessive and unnecessary delegation.

  ```elixir
  # Before refactoring:

  defmodule Order do
    defp sum_list(list) do
      Enum.sum(list)
    end
    
    def get_amount(order_itens) do
      sum_list(order_itens)
    end
  end
  ```

  To eliminate the excessive delegation generated by the ``sum_list/1`` function, we will replace all calls to ``sum_list/1`` with its body. Then, we can delete the ``sum_list/1`` function from the ``Order`` module since it will no longer be necessary.

  ```elixir
  # After refactoring:

  defmodule Order do    
    def get_amount(order_itens) do
      Enum.sum(order_itens)  #<- inlined function!
    end
  end
  ```

  This refactoring preserves the behavior of the function and will make it easier for the programmer to debug the code.

[▲ back to Index](#table-of-contents)
___

### Inline macro substitution

* __Category:__ Functional Refactorings.

* __Motivation:__ ``Macros`` are powerful meta-programming mechanisms that can be used in Elixir, as well as other functional languages like Erlang and Clojure, to extend the language. However, when a macro is implemented to solve problems that could be solved by functions or other pre-existing language structures, the code becomes unnecessarily more complex and less readable. Therefore, when identifying unnecessary macros that have been implemented, we can replace all instances of these macros with the code defined in their bodies. Some code compensations will be necessary to ensure that they continue to perform properly after refactoring. This refactoring is a specialization of the [Inline function](#inline-function) and can be used to remove the code smell [Unnecessary Macros][Unnecessary Macros].

* __Examples:__ The following code illustrates this refactoring. Before the refactoring, we have a macro ``sum_macro/2`` defined in the ``MyMacro`` module. This macro is used by the ``bar/2`` function in the ``Foo`` module, unnecessarily complicating the code's readability.

  ```elixir
  # Before refactoring:

  defmodule MyMacro do
    defmacro sum_macro(v1, v2) do
      quote do
        unquote(v1) + unquote(v2)
      end
    end
  end
  ```

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      require MyMacro
      MyMacro.sum_macro(v1, v2)
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(2, 3)            
  5
  ```

  To eliminate the unnecessary macro ``MyMacro.sum_macro/2``, we will replace all its calls with its body, making some code adjustments. Then, we can delete ``MyMacro.sum_macro/2`` since it will no longer be used.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      v1 + v2   #<- inlined macro!
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(2, 3)            
  5
  ```

[▲ back to Index](#table-of-contents)
___

### Folding against a function definition

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring can be used in the context of removing [Duplicated Code][Duplicated Code], replacing a set of expressions with a call to an existing function that performs the same processing as the duplicated code. The opportunity to apply this refactoring may occur after the chained execution of the [Extract function](#extract-function) and [Generalise a function definition](#generalise-a-function-definition) refactorings. After generalizing a function that has been previously extracted, it is possible that there may still be some code snippets in the codebase that are duplicated with the generalized function. This refactoring aims to, from a source function, find code that is duplicated in relation to it and replace the duplications with calls to the source function. Some adaptations in these new call points to the source function may be necessary to preserve the code's behavior.

* __Examples:__ The following code exemplifies this refactoring. Before the refactoring, we have a ``Class`` module composed of two functions. The function ``report/1`` was previously extracted from a code snippet not shown in this example. Later, this extracted function was generalized, resulting in its current format. The function ``improve_grades/3`` already existed in the ``Class`` module before ``report/1`` was generated through refactoring. Note that ``improve_grades/3`` has code snippets that are duplicated with ``report/1``.

  ```elixir
  # Before refactoring:

  defmodule Class do
    defstruct [:id, :grades, :avg, :worst, :best]

    def report(list) do  #<- Generated after extraction and generalisation!
      avg = Enum.sum(list) / length(list)
      {min, max} = Enum.min_max(list)
      {avg, min, max}
    end

    def improve_grades(class_id, grades, students_amount) do
      high_grade = Enum.max(grades)
      adjustment_factor = 100 / high_grade
      new_grades = Enum.map(grades, &(&1 * adjustment_factor) |> Float.round(2))

      grades_avg = Enum.sum(new_grades) / students_amount   #<- duplicated code
      {w, b} = Enum.min_max(new_grades)                     #<- duplicated code

      %Class{id: class_id, grades: new_grades, avg: grades_avg, worst: w, best: b}
    end
  end

  #...Use examples...
  iex(1)> Class.improve_grades(:software_engineering, [26, 49, 70, 85, 20, 75, 74, 15], 8)
  %Class{
    id: :software_engineering,
    grades: [30.59, 57.65, 82.35, 100.0, 23.53, 88.24, 87.06, 17.65],
    avg: 60.88375,
    worst: 17.65,
    best: 100.0
  }
  ```

  We want to eliminate the duplicated code in ``improve_grades/3``. To achieve this, we can replace the duplicated code snippet with a call to ``report/1``. Note that some adaptations to the function call that will replace the duplicated code may be necessary.

  ```elixir
  # After refactoring:

  defmodule Class do
    defstruct [:id, :grades, :avg, :worst, :best]

    def report(list) do 
      avg = Enum.sum(list) / length(list)
      {min, max} = Enum.min_max(list)
      {avg, min, max}
    end

    def improve_grades(class_id, grades, students_amount) do
      high_grade = Enum.max(grades)
      adjustment_factor = 100 / high_grade
      new_grades = Enum.map(grades, &(&1 * adjustment_factor) |> Float.round(2))

      {grades_avg, w, b} = report(new_grades) #<- Folding against a function definition!

      %Class{id: class_id, grades: new_grades, avg: grades_avg, worst: w, best: b}
    end
  end

  #...Use examples...
  iex(1)> Class.improve_grades(:software_engineering, [26, 49, 70, 85, 20, 75, 74, 15], 8)
  %Class{
    id: :software_engineering,
    grades: [30.59, 57.65, 82.35, 100.0, 23.53, 88.24, 87.06, 17.65],
    avg: 60.88375,
    worst: 17.65,
    best: 100.0
  }
  ```

  Also note that in this example, after the refactoring is done, the third parameter of the ``improve_grades/3`` function is no longer used in the function body. This is an opportunity to apply the [Add or remove parameter](#add-or-remove-a-parameter) refactoring.

[▲ back to Index](#table-of-contents)
___

### Extract constant

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring aims to improve code readability and maintainability. When we use meaningless numbers (magic numbers) directly in expressions, code comprehension can become more complex for humans. Additionally, if the same meaningless number is scattered throughout the codebase and needs to be modified in the future, it can generate a significant maintenance burden, increasing the risk of bugs. To improve the code, this refactoring seeks to create a constant with a meaningful name for humans and replace occurrences of the meaningless number with the extracted constant.

* __Examples:__ The following code provides an example of this refactoring. Prior to the refactoring, we had a ``Circle`` module consisting of two functions. Both functions used the magic number ``3.14``. Although this example contains simple code that may not seem to justify the developer's concern with extracting constants, try to imagine a more complex scenario involving larger and non-trivial code that makes more extensive use of these meaningless numbers. This could cause a lot of headache for a developer.

  ```elixir
  # Before refactoring:

  defmodule Circle do
    def area(r) do 
      3.14 * r ** 2
    end

    def circumference(r) do
      2 * 3.14 * r
    end
  end

  #...Use examples...
  iex(1)> Circle.area(3)
  28.26
  
  iex(2)> Circle.circumference(3)
  18.84
  ```

  To improve the comprehension of this code and make it easier to maintain, we can create a ``module attribute`` with a human-readable name (``@pi``) and replace the numbers with the use of this attribute.

  ```elixir
  # After refactoring:

  defmodule Circle do
    @pi 3.14    #<- extracted constant!

    def area(r) do 
      @pi * r ** 2
    end

    def circumference(r) do
      2 * @pi * r
    end
  end

  #...Use examples...
  iex(1)> Circle.area(3)
  28.26
  
  iex(2)> Circle.circumference(3)
  18.84
  ```

  This not only gives meaning to the number but also facilitates maintenance in case it needs to be changed. In the case of ``@pi``, if we wish to improve the precision of the calculations by adding more decimal places to its value, this can be easily done in the refactored code.

[▲ back to Index](#table-of-contents)
___

### Temporary variable elimination

* __Category:__ Traditional Refactorings.

* __Motivation:__ This is a refactoring motivated by the compiler optimization technique known as copy propagation. Copy propagation is a transformation that, for an assignment of the form ``a`` = ``b``, replaces uses of the variable ``a`` with the value of the variable ``b``, thus eliminating redundant computations. This refactoring can be very useful for eliminating temporary variables that are responsible only for storing results to be returned by a function, or even intermediate values used during processing.

* __Examples:__ The following code provides an example of this refactoring. Prior to the refactoring, we have a function ``bar/2`` that takes an integer value ``b`` and a ``list`` as parameters. The function returns a tuple containing two elements, the first of which is the value contained in the index ``c`` of the ``list`` and the second of which is the sum of all elements in a modified version of the ``list``.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(b, list) when is_integer(b) do
      a = b * 2
      c = a
      result_1 = Enum.at(list, c)
      r = a
      result_2 = Enum.map(list, &(&1 + r))
                |> Enum.sum()

      {result_1, result_2}
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(2, [1, 2, 3, 4, 5, 6])
  {5, 45}
  ```

  To perform this processing, the code above makes excessive and unnecessary use of temporary variables. As shown below, after the refactoring, these temporary variables will be replaced by their values and subsequently removed when they are no longer used in any location.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(b, list) when is_integer(b) do
      { Enum.at(list, b * 2),
        Enum.map(list, &(&1 + b * 2)) |> Enum.sum() }
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(2, [1, 2, 3, 4, 5, 6])
  {5, 45}
  ```

  This refactoring can promote a significant simplification of some code, as well as avoid redundant computations that can harm performance.

[▲ back to Index](#table-of-contents)
___

### Merge expressions

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring, in a way, behaves as the inverse of [Temporary variable elimination](#temporary-variable-elimination). When programming, we may sometimes come across unavoidably large and hard-to-understand expressions. With this refactoring, we can break down those expressions into smaller parts and assign them to local variables with meaningful names, thus facilitating the overall understanding of the code. In addition, this refactoring can help eliminate [Duplicated Code][Duplicated Code], as the variables extracted from the expressions can be reused in various parts of the codebase, avoiding the need for repetition of long expressions.

* __Examples:__ The following code provides an example of this refactoring. Prior to the refactoring, we have a module ``Bhaskara`` composed of the function ``solve/3``, responsible for finding the roots of a quadratic equation. This function returns a tuple with the roots or their non-existence.

  ```elixir
  # Before refactoring:

  defmodule Bhaskara do
    
    def solve(a, b, c) do
      if b*b - 4*a*c < 0 do
        {:error, "No real roots"}
      else
        x1 = (-b + (b*b - 4*a*c) ** 0.5) / (2*a)
        x2 = (-b - (b*b - 4*a*c) ** 0.5) / (2*a)
        {:ok, {x1, x2}}
      end
    end

  end

  #...Use examples...
  iex(1)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(2)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(3)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
  ```

  Note that in this function, besides the expression ``b*b - 4*a*c`` being repeated several times, including within a larger expression, the lack of meaning for ``b*b - 4*a*c`` can make the code less readable. We can solve this by extracting a new variable ``delta``, assigning ``b*b - 4*a*c`` to this new variable, and replacing all instances of this expression with the use of the ``delta`` variable.

  ```elixir
  # After refactoring:

  defmodule Bhaskara do
    
    def solve(a, b, c) do
      delta = (b*b - 4*a*c) #<- extracted variable!

      if delta < 0 do
        {:error, "No real roots"}
      else
        x1 = (-b + delta ** 0.5) / (2*a)
        x2 = (-b - delta ** 0.5) / (2*a)
        {:ok, {x1, x2}}
      end
    end

  end

  #...Use examples...
  iex(1)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(2)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(3)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
  ```

  __Recalling previous refactorings:__ Although the refactored code shown above has made the code more readable, it still has opportunities for applying other refactorings previously documented in this catalog. Note that for the calculation of the roots, we have two lines of code that are practically identical. In addition, we have two temporary variables (``x1`` and ``x2``) that have only the purpose of storing results that will be returned by the function. If we take this refactored version of the code after applying [Merge expressions](#merge-expressions) and apply a composite refactoring with the sequence of [Extract function](#extract-function) -> [Generalise a function definition](#generalise-a-function-definition) -> [Fold against a function definition](#folding-against-a-function-definition) -> [Temporary variable elimination](#temporary-variable-elimination), we can arrive at the following version of the code:
  
  ```elixir
  # After a composite refactoring:

  defmodule Bhaskara do
    
    defp root(a, b, delta, operation) do
      operation.(-b, delta ** 0.5) / (2*a)
    end

    def solve(a, b, c) do
      delta = (b*b - 4*a*c)

      if delta < 0 do
        {:error, "No real roots"}
      else
        {:ok, {root(a,b,delta,&Kernel.+/2), root(a,b,delta,&Kernel.-/2)}}
      end
    end

  end

  #...Use examples...
  iex(1)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(2)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(3)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
  ```

[▲ back to Index](#table-of-contents)
___

### Splitting a large module

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring can be used as a solution for removing the code smell [Large Module][Large Module], also known as Large Class in object-oriented languages. When a module in Elixir code does the work of two or more, it becomes large, poorly cohesive, and difficult to maintain. In these cases, we should split this module into several new ones, moving to each new module only the attributes and functions with purposes related to their respective goals.

* __Examples:__ The code example below demonstrates the application of this refactoring technique. In this case, the ``ShoppingCart`` module is excessively large and lacks cohesion, as it combines functions related to at least four distinct and unrelated business rules.

  ```elixir
  # Before refactoring:

  defmodule ShoppingCart do
    # Rule 1
    def calculate_total(items, subscription) do
      # ...
    end
    
    # Rule 1
    def calculate_shipping(zip_code, %{id: 3}), do: 0.0
    def calculate_shipping(zip_code, %{id: 4}), do: 0.0
    def calculate_shipping(zip_code, _), do
      10.0 * Location.calculate(zip_code)
    end
    
    # Rule 2
    def apply_discount(total, %{id: 3}), do: total * 0.9
    def apply_discount(total, %{id: 4}), do: total * 0.9
    def apply_discount(total, _), do: total

    # Rule 3
    def send_message_subscription(%{id: 3}, _), do: nil
    def send_message_subscription(%{id: 4}, _), do: nil
    def send_message_subscription(subscription, user), do: # something
    
    # Rule 4
    def report(user, order) do
      # ...
    end
  end
  ```

  Applying this refactoring three times, ``ShoppingCart`` can be splitted, and some of its functions could be moved to other new modules (``Item``, ``Subscription``, and ``Util``), thus increasing the codebase overall cohesion.
  
  ```elixir
  # After refactoring:

  defmodule ShoppingCart do
    # Rule 1
    def calculate_total(items, subscription) do
      # ...
    end
    
    # Rule 1
    def calculate_shipping(zip_code, %{id: 3}), do: 0.0
    def calculate_shipping(zip_code, %{id: 4}), do: 0.0
    def calculate_shipping(zip_code, _), do
      10.0 * Location.calculate(zip_code)
    end
  end
  ```

  ```elixir
  # After refactoring:

  defmodule Item do    
    # Rule 2
    def apply_discount(total, %{id: 3}), do: total * 0.9
    def apply_discount(total, %{id: 4}), do: total * 0.9
    def apply_discount(total, _), do: total
  end
  ```

  ```elixir
  # After refactoring:

  defmodule Subscription do    
    # Rule 3
    def send_message_subscription(%{id: 3}, _), do: nil
    def send_message_subscription(%{id: 4}, _), do: nil
    def send_message_subscription(subscription, user), do: # something
  end
  ```

  ```elixir
  # After refactoring:

  defmodule Util do    
    # Rule 4
    def report(user, order) do
      # ...
    end
  end
  ```
  
  Each application of this refactoring involves creating a new module, selecting the set of definitions that should be moved to that new module, and applying the [Moving a definition](#moving-a-definition) refactoring to each of those selected definitions. Any reference and dependency issues inherent in moving functions between modules are compensated for by the [Moving a definition](#moving-a-definition) refactoring. Although this does not happen in the above example, in some cases, after splitting an original module into several smaller and more cohesive modules, the name of the original module can no longer makes sense, providing an opportunity to also apply the [Rename an identifier](#rename-an-identifier) refactoring.
  
[▲ back to Index](#table-of-contents)
___

### Behaviour extraction

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring is similar to Extract Interface, proposed by Fowler and Beck for object-oriented languages. In Elixir, a ``behaviour`` serves as an interface, which is a contract that a module can fulfill by implementing functions in a guided way according to the formats of parameters and return types defined in the contract. A ``behaviour`` is an abstraction that defines only the functionality to be implemented, but not how that functionality is implemented. When we find a function that can be repeated in different modules, but performing special roles in each of them, it can be a good idea to abstract this function by extracting it to a ``behaviour``, standardizing a contract to be followed by all modules that implement or may implement it in the future.

* __Examples:__ The following code example illustrates the use of this refactoring technique. In this case, the module ``Foo`` has two functions. The function ``print_result/2`` has a generic behavior, that is, it simply displays the result of an operation. On the other hand, the function ``math_operation/2`` has a special role in this module, which is to attempt to sum two numbers and return a tuple that may have the operation's result or an error if invalid parameters are passed to the function call.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def math_operation(a, b) when is_number(a) and is_number(b) do
      {:ok, a + b}
    end
    def math_operation(_, _), do: {:error, "args not numeric"}

    def print_result(a, b) do
      {_, r} = math_operation(a, b)
      IO.puts("Operation result: #{r}")
    end
  end

  #...Use examples...
  iex(1)> Foo.math_operation(1, 2)   
  {:ok, 3}
  
  iex(2)> Foo.math_operation(1, "lucas")
  {:error, "args not numeric"}
  
  iex(3)> Foo.print_result(1, 2)        
  Operation results: 3
  ```

  Although this is a simple example, note that ``math_operation/2`` could eventually be implemented in other modules to perform different special roles, such as division, multiplication, subtraction, etc. With that in mind, we can standardize a contract for ``math_operation/2``, guiding developers to follow the same format every time this function is implemented in the codebase. To do so, this refactoring will transform ``Foo`` into a behaviour definition by creating a ``@callback`` that defines the format of ``math_operation/2``. In addition, using [Moving a definition](#moving-a-definition), we will move ``math_operation/2`` to a new module called ``Sum``, updating all previous calls to ``math_operation/2``. Finally, ``Sum`` should explicitly implement the contract defined by ``Foo`` using the ``@behaviour`` definition.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    # behaviour definition
    @callback math_operation(a :: any(), b :: any()) :: {atom(), any()} 

    def print_result(a, b) do
      {_, r} = Sum.math_operation(a, b) # <- new refactoring opportunity!
      IO.puts("Operation result: #{r}")
    end
  end

  #...Use examples...
  iex(1)> Foo.print_result(1, 2)      
  Operation result: 3
  ```

  ```elixir
  # After refactoring:

  defmodule Sum do
    @behaviour Foo  #<- behaviour implementation

    @impl Foo       #<- behaviour implementation
    def math_operation(a, b) when is_number(a) and is_number(b) do
      {:ok, a + b}
    end
    def math_operation(_, _), do: {:error, "args not numeric"}
  end

  #...Use examples...
  iex(1)> Sum.math_operation(1, 2)
  {:ok, 3}
  
  iex(2)> Sum.math_operation(1, "Lucas")
  {:error, "args not numeric"}
  ```

  After this refactoring, the module ``Foo`` acts as the ``behaviour definition`` and the module ``Sum`` as the ``behaviour instance``. This refactoring is highly valuable since behaviour constructs allow static code analysis tools such as [Dialyzer][Dialyzer] to have a better understanding of the code, offer useful recommendations, and detect potential issues.
  
  __Recalling previous refactorings:__ Although this refactoring was successfully completed, note that it created a new opportunity for refactoring in the function ``Foo.print_result/2``. The first line of this function remained with a hard-coded call to ``Sum.math_operation/2``, which is an implementation of the ``@callback`` defined in the behaviour. Imagine that in the future the module ``Subtraction``, which also implements the ``Foo`` behaviour, is created:

  ```elixir
  defmodule Subtraction do
    @behaviour Foo  #<- behaviour implementation

    @impl Foo       #<- behaviour implementation
    def math_operation(a, b) when is_number(a) and is_number(b) do
      {:ok, a - b}
    end
    def math_operation(_, _), do: {:error, "args not numeric"}
  end
  ```

  To make ``Foo.print_result/2`` able to display the results of any possible implementation of the ``Foo`` behaviour (e.g. ``Sum`` and ``Subtraction``), we can apply [Generalise a function definition](#generalise-a-function-definition) to it, resulting in the following code:

  ```elixir
  defmodule Foo do
    @callback math_operation(a :: any(), b :: any()) :: {atom(), any()}

    def print_result(a, b, math_operation) do
      {_, r} = math_operation.(a, b)                #<- generalised!
      IO.puts("Operation result: #{r}")
    end
  end

  #...Use examples...
  iex(1)> Foo.print_result(1, 2, &Sum.math_operation/2)        
  Operation result: 3

  iex(2)> Foo.print_result(1, 2, &Subtraction.math_operation/2)
  Operation result: -1
  ```
  
  These examples are based on Erlang code written in this paper: [[1]](https://dl.acm.org/doi/10.1145/3064899.3064909)
  
[▲ back to Index](#table-of-contents)
___

### Behaviour inlining

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring is the inverse of [Behaviour extraction](#behaviour-extraction). Remembering, behaviour extraction aims to define a callback to compose a standardized interface for a function in a module that acts as a ``behaviour definition`` and move the existing version of that function to another module that follows this standardization, implementing the callback (``behaviour instance``). In contrast, Behaviour inlining aims to eliminate the implementations of callbacks in a ``behaviour instance``.

* __Examples:__ To perform this elimination, the function that implements a callback in a ``behaviour instance`` is moved to the ``behaviour definition`` module using [Moving a definition](#moving-a-definition), which will handle possible naming conflicts and update references to that function. If the moved function was the only callback implemented by the ``behaviour instance`` module, the definition of the implemented behaviour (``@behaviour``) should be removed the ``behaviour instance``, thus turning it into a regular module. Additionally, when the moved function is the last existing implementation of the callback throughout the codebase, this callback should cease to exist, being removed from the ``behaviour definition`` module.
  
  To better understand, take a look at the example in [Behaviour extraction](#behaviour-extraction) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

### Generate function specification

* __Category:__ Elixir-specific Refactorings*.

* __Motivation:__ Despite being a dynamically-typed language, Elixir offers a feature to compensate for the lack of a static type system. By using ``Typespecs``, we can specify the types of each function parameter and of the return value. Utilizing this Elixir feature not only improves documentation, but also can enhance code readability and prepare it to be analyzed for tools like [Dialyzer][Dialyzer], enabling the detection of type inconsistencies, and potential bugs. The goal of this refactoring is simply to use Typespecs in a function to promote the aforementioned benefits of using this feature.

* __Examples:__ The following code has already been presented in another context in the refactoring [Merge expressions](#merge-expressions). Prior to the refactoring, we have a module ``Bhaskara`` composed of the function ``solve/3``, responsible for finding the roots of a quadratic equation. Note that this function should receive three real numbers as parameters and return a tuple of two elements. The first element of this tuple is always an atom, while the second element may be a String (if there are no roots) or a tuple containing the two roots of the quadratic equation.

  ```elixir
  # Before refactoring:

  defmodule Bhaskara do
    
    def solve(a, b, c) do
      delta = (b*b - 4*a*c)

      if delta < 0 do
        {:error, "No real roots"}
      else
        x1 = (-b + delta ** 0.5) / (2*a)
        x2 = (-b - delta ** 0.5) / (2*a)
        {:ok, {x1, x2}}
      end
    end

  end

  #...Use examples...
  iex(1)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(2)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
  ```

  To easier this code understanding and leverage the other aforementioned benefits, we can generate a function specification using the ``@spec`` module attribute which is a default feature of Elixir. This module attribute should be placed immediately before the function definition, following the pattern ``@spec function_name(arg_type, arg_type...) :: return_type``.

  ```elixir
  # After refactoring:

  defmodule Bhaskara do
    
    @spec solve(number, number, number) :: {atom, String.t() | {number, number}}
    def solve(a, b, c) do
      delta = (b*b - 4*a*c)

      if delta < 0 do
        {:error, "No real roots"}
      else
        x1 = (-b + delta ** 0.5) / (2*a)
        x2 = (-b - delta ** 0.5) / (2*a)
        {:ok, {x1, x2}}
      end
    end

  end

  #...Retrieving code documentation...
  iex(1)> h Bhaskara.solve/3
                             
  @spec solve(number(), number(), number()) ::
          {atom(), String.t() | {number(), number()}}
  ```

  Note that with the use of ``@spec``, we can easily check the function specification using Elixir's helper.

[▲ back to Index](#table-of-contents)
___

### Transforming list appends and subtracts

* __Category:__ Functional Refactorings*.

* __Motivation:__ This is a refactoring that can make the code shorter and even more readable. Elixir's ``Enum`` module provides native functions to append an element to the end of a list (``concat/2``) and to subtract elements (``reject/2``) from a list. Although these functions serve their purposes well, Elixir also has specific operators equivalent to these functions, allowing the code to be simplified. This refactoring aims to transform calls to the ``Enum.concat/2`` and ``Enum.reject/2`` functions into uses of the ``Kernel.++/2`` and ``Kernel.--/2`` operators, respectively.

* __Examples:__ The following code shows an example of this simple refactoring. ``Enum.concat/2`` receives two lists as parameters and appends the elements of the second list to the end of the first. On the other hand, function ``Enum.reject/2`` receives a list and an anonymous function as parameters. This anonymous function is responsible for comparing each element of a second list with the elements of the first list, allowing the subtraction of elements present in both lists.

  ```elixir
  # Before refactoring:

  iex(1)> Enum.concat([1, 2, 3, 4], [5, 6, 7])
  [1, 2, 3, 4, 5, 6, 7]

  iex(2)> Enum.reject([1, 2, 3, 4, 5], &(Enum.member?([1, 3], &1)))
  [2, 4, 5]
  ```

  We can replace the use of functions from the ``Enum`` module with their equivalent specific operators, greatly simplifying the code as shown below.

  ```elixir
  # After refactoring:

  iex(1)> [1, 2, 3, 4] ++ [5, 6, 7]
  [1, 2, 3, 4, 5, 6, 7]

  iex(2)> [1, 2, 3, 4, 5] -- [1, 3]
  [2, 4, 5]                           
  ```

[▲ back to Index](#table-of-contents)
___

### Transform to list comprehension

* __Category:__ Elixir-specific Refactorings*.

* __Motivation:__ Elixir, like Erlang, provides several built-in ``high-order functions`` capable of taking lists as parameters and returning new lists modified from the original. In Elixir, ``Enum.map/2`` takes a list and an anonymous function as parameters, creating a new list composed of each element of the original list with values altered by applying the anonymous function. On the other hand, the function ``Enum.filter/2`` also takes a list and an anonymous function as parameters but creates a new list composed of elements from the original list that pass the filter established by the anonymous function. A list comprehension is another syntactic construction capable to create a list based on existing ones. This feature is based on the mathematical notation for defining sets and is very common in functional languages such as Haskell, Erlang, Clojure, and Elixir. This refactoring aims to transform calls to ``Enum.map/2`` and ``Enum.filter/2`` into list comprehensions, creating a semantically equivalent code that can be more declarative and easy to read.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we are using ``Enum.map/2`` to create a new list containing the elements of the original list squared. Furthermore, we are using ``Enum.filter/2`` to create a new list containing only the even numbers present in the original list.

  ```elixir
  # Before refactoring:

  iex(1)> Enum.map([2, 3, 4], &(&1 * &1))
  [4, 9, 16]

  iex(2)> Enum.filter([1, 2, 3, 4, 5], &(rem(&1, 2) == 0))
  [2, 4]
  ```

  We can replace the use of ``Enum.map/2`` and ``Enum.filter/2`` with the creation of semantically equivalent list comprehensions in Elixir, making the code more declarative as shown below.

  ```elixir
  # After refactoring:

  iex(1)> for x <- [2, 3, 4], do: x * x
  [4, 9, 16]

  iex(2)> for x <- [1, 2, 3, 4, 5], rem(x, 2) == 0, do: x 
  [2, 4]                       
  ```

[▲ back to Index](#table-of-contents)
___

### Nested list functions to comprehension

* __Category:__ Elixir-specific Refactorings*.

* __Motivation:__ This refactoring is a specific instance of [Transform to list comprehension](#transform-to-list-comprehension). When ``Enum.map/2`` and ``Enum.filter/2`` are used in a nested way to generate a new list, the code readability is compromised, and we also have an inefficient code, since the original list can be visited more than once and an intermediate list needs to be built. This refactoring, also referred to as ``deforestation``, aims to transform nested calls to ``Enum.map/2`` and ``Enum.filter/2`` into a list comprehension, creating a semantically equivalent code that can be more readable and more efficient.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we are using ``Enum.map/2`` and ``Enum.filter/2`` in a nested way to create a new list containing only the even elements of the original list squared

  ```elixir
  # Before refactoring:

  iex(1)> Enum.filter([1, 2, 3, 4, 5], &(rem(&1, 2) == 0)) |> Enum.map(&(&1 * &1))
  [4, 16]
  ```

  We can replace these nested calls with the creation of semantically equivalent list comprehension in Elixir, making the code more declarative and efficient as shown below.

  ```elixir
  # After refactoring:

  iex(1)> for x <- [1, 2, 3, 4, 5], rem(x, 2) == 0, do: x * x
  [4, 16]                       
  ```

[▲ back to Index](#table-of-contents)
___

### List comprehension simplifications

* __Category:__ Elixir-specific Refactorings*.

* __Motivation:__ This refactoring is the inverse of [Transform to list comprehension](#transform-to-list-comprehension) and [Nested list functions to comprehension](#nested-list-functions-to-comprehension). We can apply this refactoring to existing list comprehensions in the Elixir codebase, transforming them into semantically equivalent calls to the functions ``Enum.map/2`` or ``Enum.filter/2``.

* __Examples:__ Take a look at the examples in [Transform to list comprehension](#transform-to-list-comprehension) and [Nested list functions to comprehension](#nested-list-functions-to-comprehension) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

### From tuple to struct

* __Category:__ Functional Refactorings*.

* __Motivation:__ In Elixir, as well as in other functional languages like Erlang and Haskell, tuples are one of the most commonly used data structures. They are typically used to group a small and fixed amount of values. Although they are very useful, using tuples can make code less readable, as some details of the data representation are exposed in the code due to the inability to name the elements that compose a tuple. This refactoring aims to transform tuples into structs, which are data structures that allow naming their fields, thus providing a more abstract interface for the data and improving the code readability.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, the ``discount/2`` function of the ``Order`` module receives a tuple composed of order data and a discount percentage to be applied to the total value of the order. This function applies the discount to the total value of the order and returns a new tuple with the updated value.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def discount(tuple, value) do
      put_elem(tuple, 2, elem(tuple, 2) * value)
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount({:s1, "Lucas", 150.0}, 0.5)
  {:s1, "Lucas", 75.0}
  ```

  We can replace the use of this tuple by creating a struct ``%Order{}`` that contains the named data of an order, abstracting the interface for accessing this data and improving the readability of the code.

  ```elixir
  # After refactoring:

  defmodule Order do
    defstruct [id: nil, customer: nil, date: nil, total: nil]

    def discount(order, value) do
      %Order{order | total: order.total * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Lucas", total: 75.0}                     
  ```

[▲ back to Index](#table-of-contents)
___

### Struct guard to matching

* __Category:__ Functional Refactorings.

* __Motivation:__ In Elixir, as well as in other functional languages like Erlang and Haskell, guards are mechanisms used to perform more complex checks that would not be possible to do using just pattern matching. Although very useful, when guards are used unnecessarily to perform checks that could be done with just pattern matching, the code can become verbose and less readable. This refactoring focuses on transforming the use of ``is_struct/1`` or ``is_struct/2`` function calls into guards, for explicit pattern matching usage.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, the ``discount/2`` function of the ``Order`` module use the ``is_struct/2`` function to check if their first parameter is a struct of type ``Order``.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def discount(struct, value) when is_struct(struct, Order) do
      %Order{struct | total: struct.total * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Lucas", total: 75.0}

  iex(2)> Order.discount(%{}, 0.5)   #<= Used Map instead Struct!    
  ** (FunctionClauseError) no function clause matching in Order.discount/2
  ```

  Since the check performed by the ``is_struct/2`` guard is simple, it can be replaced by directly using pattern matching on the first parameter of the ``discount/2``.

  ```elixir
  # After refactoring:

  defmodule Order do
    def discount(%Order{} = struct, value) do
      %Order{struct | total: struct.total * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Lucas", total: 75.0}

  iex(2)> Order.discount(%{}, 0.5)   #<= Used Map instead Struct!    
  ** (FunctionClauseError) no function clause matching in Order.discount/2                     
  ```

[▲ back to Index](#table-of-contents)
___

### Struct field access elimination

* __Category:__ Functional Refactorings.

* __Motivation:__ In Elixir, as well as in other functional languages like Erlang and Haskell, it's possible for a function to receive ``structs``, or equivalent data types, as parameters and then access fields of these structs within its body or even in its signature to perform checks in guards. This refactoring focuses on replacing direct access to fields of a struct with the use of temporary variables that hold values extracted from these fields, which can then reduce the size of the code.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, the ``discount/2`` function of the ``Order`` module accesses the ``total`` field of the ``struct`` received as a parameter in two places, first to perform a guard check in its signature and then within its body to calculate the new value.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def discount(%Order{} = struct, value) when struct.total >= 100.0 do
      %Order{struct | total: struct.total * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Lucas", total: 75.0}
  ```

  To reduce the size of this code, we can use pattern matching to extract the value of the ``total`` field to a temporary variable ``t`` and replace all direct accesses to the ``total`` field with the use of the variable ``t``.

  ```elixir
  # After refactoring:

  defmodule Order do
    def discount(%Order{total: t} = struct, value) when t >= 100.0 do
      %Order{struct | total: t * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Lucas", total: 75.0}                   
  ```

  Note that the more direct accesses to a field of a struct exist before refactoring, the more benefits this refactoring will bring in reducing the size of the code.
  
  When struct fields are accessed exclusively in the function signature or its body, we must be careful not to introduce the code smell [Complex extractions in clauses][Complex extractions in clauses] with this refactoring.

[▲ back to Index](#table-of-contents)
___

### Equality guard to pattern matching

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring can further reduce Elixir code generated by the [Struct field access elimination](#struct-field-access-elimination) refactoring. When a temporary variable extracted from a struct field is only used in an equality comparison in a guard, extracting and using that variable is unnecessary, as we can perform that equality comparison directly with pattern matching.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``discount/2`` that allows reducing the cost of purchases that cost at least ``100.0`` and are made by customers named ``"Lucas"``.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def discount(%Order{total: t, customer: c} = s, value) when t >= 100.0 and c == "Lucas" do
      %Order{s | total: t * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Lucas", total: 75.0}

  iex(2)> Order.discount(%Order{id: :s1, customer: "Marco", total: 150.0}, 0.5)
  ** (FunctionClauseError) no function clause matching in Order.discount/2
  ```

  Note that the variable ``c`` was extracted from the ``customer`` field of the ``Order`` struct. Additionally, this variable ``c`` is only used in an equality comparison in the guard. Therefore, we can eliminate the variable ``c`` and replace the equality comparison with a pattern matching on the ``customer`` field of the struct received in the first parameter of the ``discount/2`` function.

  ```elixir
  # After refactoring:

  defmodule Order do
    def discount(%Order{total: t, customer: "Lucas"} = s, value) when t >= 100.0 do
      %Order{s | total: t * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Lucas", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Lucas", total: 75.0}

  iex(2)> Order.discount(%Order{id: :s1, customer: "Marco", total: 150.0}, 0.5)
  ** (FunctionClauseError) no function clause matching in Order.discount/2                   
  ```

[▲ back to Index](#table-of-contents)
___

### Static structure reuse

* __Category:__ Functional Refactorings.

* __Motivation:__ When identical tuples or lists are used at different points within a function, they are unnecessarily recreated by Elixir. This not only makes the code more verbose but also takes up more memory space and can lead to less efficient runtime. This refactoring aims to eliminate these unnecessary recreations of identical static structures by assigning them to variables that allow these structures to be shared throughout the code.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``check/1``. This function receives a two-element ``tuple`` as a parameter, where the first element is a boolean value indicating whether payment for an order has been confirmed, and the second element is a ``list`` of items that make up the order.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def check({paid, [:car, :house, i]}) do
      case paid do
        true -> [:car, :house, i]
        false -> {paid, [:car, :house, i]}
      end
    end
  end
  
  #...Use examples...
  iex(1)> Order.check({true, [:car, :house, :boat]}) 
  [:car, :house, :boat]

  iex(2)> Order.check({false, [:car, :house, :boat]})
  {false, [:car, :house, :boat]}
  ```

  Note that there is a ``tuple`` and a ``list`` being recreated in this function. When the payment is confirmed, ``check/1`` recreates and returns the ``list`` of items in the order (the second element of the ``tuple``). On the other hand, when the payment has not yet been made, ``check/1`` recreates the entire ``tuple`` received as a parameter and returns it.

  As shown in the following code, we can use pattern matching to create the variables ``list`` and ``tuple`` in the ``check/1`` clause, assigning these variables to the respective structures that were previously being unnecessarily recreated in the function body.

  ```elixir
  # After refactoring:

  defmodule Order do
    def check({paid, [:car, :house, _i] = list} = tuple) do
      case paid do
        true -> list    # <= reuse!
        false -> tuple  # <= reuse!
      end
    end
  end
  
  #...Use examples...
  iex(1)> Order.check({true, [:car, :house, :boat]}) 
  [:car, :house, :boat]

  iex(2)> Order.check({false, [:car, :house, :boat]})
  {false, [:car, :house, :boat]}                   
  ```

[▲ back to Index](#table-of-contents)
___

### Simplifying guard sequences

* __Category:__ Functional Refactorings.

* __Motivation:__ The guard clauses in Elixir may contain redundant logical propositions. Although this does not cause behavioral problems for the code, it can make it more verbose and inefficient. This refactoring aims to simplify the guard clauses by eliminating redundancies whenever possible.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, the multi-clause function ``bar/1`` has redundant guards in both clauses. The first clause checks if a parameter is of the ``float`` type and also equals a constant of that type. The second clause checks if a parameter is of the ``list`` type and if this ``list`` has more than two values.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(f) when is_float(f) and f == 81.0 do
      {:float, f}
    end

    def bar(l) when is_list(l) and length(l) > 2 do
      {:list, l}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(81.0)
  {:float, 81.0}

  iex(2)> Foo.bar(81)         #<= integer!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1

  iex(3)> Foo.bar([1,2,3,4])
  {:list, [1, 2, 3, 4]}

  iex(4)> Foo.bar({1,2,3,4})  #<= tuple!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1
  ```

  As shown in the following code, we can simplify the first clause by using the strict equality comparison operator. The second clause can be simplified by using only the ``Kernel.length/1`` function, since it expects a parameter of the ``list`` type. If a parameter of a different type is passed to ``Kernel.length/1``, the pattern matching for that clause will not be performed.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(f) when f === 81.0 do
      {:float, f}
    end

    def bar(l) when length(l) > 2 do
      {:list, l}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(81.0)
  {:float, 81.0}

  iex(2)> Foo.bar(81)         #<= integer!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1

  iex(3)> Foo.bar([1,2,3,4])
  {:list, [1, 2, 3, 4]}

  iex(4)> Foo.bar({1,2,3,4})  #<= tuple!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1                   
  ```

[▲ back to Index](#table-of-contents)
___

### Converts guards to conditionals

* __Category:__ Functional Refactorings.

* __Motivation:__ In Elixir, we can differentiate each clause of a function by using guards. The goal of this refactoring is to replace all guards in a function with traditional conditionals, creating only one clause for the function.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a multi-clause function ``bar/1``. The first clause checks if a parameter is of the ``float`` type and also equals a constant of that type. The second clause checks if a parameter is of the ``list`` type and if this ``list`` has more than two values.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(f) when f === 81.0 do
      {:float, f}
    end

    def bar(l) when length(l) > 2 do
      {:list, l}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(81.0)
  {:float, 81.0}

  iex(2)> Foo.bar(81)         #<= integer!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1

  iex(3)> Foo.bar([1,2,3,4])
  {:list, [1, 2, 3, 4]}

  iex(4)> Foo.bar({1,2,3,4})  #<= tuple!
  ** (FunctionClauseError) no function clause matching in Foo.bar/1
  ```

  As shown in the following code, we can replace the two guards with a ``cond`` conditional, creating only one clause for the ``bar/1`` function.

  ```elixir
  # After refactoring:

  defmodule Foo do
    
    def bar(v) do
      try do
        cond do
          v === 81.0 -> {:float, v}
          length(v) > 2 -> {:list, v}
          true -> raise FunctionClauseError
        end
      rescue
        _e in ArgumentError -> raise FunctionClauseError
      end
    end

  end
  
  #...Use examples...
  iex(1)> Foo.bar(81.0)
  {:float, 81.0}

  iex(2)> Foo.bar(81)         #<= integer!
  ** (FunctionClauseError) no function clause matches in Foo.bar/1

  iex(3)> Foo.bar([1,2,3,4])
  {:list, [1, 2, 3, 4]}

  iex(4)> Foo.bar({1,2,3,4})  #<= tuple!
  ** (FunctionClauseError) no function clause matches in Foo.bar/1                   
  ```

  In Elixir, when an error is raised from inside the guard, it won’t be propagated, and the guard expression will just return false. An example of this occurs when a call to ``Kernel.length/1`` in a guard receives a parameter that is not a ``list``. Instead of propagating an ``ArgumentError``, the corresponding clause just won’t match. However, when the same proposition is used outside of a guard (in a conditional), an ``ArgumentError`` will be propagated.
  
  To keep the refactored code with the same behavior as the original, raising only a ``FunctionClauseError`` when the conditional has no branch equivalent to the desired clause, it was necessary to use the error-handling mechanism of Elixir. Note that the use of this error-handling mechanism, combined with the fact of merging multiple clauses into one, may turn this refactored code into a [Long Function][Long Function].

[▲ back to Index](#table-of-contents)
___

### Eliminate single branch

* __Category:__ Traditional Refactoring*.

* __Motivation:__ This refactoring aims to simplify the code by eliminating control statements that have only one possible flow.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``qux/1`` with a ``case`` statement that has only one branch. When the pattern matching of this single branch does not occur, this function raises a ``CaseClauseError``.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def qux(value) do
      case value do
        {:ok, v1, v2} ->
          (v1 + v1) * v2
      end
    end
  end
  
  #...Use examples...
  iex(1)> Foo.qux({:ok, 2, 4})
  16

  iex(2)> Foo.qux({:error, 2, 4})
  ** (CaseClauseError) no case clause matching: {:error, 2, 4}
  ```

  As shown in the following code, we can simplify this code by replacing the ``case`` statement with the code that would be executed by their single branch.

  ```elixir
  # After refactoring:

  defmodule Foo do 
    def qux(value) do
      {:ok, v1, v2} = value
      (v1 + v1) * v2
    end
  end
  
  #...Use examples...
  iex(1)> Foo.qux({:ok, 2, 4}) 
  16

  iex(2)> Foo.qux({:error, 2, 4})
  ** (MatchError) no match of right hand side value: {:error, 2, 4}                   
  ```

  Note that the only behavioral difference between the original and refactored code is that a different error is raised when the pattern matching does not occur (i.e., ``MatchError``). This could be compensated for by using the error-handling mechanism of Elixir, as shown in [Converts guards to conditionals](#converts-guards-to-conditionals).

[▲ back to Index](#table-of-contents)
___

### Simplifying nested conditional statements

* __Category:__ Traditional Refactoring.

* __Motivation:__ Sometimes nested conditional statements can unnecessarily decrease the readability of the code. This refactoring aims to simplify the code by eliminating unnecessary nested conditional statements.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have the functions ``convert/2`` and ``qux/3``. The private function ``convert/2`` takes a ``list`` and a boolean value ``switch`` as parameters. If ``switch`` is true, the ```list``` is converted to a tuple; otherwise, the ``list`` is not modified. The public function ``qux/3`` takes a ``list``, a ``value``, and an ``index`` as parameters and then calls the ``convert/2`` function. If the ``list`` contains the ``value`` at the ``index``, ``qux/3`` calls the ``convert/2`` function with the second parameter set to true; otherwise, the second parameter is set to false.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    defp convert(list, switch) do
      case switch do
        true -> {:tuple, List.to_tuple(list)}
        _    -> {:list, list}
      end
    end

    def qux(list, value, index) do
      case convert(list, case Enum.at(list, index) do
                            ^value -> true
                            _      -> false
                          end) do
        {:tuple, _} -> "Something..."
        {:list, _}  -> "Something else..."
      end
    end
  end
  
  #...Use examples...
  iex(1)> Foo.qux([1,7,3,8], 7, 0)  
  "Something else..."

  iex(2)> Foo.qux([1,7,3,8], 7, 1)
  "Something..."
  ```

  Note that the function ``qux/3`` uses two nested ``case`` statements to perform its operations, with the innermost ``case`` statement responsible for setting the boolean value of the second parameter in the call to ``convert/2``. As shown in the following code, we can simplify this code by replacing the innermost ``case`` statement with a strict equality comparison (``===``).

  ```elixir
  # After refactoring:

  defmodule Foo do 
    ...

    def qux(list, value, index) do
      case convert(list, Enum.at(list, index) === value) do
        {:tuple, _} -> "Something..."
        {:list, _}  -> "Something else..."
      end
    end

  end
  
  #...Use examples...
  iex(1)> Foo.qux([1,7,3,8], 7, 0)  
  "Something else..."

  iex(2)> Foo.qux([1,7,3,8], 7, 1)
  "Something..."                 
  ```

[▲ back to Index](#table-of-contents)
___

### Move file

* __Category:__ Traditional Refactoring.

* __Motivation:__ Move a project file between directories, which contains code such as modules, macros, structs, etc. This refactoring can improve the organization of an Elixir project, grouping related files in the same directory, which may, for example, belong to the same architectural layer. This refactoring can also impact the updating of references made by dependents of the code present in the moved file.

[▲ back to Index](#table-of-contents)
___

### Remove dead code

* __Category:__ Traditional Refactoring.

* __Motivation:__ Dead code (i.e., unused code) can pollute a codebase making it longer and harder to maintain. This refactoring aims to clean the codebase by eliminating code definitions that are not being used.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``bar/2`` that modifies the two values received as parameters and then returns the power of both.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      v1 = v1 ** 2
      v2 = v2 + 5
      dead_code = v2 / 2  #<= can be removed!
      {:ok, v1 ** v2}
    end
  end
  
  #...Use examples...
  iex(1)> c("sample.ex")  
  warning: variable "dead_code" is unused... sample.ex:5: Foo.bar/2

  iex(2)> Foo.bar(2, 1) 
  {:ok, 4096}
  ```

  Note that when this code is compiled, Elixir's compiler itself informs the existence of unused code that could be eliminated to clean up the codebase. As shown in the following code, this refactoring eliminated the ``dead_code`` in ``bar/2`` without causing any side effects to the function's behavior.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      v1 = v1 ** 2
      v2 = v2 + 5
      {:ok, v1 ** v2}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(2, 1) 
  {:ok, 4096}                
  ```

[▲ back to Index](#table-of-contents)
___

### Introduce or remove a duplicate definition

* __Category:__ Traditional Refactoring.

* __Motivation:__ When we want to test a modification in a code without losing its original definition, we can temporarily duplicate it with a new identifier. Once this new version of the code is approved, it will replace the original version and the duplication will be removed.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``bar/2`` that returns the power of their parameters.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      v3 = v1 ** v2
      {:ok, v3}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(5, 2) 
  {:ok, 25}
  ```

  Imagine that for some reason it is necessary to change the definition of ``v3``, but while the new version of ``v3`` is not approved, we also want to keep the original version in the codebase. The following code shows the application of this refactoring, duplicating the definition of ``v3``.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(v1, v2) do
      v3 = v1 ** v2               #<= definition to be changed!
      v3_duplication = v1 ** v2   #<= original version!
      {:ok, v3}
    end
  end
  
  #...Use examples...
  iex(1)> Foo.bar(5, 2) 
  {:ok, 25}               
  ```

  Note that the identifier of the introduced duplicated code (``v3_duplication``) should not conflict with any other existing identifier in the code. Once the new version of the code has been implemented and approved, the duplication can be removed from the codebase by this refactoring. If the new version is disapproved, we can return to the original version by applying [Rename an identifier](#rename-an-identifier) to it.

[▲ back to Index](#table-of-contents)
___

### Introduce overloading

* __Category:__ Traditional Refactoring.

* __Motivation:__ Function overloading enables the creation of variations of an existing function, that is, the definition of two or more functions with identical names but different parameters. In Elixir, this can be done with functions of different arities or with multi-clause functions of the same arity. This refactoring allows for the creation of a variation of a function, enabling its use in different contexts.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``discount/1`` that allows applying a 30% discount on orders that cost at least ``100.0``.

  ```elixir
  # Before refactoring:

  defmodule Order do
    defstruct [date: nil, total: nil]

    def discount(%Order{total: t} = s) when t >= 100.0 do
      %Order{s | total: t * 0.7}
    end

  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{total: 150.0, date: ~D[2022-11-10]}) 
  %Order{date: ~D[2022-11-10], total: 105.0}

  iex(2)> Order.discount(%Order{total: 90.0, date: ~D[2022-10-18]}) 
  ** (FunctionClauseError) no function clause matching in Order.discount/1  
  ```

  Consider a scenario where this e-commerce wants to implement new discount rules for new situations or specific dates. This could be done by overloading the ``discount/1`` function, creating for example a new clause for it that will be applied on purchases made on Christmas day, and also a variation ``discount/2``, that could be applied for discounts on exceptional cases. The following code presents these two refactorings of the original ``discount/1`` function.

  ```elixir
  # After refactoring:

  defmodule Order do
    defstruct [date: nil, total: nil]

    # new
    def discount(%Order{date: d, total: t} = s) when d.day == 25 and d.month == 12 do
      %Order{s | total: t * 0.1}
    end

    # original
    def discount(%Order{total: t} = s) when t >= 100.0 do
      %Order{s | total: t * 0.7}
    end

    # new
    def discount(%Order{total: t} = s, value) do
      %Order{s| total: t * value}
    end

  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{total: 150.0, date: ~D[2022-12-25]}) 
  %Order{date: ~D[2022-12-25], total: 15.0}  
  
  iex(2)> Order.discount(%Order{total: 150.0, date: ~D[2022-11-10]}) 
  %Order{date: ~D[2022-11-10], total: 105.0}

  iex(3)> Order.discount(%Order{total: 90.0, date: ~D[2022-10-18]}, 0.8) 
  %Order{date: ~D[2022-10-18], total: 72.0}           
  ```

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
[Large Module]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#large-class
[Unnecessary Macros]: https://github.com/lucasvegi/Elixir-Code-Smells#unnecessary-macros
[Complex extractions in clauses]: https://github.com/lucasvegi/Elixir-Code-Smells#complex-extractions-in-clauses
[Dialyzer]: https://hex.pm/packages/dialyxir

[ICPC-ERA]: https://conf.researchr.org/track/icpc-2022/icpc-2022-era
[preprint-copy]: https://doi.org/10.48550/arXiv.2203.08877
[ICPC22-PDF]: https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/Code-Smells-in-Elixir-ICPC22-Lucas-Vegi.pdf
[ICPC22-YouTube]: https://youtu.be/3X2gxg13tXo
[Podcast-Spotify]: http://elixiremfoco.com/episode?id=lucas-vegi-e-marco-tulio
