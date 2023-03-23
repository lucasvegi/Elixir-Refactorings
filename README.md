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

* __Motivation:__ This refactoring is the inverse of [Merging multiple definitions](#merging-multiple-definitions). While merge multiple definitions aims to group recursive functions into a single recursive function that returns a tuple, Splitting a definition aims to separate a recursive function by creating new recursive functions, each of them responsible for individually generating a respective element originally contained in a tuple.

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
  iex(17)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(21)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(22)> Bhaskara.solve(1, 2, 3)
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
  iex(17)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(21)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(22)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
  ```

  __[Curiosity] Recalling previous refactorings:__ Although the refactored code shown above has made the code more readable, it still has opportunities for applying other refactorings previously documented in this catalog. Note that for the calculation of the roots, we have two lines of code that are practically identical. In addition, we have two temporary variables (``x1`` and ``x2``) that have only the purpose of storing results that will be returned by the function. If we take this refactored version of the code after applying [Merge expressions](#merge-expressions) and apply a composite refactoring with the sequence of [Extract function](#extract-function) -> [Generalise a function definition](#generalise-a-function-definition) -> [Fold against a function definition](#folding-against-a-function-definition) -> [Temporary variable elimination](#temporary-variable-elimination), we can arrive at the following version of the code:
  
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
  iex(17)> Bhaskara.solve(1, 3, -4) 
  {:ok, {1.0, -4.0}}

  iex(21)> Bhaskara.solve(1, 2, 1)
  {:ok, {-1.0, -1.0}}

  iex(22)> Bhaskara.solve(1, 2, 3)
  {:error, "No real roots"}
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
[Unnecessary Macros]: https://github.com/lucasvegi/Elixir-Code-Smells#unnecessary-macros

[ICPC-ERA]: https://conf.researchr.org/track/icpc-2022/icpc-2022-era
[preprint-copy]: https://doi.org/10.48550/arXiv.2203.08877
[ICPC22-PDF]: https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/Code-Smells-in-Elixir-ICPC22-Lucas-Vegi.pdf
[ICPC22-YouTube]: https://youtu.be/3X2gxg13tXo
[Podcast-Spotify]: http://elixiremfoco.com/episode?id=lucas-vegi-e-marco-tulio
