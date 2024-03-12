# [Catalog of Elixir Refactorings][Elixir Refactorings]

[![GitHub last commit](https://img.shields.io/github/last-commit/lucasvegi/Elixir-Refactorings)](https://github.com/lucasvegi/Elixir-Refactorings/commits/main)
[![Twitter URL](https://img.shields.io/twitter/url?style=social&url=https%3A%2F%2Fgithub.com%2Flucasvegi%2FElixir-Refactorings)](https://twitter.com/intent/tweet?url=https%3A%2F%2Fgithub.com%2Flucasvegi%2FElixir-Refactorings&via=lucasvegi&text=Catalog%20of%20Elixir%20Refactorings%3A&hashtags=MyElixirStatus%2CElixirLang)

## Table of Contents

* __[Introduction](#introduction)__
* __[Elixir-Specific Refactorings](#elixir-specific-refactorings)__
  * [Alias expansion](#alias-expansion) [^**]
  * [Default value for absent key in a Map](#default-value-for-absent-key-in-a-map) [^**]
  * [Defining a subset of a Map](#defining-a-subset-of-a-map) [^**]
  * [Modifying keys in a Map](#modifying-keys-in-a-map) [^**]
  * [Simplifying Ecto schema fields validation](#simplifying-ecto-schema-fields-validation) [^**]
  * [Pipeline using "with"](#pipeline-using-with) [^**]
  * [Pipeline for database transactions](#pipeline-for-database-transactions) [^**]
  * [Transform nested "if" statements into a "cond"](#transform-nested-if-statements-into-a-cond) [^**]
  * [Explicit a double boolean negation](#explicit-a-double-boolean-negation) [^**]
  * [Transform "if" statements using pattern matching into a "case"](#transform-if-statements-using-pattern-matching-into-a-case) [^**]
  * [Moving "with" clauses without pattern matching](#moving-with-clauses-without-pattern-matching) [^**]
  * [Remove redundant last clause in "with"](#remove-redundant-last-clause-in-with) [^***]
  * [Replace "Enum" collections with "Stream"](#replace-enum-collections-with-stream) [^***]
  * [Generalise a process abstraction](#generalise-a-process-abstraction) [^***]
* __[Traditional Refactorings](#traditional-refactorings)__
  * [Rename an identifier](#rename-an-identifier)
  * [Moving a definition](#moving-a-definition)
  * [Add or remove a parameter](#add-or-remove-a-parameter)
  * [Grouping parameters in tuple](#grouping-parameters-in-tuple)
  * [Reorder parameter](#reorder-parameter)
  * [Extract function](#extract-function)
  * [Inline function](#inline-function)
  * [Folding against a function definition](#folding-against-a-function-definition)
  * [Extract constant](#extract-constant)
  * [Temporary variable elimination](#temporary-variable-elimination)
  * [Merge expressions](#merge-expressions)
  * [Splitting a large module](#splitting-a-large-module)
  * [Simplifying nested conditional statements](#simplifying-nested-conditional-statements)
  * [Move file](#move-file)
  * [Remove dead code](#remove-dead-code)
  * [Introduce or remove a duplicate definition](#introduce-or-remove-a-duplicate-definition)
  * [Introduce overloading](#introduce-overloading)
  * [Remove import attributes](#remove-import-attributes)
  * [Introduce import](#introduce-import)
  * [Group Case Branches](#group-case-branches)
  * [Move expression out of case](#move-expression-out-of-case)
  * [Simplifying test by truthness](#simplifying-test-by-truthness) [^**]
  * [Reducing a boolean equality expression](#reducing-a-boolean-equality-expression) [^**]
  * [Transform "unless" with negated conditions into "if"](#transform-unless-with-negated-conditions-into-if) [^**]
  * [Replace conditional with polymorphism via Protocols](#replace-conditional-with-polymorphism-via-protocols) [^**]
* __[Functional Refactorings](#functional-refactorings)__
  * [Generalise a function definition](#generalise-a-function-definition)
  * [Introduce pattern matching over a parameter](#introduce-pattern-matching-over-a-parameter)
  * [Turning anonymous into local functions](#turning-anonymous-into-local-functions)
  * [Merging multiple definitions](#merging-multiple-definitions)
  * [Splitting a definition](#splitting-a-definition)
  * [Inline macro substitution](#inline-macro-substitution)
  * [Transforming list appends and subtracts](#transforming-list-appends-and-subtracts)
  * [From tuple to struct](#from-tuple-to-struct)
  * [Struct guard to matching](#struct-guard-to-matching)
  * [Struct field access elimination](#struct-field-access-elimination)
  * [Equality guard to pattern matching](#equality-guard-to-pattern-matching)
  * [Static structure reuse](#static-structure-reuse)
  * [Simplifying guard sequences](#simplifying-guard-sequences)
  * [Converts guards to conditionals](#converts-guards-to-conditionals)
  * [Widen or narrow definition scope](#widen-or-narrow-definition-scope)
  * [Introduce Enum.map/2](#introduce-enummap2)
  * [Bindings to List](#bindings-to-list)
  * [Function clauses to/from case clauses](#function-clauses-tofrom-case-clauses)
  * [Transform a body-recursive function to a tail-recursive](#transform-a-body-recursive-function-to-a-tail-recursive)
  * [Eliminate single branch](#eliminate-single-branch)
  * [Transform to list comprehension](#transform-to-list-comprehension)
  * [Nested list functions to comprehension](#nested-list-functions-to-comprehension)
  * [List comprehension simplifications](#list-comprehension-simplifications)
  * [Closure conversion](#closure-conversion) [^*]
  * [Replace pipeline with a function](#replace-pipeline-with-a-function) [^**]
  * [Remove single pipe](#remove-single-pipe) [^**]
  * [Simplifying pattern matching in clauses](#simplifying-pattern-matching-in-clauses) [^**]
  * [Improving list appending performance](#improving-list-appending-performance) [^**]
  * [Convert nested conditionals to pipeline](#convert-nested-conditionals-to-pipeline) [^**]
  * [Replacing recursion with a higher-level construct](#replacing-recursion-with-a-higher-level-construct) [^**]
  * [Replace a nested conditional in a "case" statement with guards](#replace-a-nested-conditional-in-a-case-statement-with-guards) [^***]
  * [Replace function call with raw value in a pipeline start](#replace-function-call-with-raw-value-in-a-pipeline-start) [^***]
* __[Erlang-Specific Refactorings](#erlang-specific-refactorings)__
  * [Generate function specification](#generate-function-specification)
  * [From defensive to non-defensive programming style](#from-defensive-to-non-defensive-programming-style)
  * [From meta to normal function application](#from-meta-to-normal-function-application)
  * [Remove unnecessary calls to length/1](#remove-unnecessary-calls-to-length1)
  * [Add type declarations and contracts](#add-type-declarations-and-contracts)
  * [Introduce concurrency](#introduce-concurrency)
  * [Remove concurrency](#remove-concurrency)
  * [Add a tag to messages](#add-a-tag-to-messages)
  * [Register a process](#register-a-process)
  * [Behaviour extraction](#behaviour-extraction)
  * [Behaviour inlining](#behaviour-inlining)
* __[About](#about)__
* __[Acknowledgments](#acknowledgments)__

[^*]: This refactoring emerged from an extended Systematic Literature Review (SLR).
[^**]: This refactoring emerged from a Grey Literature Review (GLR).
[^***]: This refactoring emerged from a Mining Software Repositories (MSR) study.

## Introduction

[Elixir][Elixir] is a functional programming language whose popularity is on the rise in the industry <sup>[link][ElixirInProduction]</sup>. As no known studies have explored refactoring strategies for code implemented with this language, we reviewed scientific literature seeking refactoring strategies in other functional languages. The found refactorings were analyzed, filtering only those directly compatible or that could be adapted for Elixir code. As a result of this investigation, we have initially proposed a catalog of 55 refactorings for Elixir systems.

Afterward, we scoured websites, blogs, forums, and videos (grey literature review), looking for specific refactorings for Elixir that its developers discuss. With this investigation, the catalog was expanded to 76 refactorings. Finally, 6 new refactorings emerged from a study mining software repositories (MSR) performed by us, so this catalog is constantly being updated and *__currently has 82 refactorings__*. These refactorings are categorized into four different groups ([Elixir-specific](#elixir-specific-refactorings), [traditional](#traditional-refactorings), [functional](#functional-refactorings), and [Erlang-specific](#erlang-specific-refactorings)), according to the programming features required in code transformations. This catalog of Elixir refactorings is presented below. Each refactoring is documented using the following structure:

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

## Elixir-Specific Refactorings

Elixir-specific refactorings are those that use programming features unique to this language. In this section, 14 different refactorings classified as Elixir-specific are explained and exemplified:

### Alias expansion

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ In Elixir, when using an `alias` for multiple names from the same namespace, you can consolidate multi-instruction instructions per namespace. Although this programming practice is common and can reduce the number of lines of code, multi-aliases can make it harder to search for a dependency in large code bases. This refactoring aims to expand multi-alias instructions fused into one multi-instruction per namespace, transforming them into single alias instructions per name. This provides improvement in code readability and traceability.

* __Examples:__ In the following code, before refactoring, we have a multi-alias instruction combining the definition of two dependencies. In this particular case, the dependencies for the `Baz` and `Boom` modules were merged into a single instruction.

  ```elixir
  # Before refactoring:

  alias Foo.Bar.{Baz, Boom}
  ```

  Especially in larger code bases, involving a greater number of dependencies within the same namespace (nested modules), the definition of these aliases could be refactored by an *__alias expansion__*, better highlighting all dependencies, as shown in the following code.

  ```elixir
  # After refactoring:

  alias Foo.Bar.Baz
  alias Foo.Bar.Boom
  ```

  This example is derived from code found in the official documentation for the tools [Recode](https://hexdocs.pm/recode/0.6.5/Recode.Task.AliasExpansion.html) and [ExactoKnife](https://hexdocs.pm/exacto_knife/readme.html#refactorings).

[▲ back to Index](#table-of-contents)
___

### Default value for absent key in a Map

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ We often come across a situation where we expect a `Map` to have a certain key, and if not, we need to provide a default value. A commonly used alternative for such situations is using the built-in `Map.has_key?/2` function along with an `if...else` statement. Although this alternative works perfectly, it's possible to refactor this code using only the built-in `Map.get/3` function, making the code less verbose and more readable, while preserving the same behavior.

* __Examples:__ In the following code, before refactoring, we utilize the `Map.has_key?/2` function in conjunction with an `if...else` statement to retrieve the currency from a ``Map`` containing the price of a product. If the `currency` key does not exist, we return the default value of `"USD"`.

  ```elixir
  # Before refactoring:

  currency = 
    if(Map.has_key? price, "currency") do
      price["currency"]
    else
      "USD"
  ```

  Applying this refactoring, the above code can be transformed into the following code, preserving the behavior while reducing the number of lines.

  ```elixir
  # After refactoring:

  currency = Map.get(price, "currency", "USD")
  ```

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Defining a subset of a Map

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When dealing with huge `Map` structures, there are occasions when we need to extract a subset of elements to form a new `Map`. Instead of manually creating this subset by individually accessing each of the desired key/value pairs from the original `Map`, with this refactoring, we can simply use the built-in `Map.take/2` function.

* __Examples:__ In the following code, we have a variable `pickup` bound to a `Map` composed of a huge number of keys.

  ```elixir
   # Huge Map
  pickup = %{
    "zip" => "75010",
    "town" => "PARIS",
    "stopName" => "RECEPTION",
    "pickupId" => 4018,
    "longitude" => 2.360982,
    "latitude" => 48.868502
    .... #a lot of keys
  }
  ```

  To extract only the metadata related to location, before refactoring, we manually access the values identified by the keys `"latitude"` and `"longitude"` to then create a new `Map`.

  ```elixir
  # Before refactoring:

  longitude = pickup["longitude"]
  latitude = pickup["latitude"]
  
  location = %{     # <-- Defining a subset manually
    "longitude" => longitude,
    "latitude" => latitude
  }
  ```

  Although this solution works, it can generate a significant amount of code, primarily due to duplications. Applying this refactoring, we can eliminate duplicated code, significantly reducing the number of lines and improving readability.

  ```elixir
  # After refactoring:

  location = Map.take(pickup, ["latitude", "longitude"])
  ```

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Modifying keys in a Map

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ Sometimes we need to update the format of a ``Map``, replacing the name given to a key but keeping the new key name associated with the original value. Instead of using ``Map.get/2``, ``Map.put/2``, and ``Map.delete/2`` functions together, which involves a lot of manual work and generates many lines of code, we can simply use the built-in ``Map.new/2`` function along with the use of multi-clause lambdas. This refactoring can significantly reduce the volume of lines of code, eliminating duplicated code and even making the code more resilient to typing-related errors.

* __Examples:__ In the following code, we have a variable `pickup` bound to a `Map`.

  ```elixir
  pickup = %{
    "stopName" => "RECEPTION",
    "pickupId" => 4018,
    "longitude" => 2.360982,
    "latitude" => 48.868502
  }
  ```

  Let's suppose we want to change the name of the key `"latitude"` to simply `"lat"`, while keeping the rest of the `Map` unchanged. The following code, before refactoring, performs this task manually. It first retrieves the value associated with the `"latitude"` key, then creates a new key called `"lat"` and associates it with the extracted value from the `"latitude"` key. Finally, the `"latitude"` key is removed from the `Map`.

  ```elixir
  # Before refactoring:

  latitude = Map.get(pickup, "latitude")    # --> step 1
  pickup = Map.put(pickup, "lat", latitude) # --> step 2
  pickup = Map.delete(pickup, "latitude")   # --> step 3 
  ```

  Although this solution works, imagine a situation where many keys need to be updated in a `Map`. The manual strategy presented above can become cumbersome and impractical. By using the built-in `Map.new/2` function, this refactoring would make it easier to simultaneously update the format of all keys in the `Map`, as shown in the following code.

  ```elixir
  # After refactoring:

  pickup = 
    Map.new(pickup, fn 
      {"latitude", lat} -> {"lat", lat}
      {"longitude", long} -> {"long", long}
      {"pickupId", pickup_id} -> {"pickup_id", pickup_id}
      {"stopName", stop_name} -> {"stop_name", stop_name}
    end)
  ```

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Simplifying Ecto schema fields validation

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ After defining a schema in Ecto, it's common to need to group fields for validations, such as those performed by the Ecto validator ``validate_required/3``. However, if we attempt to perform this grouping by manually implementing a list, there's a risk of making the code overly verbose, prone to typographical errors, and even subject to rework if the schema is modified in the future. Instead of relying on manually created lists, we can simply use the Ecto ``__schema__/1`` function, which returns the list of fields in the schema. With this refactoring, we can simplify the code, making it less prone to errors and more maintainable.

* __Examples:__ In the following code, we have an Ecto schema composed by six fields.

  ```elixir
  embedded_schema do
    field :carrier_time, :string
    field :carrier_date, :string
    field :carrier_name, :string
    field :carrier_number, :string
    field :carrier_terminal, :string
    field :carrier_type, :string
  end
  ```

  The following code manually lists in the `schema_fields` variable all the fields in our schema that will be validated by the Ecto `validate_required/3` function. Note that this listing process can be cumbersome, prone to typographical errors, and furthermore, it generates duplicated code.

  ```elixir
  # Before refactoring:

  def changeset(attrs) do
    # Manual listing of schema fields
    schema_fields = [:carrier_time, :carrier_date, :carrier_name, :carrier_number, :carrier_terminal, :carrier_type]
  
    %__MODULE__{}
    |> cast(attrs, schema_fields)
    |> validate_required(schema_fields, message: "Missing Field")
  end
  ```

  We can refactor the field listing by replacing the manual list with a call to the Ecto `__schema__/1` function. When we call this function with the atom `:fields` as a parameter, it returns the list of all non-virtual field names, which is exactly the same list we created manually before the refactoring.

  ```elixir
  # After refactoring:

  def changeset(attrs) do
  
    schema_fields = __schema__(:fields)  #<-- returns dynamically the list of schema fields!
  
    %__MODULE__{}
    |> cast(attrs, schema_fields)
    |> validate_required(schema_fields, message: "Missing Field")
  end
  ```

  Although simple, this refactoring brings many improvements to the code quality. If the database schema is altered, for instance, the above code will continue to work for all fields in the schema without the need for additional modifications.

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Pipeline using "with"

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When conditional statements, such as `if..else` and `case`, are used in a nested manner to create sequences of function calls, the code can become confusing and have poor readability. In these situations, we can replace the use of nested conditionals with a kind of function call pipeline using a `with` statement. This refactoring enforces the use of pattern matching at each function call, interrupting the pipeline if any pattern does not match. Additionally, it has the potential to enhance code readability without modifying the signatures (heads) of the involved functions, making this refactoring less prone to breaking changes compared to [Convert nested conditionals to pipeline](#convert-nested-conditionals-to-pipeline).

* __Examples:__ In the following code, the function `update_game_state/3` uses nested conditional statements to control the flow of a sequence of function calls to `valid_move/2`, `players_turn/2`, and `play_turn/3`. All these sequentially called functions have a return pattern of `{:ok, _}` or `{:error, _}`, which is common in Elixir code.

  ```elixir
  # Before refactoring:

  defp update_game_state(%{status: :started} = state, index, user_id) do
    move = valid_move(state, index)
    if move == :ok do
      players_turn(state, user_id)
      |> case do
        {:ok, marker} -> {:ok, play_turn(state, index, marker)}
        other         -> other
      end
    else
      {:error, :invalid_move}
    end
  end
  ```

  Note that, although this code works perfectly, the nesting of conditionals used to ensure the safe invocation of the next function in the sequence makes the code confusing. Therefore, we can refactor it by replacing these nested conditional statements with a pipeline that uses a `with` statement, thereby reducing the number of lines of code and improving readability, while keeping the behavior and signature of all the involved functions intact.

  ```elixir
  # After refactoring:

  defp update_game_state(%{status: :started} = state, index, user_id) do
    with :ok           <- valid_move(state, index),
         {:ok, marker} <- players_turn(state, user_id),
         new_state     =  play_turn(state, index, marker) do
      {:ok, new_state}
    else
      (other -> other)
    end
  end  
  ```

  As is characteristic of the `with` statement, the next function in this pipeline will only be called if the pattern of the previous call matches. Otherwise, the pipeline is terminated, returning the error that prevented it from proceeding to completion.

  This example is based on an original code by Gary Rennie. Source: [link](https://www.youtube.com/watch?v=V21DAKtY31Q)

[▲ back to Index](#table-of-contents)
___

### Pipeline for database transactions

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ The `Ecto.Repo.transaction/2` function allows performing operations on the database, such as update and delete. The first parameter of this function can be an anonymous function or a data structure called `Ecto.Multi`. When we want to perform a sequence of operations on the database using only one call to `Ecto.Repo.transaction/2`, the use of an anonymous function as the first parameter of this function can impair code readability, making it confusing. This refactoring converts anonymous functions used to create a pipeline of operations into calls to `Ecto.Repo.transaction/2`, transforming them into instances of `Ecto.Multi`, a data structure used for grouping multiple Repo operations. The code generated by this refactoring becomes cleaner and, furthermore, it does not allow the execution of operations if the `Ecto.Multi` is invalid (i.e., if any of the changesets have errors).

* __Examples:__ In the following code, the function `clear_challenges/2` makes a call to `Ecto.Repo.transaction/2` aiming to execute a sequence of update and delete operations on the database.

  ```elixir
  # Before refactoring:

  def clear_challenges(user, age \\ 300) do
    challenges = get_old_open_challenges(user, age)
    count = length(challenges)

    Repo.transaction(fn ->
      with {:ok, user} <- update_refused_challenges(user, count),
             delete_challenges(challenges),
             stop_games(challenges),
        do: user,
        else: ({:error, reason} -> Repo.rollback(reason))
    end)
  end
  ```

  Note that before the refactoring, this call to `Ecto.Repo.transaction/2` uses a complex anonymous function as its first parameter. This anonymous function employs a `with` statement to structure a pipeline of operations, similar to [Pipeline using "with"](#pipeline-using-with). While this code works perfectly, in this context, we can enhance the readability of this database operations pipeline by replacing the anonymous function with the `Ecto.Multi` data structure, specifically designed for creating such pipelines. The following code presents the refactored version of the `clear_challenges/2` function.

  ```elixir
  # After refactoring:

  def clear_challenges(user, age \\ 300) do
    challenges = get_old_open_challenges(user, age)
    count = length(challenges)
    
    params = %{refused_challenges: user.refused_challenges + count}
    Ecto.Multi.new()
    |> Ecto.Multi.update(:user, User.update_changeset(user, params))
    |> Ecto.Multi.delete_all(:challenges, delete_challenges(challenges))
    |> Ecto.Multi.run(:games, fn _ -> stop_games(challenges) end)
    |> Repo.transaction()
  end 
  ```

  This example is based on an original code by Gary Rennie. Source: [link](https://www.youtube.com/watch?v=V21DAKtY31Q)

[▲ back to Index](#table-of-contents)
___

### Transform nested "if" statements into a "cond"

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ While code using nested ``if`` statements works, it can be verbose and not very maintainable in some situations. Elixir doesn’t have an ``else if`` construct, but it does have a statement called ``cond`` that is logically equivalent. This refactoring aims to transform multiple conditionals, implemented using nested ``if`` statements, into the use of a ``cond`` statement, leaving the code without complex indentations and therefore cleaner and more readable.

* __Examples:__ In the following code, the `classify_bmi/2` function uses several nested `if..else` statements to classify the Body Mass Index (BMI) of an individual, calculated based on their weight and height.

  ```elixir
  # Before refactoring:
  
  def classify_bmi(weight, height) do
    {status, bmi} = calculate_bmi(weight, height)

    if status == :ok do
      if bmi < 18.5 do 
        "Underweight"
      else 
        if bmi < 25.0 do 
          "Normal weight"
        else 
          if bmi < 30.0 do
            "Overweight"
          else
            if bmi < 35.0 do
              "Obesity grade 1"
            else 
              if bmi < 40.0 do 
                "Obesity grade 2"
              else 
                "Obesity grade 3"
              end
            end
          end
        end
      end
    else
      "Error in BMI calculation: #{bmi}"
    end
  end
  ```

  Although this code works well, it is unnecessarily large in terms of the number of lines, and it also has complex indentations, resulting in an unattractive and less maintainable appearance. In the following code, after refactoring the nested `if..else` statements into an Elixir `cond` statement, the `classify_bmi/2` function has a cleaner and more readable appearance.

  ```elixir
  # After refactoring:

  def classify_bmi(weight, height) do
    {status, bmi} = calculate_bmi(weight, height)

    if status == :ok do
      cond do
        bmi < 18.5 -> "Underweight"
        bmi < 25.0 -> "Normal weight"
        bmi < 30.0 -> "Overweight"
        bmi < 35.0 -> "Obesity grade 1"
        bmi < 40.0 -> "Obesity grade 2"
        true       -> "Obesity grade 3"
      end
    else
      "Error in BMI calculation: #{bmi}"
    end
  end 
  ```

[▲ back to Index](#table-of-contents)
___

### Explicit a double boolean negation

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ In Elixir, when we perform a double boolean negation, we cast anything truthy to ``true`` and anything non-truthy to ``false``. In other words, this will return ``false`` for ``false`` and ``nil``, and ``true`` for anything else. Although this approach may seem interesting initially, it can make the code less expressive by omitting the real intention of this operation. Therefore, to improve readability, we can replace double boolean negations by introducing a helper multi-clause function.

* __Examples:__ In the following code, we can observe the behavior of double boolean negations applied to four distinct variables.

  ```elixir
  # Before refactoring:
  
  var_1 = true
  var_2 = false
  var_3 = nil
  var_4 = 100

  #...Use examples...
  iex(1)> !!var_1
  true
  iex(2)> !!var_2
  false
  iex(3)> !!var_3
  false
  iex(4)> !!var_4
  true
  ```

  To make our code more expressive, we can refactor the operations above by creating a multi-clause function that uses pattern matching to map all the behavioral possibilities of a double boolean negation. Below, we demonstrate this refactoring by creating the function `helper/1`. Note that this name is purely illustrative, so the function could be renamed to something that better represents its purpose, depending on the context.

  ```elixir
  # After refactoring:
  
  defmodule Foo do
    def helper(nil), do: false
    def helper(false), do: false
    def helper(_), do: true
  end 

   #...Use examples...
  iex(1)> Foo.helper(var_1)
  true
  iex(2)> Foo.helper(var_2)
  false
  iex(3)> Foo.helper(var_3)
  false
  iex(4)> Foo.helper(var_4)
  true
  ```

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.DoubleBooleanNegation.html)

[▲ back to Index](#table-of-contents)
___

### Transform "if" statements using pattern matching into a "case"

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ Pattern matching is most effective for simple assignments within ``if`` and ``unless`` clauses. Although Elixir allows pattern matching in conditional tests performed by an ``if`` statement, it may compromise code readability when used for flow control purposes. If you need to match a condition and execute a different block when it's not met, it's advisable to use a ``case`` statement instead of combining pattern matching with an ``if`` statement. This refactoring, therefore, aims to carry out this type of code transformation.

* __Examples:__ In the following code, an `if` statement is used in conjunction with pattern matching. In this situation, the `do_something/1` function is called if the pattern matches.

  ```elixir
  # Before refactoring:
  
  if {:ok, contents} = File.read("foo.txt") do
    do_something(contents)
  end
  ```

  As shown in the following code, we can refactor the previous code by replacing `if` statements that use pattern matching with an Elixir `case` statement, which is a more appropriate conditional for working alongside pattern matching. This refactoring also makes the code more flexible for future changes, as it opens the possibility to execute different code blocks when a pattern does not match, something that would not be possible using only an `if..else` statement.

  ```elixir
  # After refactoring:
  
  case File.read("foo.txt") do
    {:ok, contents} -> do_something(contents)
    _               -> do_something_else()
  end
  ```

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.MatchInCondition.html)

[▲ back to Index](#table-of-contents)
___

### Moving "with" clauses without pattern matching

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ Using ``with`` statements is recommended when you want to string together a series of pattern matches, stopping at the first one that fails. Although is possible to define a ``with`` statement using an initial or final clause that doesn't involve a ``<-`` operator (i.e., it doesn't match anything), it fails to leverage the advantages provided by the ``with``, potentially causing confusion. This refactoring aims to move these clauses that don't match anything to outside the ``with`` statement (for the initial ones) or place them inside the body of the ``with`` statement (for the final ones), thereby enhancing the code's focus and readability.

* __Examples:__ In the following code, we have a `with` statement composed of four clauses. As we can observe, the first and last clauses do not involve matching specific patterns. In other words, they do not use the `<-` operator.

  ```elixir
  # Before refactoring:
  
  with ref = make_ref(),
       {:ok, user} <- User.create(ref),
       :ok <- send_email(user),
       Logger.debug("Created user: #{inspect(user)}") do
    user
  end
  ```

  To enhance the readability of our code, keeping the clauses of the ``with`` statement focused solely on performing a pipeline of pattern matching, we can move the first clause of this code outside of the ``with`` statement and the last clause to inside its body, as shown in the following code. Note that although these clauses have been moved, the behavior of the code remains unchanged.

  ```elixir
  # After refactoring:
  
  ref = make_ref()  # moved outside of the 'with'

  with {:ok, user} <- User.create(ref),
       :ok <- send_email(user) do
    Logger.debug("Created user: #{inspect(user)}")  # moved inside the body of the 'with'
    user
  end
  ```

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.WithClauses.html)

[▲ back to Index](#table-of-contents)
___

### Remove redundant last clause in "with"

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Mining Software Repositories (MSR) study.

* __Motivation:__ When the last clause of an ``with`` statement is composed of a pattern identical to the predefined value to be returned by the ``with`` in case all checked patterns match, this clause is considered *redundant*. In such situations, this last clause of the ``with`` can be removed, and the predefined value to be returned by the ``with`` should then be replaced by the expression that was checked in the redundant clause that was removed. This refactoring will maintain the same behavior of the code while making it less verbose and more readable.

* __Examples:__ In the following code, the callback `handle_call/3` uses a `with` statement with a redundant last clause. Note that the pattern compared in the last clause is identical to the predefined value to be returned by the `with` in case all checked patterns match: `{:ok, conf}`.

  ```elixir
  # Before refactoring:

  defmodule Phoenix.LiveView.Channel do
    use GenServer
    ...

    @impl true
    def handle_call({@prefix, :fetch_upload_config, name, cid}, _from, state) do
      read_socket(state, cid, fn socket, _ ->
        result =
          with {:ok, uploads} <- Map.fetch(socket.assigns, :uploads),
               {:ok, conf} <- Map.fetch(uploads, name) do  #<- redundant last clause!
            {:ok, conf}  #<- predefined value to be returned by the ``with``!
          end

        {:reply, result, state}
      end)
    end
    ...
  end
  ```

  As demonstrated in the following code, we can refactor this by removing the redundant last clause `{:ok, conf} <- Map.fetch(uploads, name)` and also replacing the predefined value to be returned with the expression `Map.fetch(uploads, name)`, which was previously checked in the removed redundant clause.

  ```elixir
  # After refactoring:

  defmodule Phoenix.LiveView.Channel do
    use GenServer
    ...

    @impl true
    def handle_call({@prefix, :fetch_upload_config, name, cid}, _from, state) do
      read_socket(state, cid, fn socket, _ ->
        result =
          with {:ok, uploads} <- Map.fetch(socket.assigns, :uploads) do
            Map.fetch(uploads, name) #<- predefined value to be returned by the ``with``!
          end

        {:reply, result, state}
      end)
    end
    ...
  end
  ```

  This example is based on an original code refactored by ByeongUk Choi. Source: [link](https://github.com/phoenixframework/phoenix_live_view/pull/1958)

[▲ back to Index](#table-of-contents)
___

### Replace "Enum" collections with "Stream"

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Mining Software Repositories (MSR) study.

* __Motivation:__ All the functions in the ``Enum`` module are __*eager*__. This means that when performing multiple operations with ``Enum``, each operation will generate an intermediate collection (e.g., ``lists`` or ``maps``) until we reach the result. On the other hand, Elixir provides the ``Stream`` module which supports __*lazy operations*__, so instead of generating intermediate collections, streams build a series of computations that are invoked only when we pass the underlying ``Stream`` to the ``Enum`` module. This refactoring suggests using the ``Stream`` module instead of the ``Enum`` module __*when multiple operations in large collections are performed together*__. This can significantly decrease the time to traverse the collections while keeping the same behavior.

* __Examples:__ The code examples below illustrate this refactoring. Before the refactoring, the higher-order function ``sum_odd_numbers/2`` uses only ``Enum``'s functions to initially modify the values of a ``list``, filter all modified values that are odd, and then sum them up.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def sum_odd_numbers(list, odd?) do
      list
      |> Enum.map(&(&1 * 3))
      |> Enum.filter(odd?)
      |> Enum.sum()
    end
  end

  #...Use examples...
  iex(1)> Foo.sum_odd_numbers([1,2,3,4,5,6,7,8], &(rem(&1,2) != 0))
  48
  ```

  Following the refactoring, ``sum_odd_numbers/2`` retains the same behavior but now uses some ``Stream`` functions instead of ``Enum``. Note that even after the refactoring, the `Enum.sum/1` function, which is the last operation in the pipeline, was kept in the code. Since `Stream` module functions are __*lazy operations*__, the computations accumulated in `Stream.map/2` and `Stream.filter/2` are only invoked when this `Stream` is passed to a function from the `Enum` module, in this case the `Enum.sum/1` function.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def sum_odd_numbers(list, odd?) do
      list
      |> Stream.map(&(&1 * 3))  #<- Replace "Enum" with "Stream"!
      |> Stream.filter(odd?)    #<- Replace "Enum" with "Stream"!
      |> Enum.sum()
    end
  end

  #...Use examples...
  iex(1)> Foo.sum_odd_numbers([1,2,3,4,5,6,7,8], &(rem(&1,2) != 0))
  48
  ```

  By using the [Benchee](https://github.com/bencheeorg/benchee) library for conducting micro benchmarking in Elixir, we can highlight the performance improvement potential of this refactoring. In the following code, the `sum_odd_numbers/2` function is given illustrative names, `before_ref/1` and `after_ref/1`, to represent their respective `Enum` and `Stream` versions.

  ```elixir
  list = Enum.to_list(1..50_000_000)
  odd? = fn x -> rem(x, 2) != 0 end

  Benchee.run(%{
    "enum" => fn -> Foo.before_ref(list, odd?) end,
    "stream" => fn -> Foo.after_ref(list, odd?) end
  }, parallel: 4, memory_time: 2)
  ```

  Note that for a list with fifty million elements, the `Stream` version, although it consumes more memory, can be about __*twelve times faster*__ than the `Enum` version.

  ```bash
  Operating System: Windows
  CPU Information: Intel(R) Core(TM) i7-2670QM CPU @ 2.20GHz
  Number of Available Cores: 8
  Available memory: 11.95 GB
  Elixir 1.16.0
  Erlang 26.2.1

  Benchmark suite executing with the following configuration:
  warmup: 2 s
  time: 5 s
  memory time: 2 s
  reduction time: 0 ns
  parallel: 4
  inputs: none specified
  Estimated total run time: 18 s

  Benchmarking enum ...
  Benchmarking stream ...

  Name             ips        average  deviation         median         99th %
  stream         0.144      0.116 min     ±1.63%      0.116 min      0.117 min
  enum          0.0123       1.36 min    ±49.35%       1.11 min       2.31 min

  Comparison:
  stream         0.144
  enum          0.0123 - 11.76x slower +1.24 min

  Memory usage statistics:

  Name      Memory usage
  stream         2.05 GB
  enum           1.12 GB - 0.55x memory usage -0.93132 GB
  ```

  These examples are based on code written in Elixir's official documentation. Source: [link](https://hexdocs.pm/elixir/enumerable-and-streams.html)

[▲ back to Index](#table-of-contents)
___

### Generalise a process abstraction

* __Category:__ Elixir-specific Refactorings.

* __Source:__ This refactoring emerged from a Mining Software Repositories (MSR) study.

* __Motivation:__ Elixir provides different types of process abstractions for distinct purposes. While the `Task` and `Agent` abstractions have very specific purposes, `GenServer` is a more generic process abstraction, therefore having the capability to do everything that `Task` and `Agent` can do, as well as having additional capabilities beyond these two specific abstractions. This refactoring aims to transform `Task` or `Agent` abstractions into `GenServer` when these specific-purpose abstractions are used beyond their suggested purposes. More specifically, this refactoring can be used to remove the code smell [GenServer Envy](https://github.com/lucasvegi/Elixir-Code-Smells?#genserver-envy). By using an appropriate process abstraction for the purpose of the code, we can even improve its readability.

* __Examples:__ In the following code, the `DatabaseServer` module makes use of a `Task` abstraction to provide its clients with the ability to query a database using the interface function `get/2`. As can be observed in this example, this `Task` __*behaves like a long-running server process*__, frequently communicating with other client processes. This behavior is very different from the suggested purpose for `Tasks`, which typically should only perform a particular operation during their lifetime and then stop upon the completion of that operation without communication with other processes.

  ```elixir
  # Before refactoring:

  defmodule DatabaseServer do
    use Task

    def start_link() do
      Task.start_link(&loop/0)
    end

    defp loop() do
      receive do
        {:run_query, caller, query_def} ->
          send(caller, {:query_result, run_query(query_def)})
      end
      loop()
    end

    def get(server_pid, query_def) do
      send(server_pid, {:run_query, self(), query_def})
      receive do
        {:query_result, result} -> result
      end
    end

    defp run_query(query_def) do
      Process.sleep(1000)
      "#{query_def} result"
    end
  end

  #...Use examples...
  iex(1)> {:ok, pid} = DatabaseServer.start_link()      
  {:ok, #PID<0.161.0>}
  iex(2)> DatabaseServer.get(pid, "query 1")
  "query 1 result"
  iex(3)> DatabaseServer.get(pid, "query 2") 
  "query 2 result"
  ```

  Considering that the above code represents an instance of the code smell [GenServer Envy](https://github.com/lucasvegi/Elixir-Code-Smells?#genserver-envy), we can refactor it by generalizing the process abstraction used. In other words, we can transform this specific process abstraction (`Task`) into a generic process abstraction (`GenServer`). Note that although the process abstraction used has been replaced, the behavior of the code remains the same because the interfaces of the public functions have not been modified. Furthermore, the readability of the refactored code has improved, as it was no longer necessary to make explicit message passing and implement recursive functions to keep the process alive.

  ```elixir
  # After refactoring:

  defmodule DatabaseServer do
    use GenServer

    def start_link() do
      GenServer.start_link(__MODULE__, nil)
    end

    def get(server_pid, query_def) do
      GenServer.call(server_pid,{:run_query, query_def})
    end

    defp run_query(query_def) do
      Process.sleep(1000)
      "#{query_def} result"
    end

    @impl
    def handle_call({:run_query, query_def}, _, state) do
      {:reply, run_query(query_def), state}
    end
  end

  #...Use examples...
  iex(1)> {:ok, pid} = DatabaseServer.start_link()      
  {:ok, #PID<0.164.0>}
  iex(2)> DatabaseServer.get(pid, "query 1")
  "query 1 result"
  iex(3)> DatabaseServer.get(pid, "query 2") 
  "query 2 result"
  ```

  This example is based on an original code by Saša Jurić available in the __"Elixir in Action, 2. ed."__ book.

[▲ back to Index](#table-of-contents)
___

## Traditional Refactorings

Traditional refactorings are those mainly based on Fowler's catalog or that use programming features independent of languages or paradigms. In this section, 25 different refactorings classified as traditional are explained and exemplified:

### Rename an identifier

* __Category:__ Traditional Refactorings.

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

### Remove import attributes

* __Category:__ Traditional Refactoring.

* __Motivation:__ The use of the `import` directive in a module allows calling functions defined in other modules without having to specify them directly in each call. While this can reduce the size of code, the use of `import` can also harm the readability of code, making it difficult to identify directly the source of a function being called. This refactoring allows removing the `import` directives in a module, replacing all calls to imported functions with the format `Module.function(args)`.

* __Examples:__ The following code shows an example of this refactoring.

  ```elixir
  # Before refactoring:

  defmodule Bar do
    def sum(v1, v2) do
      v1 + v2
    end
  end

  defmodule Foo do
    import Bar  #<= to be removed!

    def qux(value_1, value_2) do
      sum(value_1, value_2)   #<= imported function!
    end
  end
  
  #...Use examples...
  iex(1)> Foo.qux(1, 2) 
  3
  ```

  ```elixir
  # After refactoring:

  defmodule Bar do
    def sum(v1, v2) do
      v1 + v2
    end
  end

  defmodule Foo do
    def qux(value_1, value_2) do
      Bar.sum(value_1, value_2)   #<= calling with a fully-qualified name
    end
  end
  
  #...Use examples...
  iex(1)> Foo.qux(1, 2) 
  3
  ```

[▲ back to Index](#table-of-contents)
___

### Introduce import

* __Category:__ Traditional Refactorings.

* __Motivation:__ This refactoring is the inverse of [Remove import attributes](#remove-import-attributes). Recall that Remove import attributes allows you to remove `import` directives from a module, replacing all calls to imported functions with fully-qualified name calls (`Module.function(args)`). In contrast, Introduce import focuses on replacing fully-qualified name calls of functions from other modules with calls that use only the name of the imported functions.

* __Examples:__ To better understand, take a look at the example in [Remove import attributes](#remove-import-attributes) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

### Group Case Branches

* __Category:__ Traditional Refactoring.

* __Motivation:__ The divide-and-conquer pattern refers to a computation in which a problem is recursively divided into independent subproblems, and then the subproblems' solutions are combined to obtain the solution of the original problem. Such a computation pattern can be easily parallelized because we can work on the subproblems independently and in parallel. This refactoring aims to restructure functions that utilize the divide-and-conquer pattern, making parallelization easier. Specifically, this refactoring allows us to partition the branches of a ``case`` statement in a divide-and-conquer function into two categories: *(1)* the base cases, and *(2)* the recursive cases. This restructuring replaces the original ``case`` statement with four ``case`` statements.

* __Examples:__ The following code examples illustrate a refactoring of the merge sort algorithm. Prior to the refactoring, the `merge_sort/1` function had only a single ``case`` statement to handle both the base case and the recursive case.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def merge_sort(list) do
      case list do
        []  -> []
        [h] -> [h]
        _   ->  half = length(list) |> div(2)
                right = merge_sort(Enum.take(list, half))
                left = merge_sort(Enum.drop(list, half))
                merge(right, left)
      end
    end
  end

  #...Use examples...
  iex(1)> Foo.merge_sort([3, 20, 9, 2, 7, 99, 80, 30])
  [2, 3, 7, 9, 20, 30, 80, 99]
  ```

  After refactoring, this ``case`` statement is replaced by four separate ``case`` statements, each with its respective role:

  - *(1 and 2)* Determine whether the instance is a base case (``true``) or a recursive case (``false``);

  - *(3 and 4)* Define which specific base case or recursive case we are dealing with, respectively.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def merge_sort(list) do
      is_base = case list do        #<= role 1
                  []    -> true
                  [_h]  -> true
                  _     -> false
                end

      case is_base do               #<= role 2
        true  ->  case list do      #<= role 3
                    []  -> []
                    [h] -> [h]
                  end
        false ->  case list do      #<= role 4
                    _   ->  half = length(list) |> div(2)
                            right = merge_sort(Enum.take(list, half))
                            left = merge_sort(Enum.drop(list, half))
                            merge(right, left)
                  end
      end
    end
  end

  #...Use examples...
  iex(1)> Foo.merge_sort([3, 20, 9, 2, 7, 99, 80, 30])
  [2, 3, 7, 9, 20, 30, 80, 99]
  ```

[▲ back to Index](#table-of-contents)
___

### Move expression out of case

* __Category:__ Traditional Refactoring.

* __Motivation:__ The divide-and-conquer pattern refers to a computation in which a problem is recursively divided into independent subproblems, and then the subproblems' solutions are combined to obtain the solution of the original problem. Such a computation pattern can be easily parallelized because we can work on the subproblems independently and in parallel. This refactoring aims to restructure functions that utilize the divide-and-conquer pattern, making parallelization easier. More precisely, this refactoring moves an expression outside of a `case` statement when it is repeated at the end of all branches.

* __Examples:__ The following code examples demonstrate this refactoring. Before the refactoring, the `bar/2` function has a `case` statement with two branches. At the end of both branches, the expression `Integer.is_odd(value)` is repeated.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(confirm, list) do
      case confirm do
        true  ->  value = Enum.at(list, 0)
                  Integer.is_odd(value)
        false ->  value = Enum.at(list, length(list)-1)
                  Integer.is_odd(value)
      end
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(true, [6, 5, 4, 3, 2, 1])
  false

  iex(2)> Foo.bar(false, [6, 5, 4, 3, 2, 1])
  true
  ```

  After the refactoring, `bar/2` retains the same behavior, but now with the expression `Integer.is_odd(value)` moved outside the ``case`` statement.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(confirm, list) do
      value = case confirm do
                true  ->  Enum.at(list, 0)
                false ->  Enum.at(list, length(list)-1)
              end
      Integer.is_odd(value) #<= out of case!
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(true, [6, 5, 4, 3, 2, 1])
  false

  iex(2)> Foo.bar(false, [6, 5, 4, 3, 2, 1])
  true
  ```

[▲ back to Index](#table-of-contents)
___

### Simplifying test by truthness

* __Category:__ Traditional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When we know that a given data can have a ``nil`` value and we need to return a default value if that data is indeed ``nil``, instead of using `is_nil/1` and an ``if-else`` block to test this condition and return the required value, we can utilize a short-circuit operator `||` based on truthness conditions. This refactoring reduces the number of lines required for such an operation, maintaining clean and self-explanatory code.

* __Examples:__ In the following code, we use the built-in Elixir function `is_nil/1` to check if the value of ``price`` is `nil` and then return a default value if that is true. Otherwise, the original value of ``price`` is returned.

  ```elixir
  # Before refactoring:

  def default(price) do
    if is_nil(price) do
      "$100"
    else
      price
    end
  end
  ```

  We can refactor the `default/1` function by simplifying the null check for `price`, using only a test based on truthness conditions, as shown below.

  ```elixir
  # After refactoring:

  def default(price) do
    price || "$100"
  end
  ```

  In Elixir, the atoms `nil` and `false` are treated as *falsy* values, whereas everything else is treated as a *truthy* value. When we use a short-circuit operator `||` based on truthiness conditions, it returns the first expression that isn't *falsy*, thus the refactored code preserves the behavior of the original.

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Reducing a boolean equality expression

* __Category:__ Traditional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When dealing with a boolean expression consisting of multiple equality comparisons involving the same variable and logical ``or`` operators, we can reduce the number of lines of code and enhance readability by utilizing the `in` operator and a list containing all possible valid values for the variable. The advantages of this refactoring are particularly derived from the removal of partially duplicated code.

* __Examples:__ In the following code, we have a boolean expression that checks if an `user` holds any of the four possible positions. If it is true for any of the positions, the `do_something/0` function is called. Otherwise, the code invokes the `do_something_else/0` function.

  ```elixir
  # Before refactoring:

  if user == "admin" or user == "super_admin" or user == "agent" or user == "super_agent" do
    do_something()
  else
    do_something_else()
  end
  ```

  As shown next, we can refactor this code by reducing the size of the boolean expression in question and improving readability through the removal of duplicated code.

  ```elixir
  # After refactoring:

  if user in ["admin", "super_admin", "agent", "super_agent"] do
    do_something()
  else
    do_something_else()
  end
  ```

  This example is based on an original code by Malreddy Ankanna. Source: [link](https://medium.com/blackode/elixir-code-refactoring-techniques-33589ac56231)

[▲ back to Index](#table-of-contents)
___

### Transform "unless" with negated conditions into "if"

* __Category:__ Traditional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ In Elixir, an `unless` statement is equivalent to an `if` with its condition negated. Therefore, while it is possible, `unless` statements should be avoided with a negated condition. The reason behind this is not technical but human-centric. Comprehending that a code block is executed only when a negated condition is not met is both confusing and challenging. Therefore, this refactoring aims to replace ``unless`` statements with negated conditions with ``if`` statements, enhancing code readability.

* __Examples:__ In the following code, we have an ``unless`` statement that uses logical negation in its conditional test.

  ```elixir
  # Before refactoring:

  unless !allowed? do
    proceed_as_planned()
  end
  ```

  This type of code, although simple, can easily confuse a developer and lead to errors. To improve readability and eliminate potential sources of confusion, we can refactor this code by removing the logical negation (``!``) from the conditional and replacing the ``unless`` statement with an ``if`` statement, thereby preserving the same behavior as the original code.

  ```elixir
  # After refactoring:

  if allowed? do
    proceed_as_planned()
  end
  ```

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.NegatedConditionsInUnless.html)

[▲ back to Index](#table-of-contents)
___

### Replace conditional with polymorphism via Protocols

* __Category:__ Traditional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When dealing with a conditional statement that performs various actions based on data type or specific data properties, the code might become challenging to follow as the number of conditional possibilities increases. Additionally, if the same sequence of conditional statements, whether via ``if..else``, ``case``, or ``cond``, appears duplicated in the code, we may be forced to make changes in multiple parts of the code whenever a new check needs to be added to these duplicated sequences of conditional statements, characterizing the code smell [Switch Statements](https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#switch-statements). This refactoring is essentially a translation of the traditional Fowler's refactoring, but using ``protocols``, which are interfaces that can be implemented per data type in Elixir, introducing polymorphism to data structures and thus improving the code's extensibility to handle flow controls based on data types.

* __Examples:__ In the following code, we have a module called `Bird`, which defines a `struct` composed of three properties. When the `plumage/1` function is called with a struct `%Bird{}` as a parameter, depending on the bird type and some other specific properties, its plumage is given a classification.

  ```elixir
  # Before refactoring:

  defmodule Bird do
    defstruct type: nil, number_of_coconuts: 0, voltage: 0

    def plumage(bird) do
      case bird.type do
        "EuropeanSwallow" -> "average"
        "AfricanSwallow" ->
          if bird.number_of_coconuts > 2 do
            "tired"
          else
            "average"
          end
        "NorwegianParrot" ->
          if bird.voltage > 100 do
            "scorched"
          else
            "beautiful"
          end
      end
    end
  end

  #...Use examples...
  iex(1)> Bird.plumage(%Bird{type: "AfricanSwallow", number_of_coconuts: 7})
  "tired"
  iex(2)> Bird.plumage(%Bird{type: "NorwegianParrot", voltage: 7000})
  "scorched"
  iex(3)> Bird.plumage(%Bird{type: "EuropeanSwallow"})
  "average"
  ```

  Currently, this code classifies the plumage of only three distinct types of birds (*EuropeanSwallow*, *AfricanSwallow*, and *NorwegianParrot*). However, if new birds need to be classified in the future, this code may require significant changes, such as adding new properties to the `%Bird{}` struct definition and introducing additional conditional statements. If this same type of conditional logic repeats throughout the codebase, it may be necessary to make changes in many different places whenever a new bird type emerges, making the code less extensible, hard to maintain, and prone to errors.

  To address this complexity and improve the design of this code, we can initially transform the `Bird` module into a ``protocol`` with the same name, containing the interface for the `plumage/1` function, as shown below.

  ```elixir
  # After refactoring:

  defprotocol Bird do
    def plumage(bird)
  end
  ```
  
  Furthermore, each bird type should be transformed into its own module, defining its own `struct` and implementing the `Bird` *protocol*, thus specializing the `plumage/1` function for the peculiarities of each bird, as shown below.

  ```elixir
  # After refactoring:

  defmodule EuropeanSwallow do
    defstruct number_of_coconuts: 0

    defimpl Bird, for: EuropeanSwallow do
      def plumage(%EuropeanSwallow{}), do: "average"
    end
  end

  defmodule NorwegianParrot do
    defstruct voltage: 0

    defimpl Bird, for: NorwegianParrot do
      def plumage(%NorwegianParrot{voltage: voltage}) when voltage > 100, do: "scorched"
      def plumage(_), do: "beautiful"
    end
  end

  defmodule AfricanSwallow do
    defstruct number_of_coconuts: 0

    defimpl Bird, for: AfricanSwallow do
      def plumage(%AfricanSwallow{number_of_coconuts: num}) when num > 2, do: "tired"
      def plumage(_), do: "average"
    end
  end
  ```
  
  The calls to the `plumage/1` function, which is now polymorphic, should be updated to receive specific ``structs`` for each bird type instead of a generic `%Bird{}` parameter, as shown below.

  ```elixir
  # After refactoring:

  iex(1)> Bird.plumage(%AfricanSwallow{number_of_coconuts: 7})
  "tired"
  iex(2)> Bird.plumage(%NorwegianParrot{voltage: 7000})
  "scorched"
  iex(3)> Bird.plumage(%EuropeanSwallow{})                    
  "average"
  ```
  
  After this refactoring, whenever we need to classify the plumage of a new bird type, we only need to create a module for that new type and implement the `Bird` protocol in it.

  This example is based on an original code by Zack Kayser. Source: [link](https://launchscout.com/blog/refactoring-patterns-in-elixir-replace-conditional-with-polymorphism-via-protocols-part-2)

[▲ back to Index](#table-of-contents)
___

## Functional Refactorings

Functional refactorings are those that use programming features characteristic of functional languages, such as pattern matching and higher-order functions. In this section, 32 different refactorings classified as functional are explained and exemplified:

### Generalise a function definition

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring helps to eliminate the [Duplicated Code][Duplicated Code] code smell. In any programming language, this code smell can make the codebase harder to maintain due to restrictions on code reuse. When different functions have equivalent expression structures, that structure should be generalized into a new function, which will later be called in the body of the duplicated functions, replacing their original codes. After that refactoring, the programmer only needs to worry about maintaining these expressions in one place (generic function). The support for ``higher-order functions`` in functional programming languages enhances the potential for generalizing provided by this refactoring.

* __Examples:__ In Elixir, as well as in other functional languages such as Erlang and Haskell, functions are considered as first-class citizens. This means that functions can be assigned to variables, allowing the definition of ``higher-order functions``. Higher-order functions are those that take one or more functions as arguments or return a function as a result. The following code illustrates this refactoring using a ``higher-order function``. Before the refactoring, we have two functions in the ``Gen`` module. The ``foo/1`` function takes a list as an argument and transforms it in two steps. First, it squares each of its elements and then multiplies each element by 3, returning a new list. The ``bar/1`` function operates similarly, receiving a list as an argument and also transforming it in two steps. First, it doubles the value of each element in the list and then returns a list containing only the elements divisible by 4. Although these two functions transform lists in different ways, they have duplicated structures.

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

  We want to generalize the functions ``foo/1`` and ``bar/1``. To do so, we must create a new function ``generic/4`` and replace the bodies of ``foo/1`` and ``bar/1`` with calls to ``generic/4``. Note that ``generic/4`` is a *__higher-order function__*, since its last three arguments are functions that are called only within its body. Due to the use of higher-order functions in this refactoring, we were able to create a smaller and easier-to-maintain new function than would be if we did not use this functional programming feature.

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

### Transforming list appends and subtracts

* __Category:__ Functional Refactorings.

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

### From tuple to struct

* __Category:__ Functional Refactorings.

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
  iex(1)> Order.discount({:s1, "Jose", 150.0}, 0.5)
  {:s1, "Jose", 75.0}
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
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Jose", total: 75.0}                     
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
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Jose", total: 75.0}

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
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Jose", total: 75.0}

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
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Jose", total: 75.0}
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
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5) 
  %Order{id: :s1, customer: "Jose", total: 75.0}                   
  ```

  Note that the more direct accesses to a field of a struct exist before refactoring, the more benefits this refactoring will bring in reducing the size of the code.
  
  When struct fields are accessed exclusively in the function signature or its body, we must be careful not to introduce the code smell [Complex extractions in clauses][Complex extractions in clauses] with this refactoring.

[▲ back to Index](#table-of-contents)
___

### Equality guard to pattern matching

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring can further reduce Elixir code generated by the [Struct field access elimination](#struct-field-access-elimination) refactoring. When a temporary variable extracted from a struct field is only used in an equality comparison in a guard, extracting and using that variable is unnecessary, as we can perform that equality comparison directly with pattern matching.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a function ``discount/2`` that allows reducing the cost of purchases that cost at least ``100.0`` and are made by customers named ``"Jose"``.

  ```elixir
  # Before refactoring:

  defmodule Order do
    def discount(%Order{total: t, customer: c} = s, value) when t >= 100.0 and c == "Jose" do
      %Order{s | total: t * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Jose", total: 75.0}

  iex(2)> Order.discount(%Order{id: :s1, customer: "Maria", total: 150.0}, 0.5)
  ** (FunctionClauseError) no function clause matching in Order.discount/2
  ```

  Note that the variable ``c`` was extracted from the ``customer`` field of the ``Order`` struct. Additionally, this variable ``c`` is only used in an equality comparison in the guard. Therefore, we can eliminate the variable ``c`` and replace the equality comparison with a pattern matching on the ``customer`` field of the struct received in the first parameter of the ``discount/2`` function.

  ```elixir
  # After refactoring:

  defmodule Order do
    def discount(%Order{total: t, customer: "Jose"} = s, value) when t >= 100.0 do
      %Order{s | total: t * value}
    end
  end
  
  #...Use examples...
  iex(1)> Order.discount(%Order{id: :s1, customer: "Jose", total: 150.0}, 0.5)
  %Order{id: :s1, customer: "Jose", total: 75.0}

  iex(2)> Order.discount(%Order{id: :s1, customer: "Maria", total: 150.0}, 0.5)
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

### Widen or narrow definition scope

* __Category:__ Functional Refactorings.

* __Motivation:__ In Elixir, it is not possible to define nested named functions, however, it is possible to define a nested anonymous function (inside) of a named function. In this case, the anonymous function's scope is narrowed to the body of the named function where it was defined. This refactoring aims to widen or narrow a function's usage scope.

* __Examples:__ The following code examples illustrate the widening of a function's scope. Prior to refactoring, the module `Foo` has the definition of the named function `bar/3`. Within this named function, we have the definition of the nested anonymous function `my_div/2`. Note that the scope of the `my_div/2` function is narrowed to the body of the `bar/3` function.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(v1, v2, v3) do
      my_div = fn
        (_, 0) -> {:error, "invalid!"}
        (x, y) -> {:ok, x/y}
      end

      case my_div.(v1, v2) do
        {:error, msg} -> msg
        {:ok, value} -> value * v3
      end
    end
  end

  #...Use examples...
  iex(1)> Foo.bar(10, 0, 5)
  "invalid!"

  iex(2)> Foo.bar(10, 2, 5)
  25.0

  iex(3)> my_div.(10, 2)
  warning: variable "my_div" does not exist...
  ** (CompileError) undefined function my_div/0...
  ```

  To widen the scope of the anonymous function `my_div/2`, we can transform it into a named function defined outside of `bar/3`. In addition, we must replace all calls to the anonymous function `my_div/2` with calls to the newly named function `my_div/2`, as shown below.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(v1, v2, v3) do
      case my_div(v1, v2) do
        {:error, msg} -> msg
        {:ok, value} -> value * v3
      end
    end

    # new multi-clause named function with widened scope!
    def my_div(_, 0), do: {:error, "invalid!"}
    def my_div(x, y), do: {:ok, x/y}
  end

  #...Use examples...
  iex(1)> Foo.bar(10, 0, 5)
  "invalid!"

  iex(2)> Foo.bar(10, 2, 5)
  25.0

  iex(3)> Foo.my_div(10, 2)
  {:ok, 5.0}

  iex(4)> Foo.my_div(10, 0)
  {:error, "invalid!"}
  ```

  Considering this example, to narrow the scope of `my_div/2`, we can perform the reverse refactoring, that is, `# After refactoring:` -> `# Before refactoring:`.

[▲ back to Index](#table-of-contents)
___

### Introduce Enum.map/2

* __Category:__ Functional Refactorings.

* __Motivation:__ The divide-and-conquer pattern refers to a computation in which a problem is recursively divided into independent subproblems, and then the subproblems' solutions are combined to obtain the solution of the original problem. Such a computation pattern can be easily parallelized because we can work on the subproblems independently and in parallel. This refactoring aims to restructure functions that utilize the divide-and-conquer pattern, making parallelization easier. Specifically, this refactoring allows us to replace a list expression in which each element is generated by calling the same function with a call to the higher-order function ``Enum.map/2``.

* __Examples:__ The following code examples demonstrate this refactoring. Before the refactoring, the `bar/2` function generates a list composed of two lists sorted by the `merge_sort/1` function.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(list, list_2) do
      [merge_sort(list), merge_sort(list_2)]
    end
  end

  #...Use examples...
  iex(1)> Foo.bar([1, 3, 9, 0, 2], [90, -5, 0, 10, 8])
  [[0, 1, 2, 3, 9], [-5, 0, 8, 10, 90]]
  ```

  After refactoring, `bar/2` retains the same behavior, but now uses the `Enum.map/2` function to generate the elements of the returned list.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(list, list_2) do
      Enum.map([list, list_2], &merge_sort/1)
    end
  end

  #...Use examples...
  iex(1)> Foo.bar([1, 3, 9, 0, 2], [90, -5, 0, 10, 8])
  [[0, 1, 2, 3, 9], [-5, 0, 8, 10, 90]]
  ```

  Note that this refactoring produces code that enables the application of [Transform to list comprehension](#transform-to-list-comprehension).

[▲ back to Index](#table-of-contents)
___

### Bindings to List

* __Category:__ Functional Refactorings.

* __Motivation:__ The divide-and-conquer pattern refers to a computation in which a problem is recursively divided into independent subproblems, and then the subproblems' solutions are combined to obtain the solution of the original problem. Such a computation pattern can be easily parallelized because we can work on the subproblems independently and in parallel. This refactoring aims to restructure functions that utilize the divide-and-conquer pattern, making parallelization easier. More precisely, this refactoring merges a series of match expressions into a single match expression that employs a list pattern.

* __Examples:__ The following code examples demonstrate this refactoring. Before the refactoring, the `bar/2` function has a sequence of two match expressions that use the `merge_sort/1` function.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(list, list_2) do
      e_1 = merge_sort(list)
      e_2 = merge_sort(list_2)
      
      # do something with e_1 and e_2 ...
    end
  end
  ```

  After refactoring, `bar/2` retains the same behavior, but now uses a single match expression with a list pattern.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(list, list_2) do
      [e_1, e_2] = [merge_sort(list), merge_sort(list_2)]
      
      # do something with e_1 and e_2 ...
    end
  end
  ```

  Note that this refactoring produces code that enables the application of [Introduce Enum.map/2](#introduce-enummap2).

[▲ back to Index](#table-of-contents)
___

### Function clauses to/from case clauses

* __Category:__ Functional Refactorings.

* __Motivation:__ The divide-and-conquer pattern refers to a computation in which a problem is recursively divided into independent subproblems, and then the subproblems' solutions are combined to obtain the solution of the original problem. Such a computation pattern can be easily parallelized because we can work on the subproblems independently and in parallel. This refactoring aims to restructure functions that utilize the divide-and-conquer pattern, making parallelization easier. More precisely, this refactoring allows transforming a multi-clause function into a single-clause function, mapping function clauses into clauses of a ``case`` statement. The reverse can also occur, i.e., mapping a ``case`` statement clause into function clauses, thus transforming a single-clause function into a multi-clause function (see [Introduce pattern matching over a parameter](#introduce-pattern-matching-over-a-parameter)).

* __Examples:__ The following code examples demonstrate this refactoring. Before the refactoring, the `merge_sort/1` function has three clauses, with two for its base cases and one for its recursive case.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def merge_sort([]), do: []    #<= base case
    def merge_sort([h]), do: [h]  #<= base case

    def merge_sort(list) do       #<= recursive case
      half = length(list) |> div(2)
      right = merge_sort(Enum.take(list, half))
      left = merge_sort(Enum.drop(list, half))
      merge(right, left)
    end
  end

  #...Use examples...
  iex(1)> Foo.merge_sort([3, 20, 9, 2, 7, 99, 80, 30])
  [2, 3, 7, 9, 20, 30, 80, 99]
  ```

  After the refactoring, `merge_sort/1` retains the same behavior, but now having only one clause, since both its base cases and recursive case were mapped into clauses of a `case` statement.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def merge_sort(list) do
      case list do
        []  -> []
        [h] -> [h]
        _   ->  half = length(list) |> div(2)
                right = merge_sort(Enum.take(list, half))
                left = merge_sort(Enum.drop(list, half))
                merge(right, left)
      end
    end
  end

  #...Use examples...
  iex(1)> Foo.merge_sort([3, 20, 9, 2, 7, 99, 80, 30])
  [2, 3, 7, 9, 20, 30, 80, 99]
  ```

  Note that this refactoring example could also be done in reverse order, that is, `# After refactoring:` -> `# Before refactoring:`.

[▲ back to Index](#table-of-contents)
___

### Transform a body-recursive function to a tail-recursive

* __Category:__ Functional Refactorings.

* __Motivation:__ In Erlang and Elixir, there are two common styles for writing recursive functions: body-recursion and tail-recursion. Body-recursion allows for the recursive call to occur anywhere within the function body, while tail-recursion specifies that the recursive call must be the last operation performed before returning. To implement a tail-recursive function, an accumulating parameter is often used to store the intermediate results of the computation. When a tail-recursive function calls itself, the Erlang VM can perform a clever optimization technique known as tail-call optimization. This means that the function can continue without waiting for its recursive call to return. This optimization can enhance code parallelization and lead to more efficient code. To take advantage of the tail-call optimization provided by the Erlang VM, this refactoring aims to convert a body-recursive function into a tail-recursive one.

* __Examples:__ The code examples below illustrate this refactoring. Prior to the refactoring, the `sum_list_elements/1` function uses body-recursion to sum all elements in a list.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def sum_list_elements([]), do: 0

    def sum_list_elements([head | tail]) do
      sum_list_elements(tail) + head
    end
  end

  #...Use examples...
  iex(1)> Foo.sum_list_elements([1, 2, 3, 4, 5, 6])
  21
  ```

  Following the refactoring, `sum_list_elements/1` retains the same behavior but now uses tail-recursion to sum all elements in a list. Note that a private recursive function `do_sum_list_elements/2` was created to support this refactoring.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def sum_list_elements(list) do
      do_sum_list_elements(list, 0)
    end

    defp do_sum_list_elements([], sum), do: sum

    defp do_sum_list_elements([head | tail], sum) do
      do_sum_list_elements(tail, sum + head)
    end
  end

  #...Use examples...
  iex(1)> Foo.sum_list_elements([1, 2, 3, 4, 5, 6])
  21
  ```

  By using the [Benchee](https://github.com/bencheeorg/benchee) library for conducting micro benchmarking in Elixir, we can highlight the performance improvement potential of this refactoring. In the following code, the `sum_list_elements/1` function is given illustrative names, `before_ref/1` and `after_ref/1`, to represent their respective body-recursive and tail-recursive versions.

  ```elixir
  list = Enum.to_list(1..1_000_000)

  Benchee.run(%{
    "body_recursive" => fn -> Foo.before_ref(list) end,
    "tail_recursive" => fn -> Foo.after_ref(list) end
  }, parallel: 4)
  ```

  Note that for a list with one million elements, the tail-recursive version can be about three times faster than the body-recursive version.

  ```bash
  Operating System: macOS
  CPU Information: Intel(R) Core(TM) i7-4578U CPU @ 3.00GHz
  Number of Available Cores: 4
  Available memory: 16 GB
  Elixir 1.14.3
  Erlang 25.2

  Benchmark suite executing with the following configuration:
  warmup: 2 s
  time: 5 s
  memory time: 0 ns
  reduction time: 0 ns
  parallel: 4
  inputs: none specified
  Estimated total run time: 14 s

  Benchmarking body_recursive ...
  Benchmarking tail_recursive ...

  Name                     ips        average  deviation         median         99th %
  tail_recursive        180.22        5.55 ms    ±32.49%        5.42 ms       15.36 ms
  body_recursive         46.39       21.56 ms    ±50.78%       20.13 ms       52.23 ms

  Comparison: 
  tail_recursive        180.22
  body_recursive         46.39 - 3.89x slower +16.01 ms
  ```

[▲ back to Index](#table-of-contents)
___

### Eliminate single branch

* __Category:__ Functional Refactoring.

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

### Transform to list comprehension

* __Category:__ Functional Refactorings.

* __Motivation:__ Elixir, like Erlang, provides several built-in ``higher-order functions`` capable of taking lists as parameters and returning new lists modified from the original. In Elixir, ``Enum.map/2`` takes a list and an anonymous function as parameters, creating a new list composed of each element of the original list with values altered by applying the anonymous function. On the other hand, the function ``Enum.filter/2`` also takes a list and an anonymous function as parameters but creates a new list composed of elements from the original list that pass the filter established by the anonymous function. A list comprehension is another syntactic construction capable to create a list based on existing ones. This feature is based on the mathematical notation for defining sets and is very common in functional languages such as Haskell, Erlang, Clojure, and Elixir. This refactoring aims to transform calls to ``Enum.map/2`` and ``Enum.filter/2`` into list comprehensions, creating a semantically equivalent code that can be more declarative and easy to read.

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

* __Category:__ Functional Refactorings.

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

* __Category:__ Functional Refactorings.

* __Motivation:__ This refactoring is the inverse of [Transform to list comprehension](#transform-to-list-comprehension) and [Nested list functions to comprehension](#nested-list-functions-to-comprehension). We can apply this refactoring to existing list comprehensions in the Elixir codebase, transforming them into semantically equivalent calls to the functions ``Enum.map/2`` or ``Enum.filter/2``.

* __Examples:__ Take a look at the examples in [Transform to list comprehension](#transform-to-list-comprehension) and [Nested list functions to comprehension](#nested-list-functions-to-comprehension) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

### Closure conversion

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from an extended Systematic Literature Review (SLR).

* __Motivation:__ This refactoring involves transforming __closures__ (*i.e.*, anonymous functions that access variables outside their scope) into functions that receive the referenced variables as parameters. This transformation is beneficial for code optimization, enhancing memory management, simplifying the code's logical understanding, and improving its readability.

* __Examples:__ In this example, ``generate_sum/1`` is a *higher-order function* because it returns an anonymous function. The returned anonymous function is a __closure__ since it uses a variable that was defined outside its scope (*i.e.*, variable ``x``).

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def generate_sum(x) do
      fn y -> x + y end   # closure example!
    end
  end

  #...Use example...
  iex(1)> add_8 = Foo.generate_sum(8)
  #Function<0.104673823/1 in Foo.generate_sum/1>

  iex(2)> result = add_8.(2)
  10
  
  iex(3)> result = add_8.(5)
  13
  ```

  After the call to `Foo.generate_sum(8)`, the variable `x` will always have the value `8` in the anonymous function assigned to `add_8`. This can be observed when this anonymous function is called with different values for its parameter `y` (*e.g.*, `2` and `5`). To optimize and improve code readability, we can perform a *__closure conversion__*, making `x` a parameter of the anonymous function returned by `generate_sum/1`, thus defining it within its scope. This refactoring, in this context, acts as a specific type of [Add or remove a parameter](#add-or-remove-a-parameter) applied to an anonymous function. Therefore, since the arity of the anonymous function has been modified, calls to this anonymous function also need to be updated, as shown below.
  
  ```elixir
  # After refactoring:

  defmodule Foo do
    def generate_sum(_x) do
      fn x, y -> x + y end   # closure conversion!
    end
  end

  #...Use example...
  iex(1)> add_8 = Foo.generate_sum(8)  # unnecessary parameter in generate_sum/1
  #Function<0.7062781/2 in Foo.generate_sum/1>

  iex(2)> result = add_8.(8,2)       
  10

  iex(3)> result = add_8.(2,2) 
  4
  ```

  Note that this refactored code still presents opportunities to apply of other refactoring strategies. Since the parameter of `generate_sum/1` is no longer needed as it is always ignored within the function, we can apply [Add or remove a parameter](#add-or-remove-a-parameter) to `generate_sum/1`, transforming it into `generate_sum/0`. Additionally, we can use [Rename an identifier](#rename-an-identifier) to update the name of the variable `add_8`, responsible for binding the anonymous function returned by the higher-order function. As both values summed by the anonymous function are now defined at the time of its call, the name `add_8` no longer makes sense.

[▲ back to Index](#table-of-contents)
___

### Replace pipeline with a function

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When utilizing a pipeline composed of built-in higher-order functions to transform data, we may unnecessarily generate large and inefficient code. This refactoring aims to replace this kind of pipeline with a function call that composes it or by invoking another built-in function with equivalent behavior. In both cases, this refactoring will reduce the number of iterations needed to perform transformations on the data, thus improving the code's performance and enhancing its readability.

* __Examples:__ In the following code, we are using a pipeline composed of chained calls to `Enum.filter/2 |> Enum.count/1` with the goal of counting how many elements in the original list are multiples of three.

  ```elixir
  # Before refactoring:

  list = Enum.to_list(1..1_000_000)

  list
  |> Enum.filter(&(rem(&1, 3) == 0))
  |> Enum.count()
  ```

  Although this code is correct, it can be refactored by replacing this pipeline with a single call to the `Enum.count/2` function, preserving the same behavior as shown below.

  ```elixir
  # After refactoring:

  list = Enum.to_list(1..1_000_000)

  Enum.count(list, &(rem(&1, 3) == 0))
  ```
  
  In addition to reducing the code volume, thereby improving readability, the refactored version has better performance than the original, as demonstrated by the benchmarking below conducted with the [Benchee](https://github.com/bencheeorg/benchee) library in Elixir.

  ```bash
  Operating System: macOS
  CPU Information: Intel(R) Core(TM) i7-4578U CPU @ 3.00GHz
  Number of Available Cores: 4
  Available memory: 16 GB
  Elixir 1.14.3
  Erlang 25.2

  Benchmark suite executing with the following configuration:
  warmup: 2 s
  time: 5 s
  memory time: 0 ns
  reduction time: 0 ns
  parallel: 4
  inputs: none specified
  Estimated total run time: 14 s

  Benchmarking original ...
  Benchmarking refactored ...

  Name                 ips        average  deviation         median         99th %
  refactored         28.38       35.24 ms    ±21.72%       33.25 ms       60.06 ms
  original           19.39       51.56 ms    ±47.66%       44.65 ms      171.97 ms

  Comparison: 
  refactored         28.38
  original           19.39 - 1.46x slower +16.32 ms
  ```

  The reason for this performance difference is that separate calls the functions ``Enum.filter/2 |> Enum.count/1`` in a pipeline require two iterations on each transformed data, while it is possible to perform just one iteration on each data with the replacement proposed by the refactoring.

  This same type of refactoring can be applied to the following pipelines:

  - ``Enum.into/3`` is better than ``Enum.map/2 |> Enum.into/2``
  - ``Enum.map_join/3`` is better than ``Enum.map/2 |> Enum.join/2``
  - ``DateTime.utc_now/1`` is better than ``DateTime.utc_now/0 |> DateTime.truncate/1``
  - ``NaiveDateTime.utc_now/1`` is better than ``NaiveDateTime.utc_now/0 |> NaiveDateTime.truncate/1``
  - One ``Enum.map/2`` is better than ``Enum.map/2 |> Enum.map/2``
  - One ``Enum.filter/2`` is better than ``Enum.filter/2 |> Enum.filter/2``
  - One ``Enum.reject/2`` is better than ``Enum.reject/2 |> Enum.reject/2``
  - One ``Enum.filter/2`` is better than ``Enum.filter/2 |> Enum.reject/2``

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.FilterCount.html)

[▲ back to Index](#table-of-contents)
___

### Remove single pipe

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ In Elixir and other languages like F#, pipes (`|>`) can be used to chain function calls, always passing the result of the previous call as the first parameter to the subsequent one. This feature can help improve the readability of code involving function composition. Although pipes can be very useful for the described purpose, they can be used unnecessarily and excessively, deviating from the intended use of this feature. This refactoring aims to remove pipes that don't involve multiple chained function calls, i.e., those that have only two members, with the first being a variable or a zero-arity function, followed by a function call with arity at least one. These removed pipes, called *__single pipes__*, are replaced by a simple call to the function with arity at least one that was its last member, thereby providing cleaner and more readable code.

* __Examples:__ In the following code, a call to the `Enum.reverse/1` function is performed using a single pipe unnecessarily.

  ```elixir
  # Before refactoring:

  list = [1,2,3,4]

  list |> Enum.reverse()  # <-- single pipe!
  ```

  To simplify this code, the refactoring will replace the single pipe with a direct call to the `Enum.reverse/1` function, preserving the behavior of the original code, as shown below.

  ```elixir
  # After refactoring:

  list = [1,2,3,4]

  Enum.reverse(list)
  ```

  These examples are based on code written in Recode's official documentation. Source: [link](https://hexdocs.pm/recode/Recode.Task.SinglePipe.html)

[▲ back to Index](#table-of-contents)
___

### Simplifying pattern matching in clauses

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ In Elixir and other functional languages, it is possible to use pattern matching to extract values in a function clause. When using pattern matching to perform deep extraction in nested ``structs``, we may create unnecessarily messy and hard-to-understand code. With this refactoring, we can simplify this kind of extraction by performing pattern matching only with the outermost ``struct`` in the nesting, instead of matching patterns with very internal ``structs``. This transformation improves code readability and reduces its size.

* __Examples:__ In the following code, the function `find_favorite_pet/1` takes a `%Post{}` struct as a parameter and uses pattern matching in the clause to extract the favorite `pet` of the author from a comment on the post. This value is deeply nested within the existing ``struct`` nesting in the definition of `%Post{}`.

  ```elixir
  # Before refactoring:

  def find_favorite_pet(%Post{comment: %Comment{author: %Author{favorite_pet: pet}}}) do
    pet
  end
  ```

  With this refactoring, we can simplify the clause of the `find_favorite_pet/1` function by performing pattern matching only with `%Post{}`, which is the outermost ``struct`` in the nesting. To access the value of the ``favorite_pet``, considering that all keys in structs are ``atoms``, we can simply perform a chaining of *strict access* to the nested values, as shown below.

  ```elixir
  # After refactoring:

  def find_favorite_pet(%Post{} = post) do
    post.comment.author.favorite_pet
  end
  ```

  This example is based on an original code by David Lucia. Source: [link](https://www.youtube.com/watch?v=wvfhrvAFOoQ)

[▲ back to Index](#table-of-contents)
___

### Improving list appending performance

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When we add an element to the end of the list, to *__ensure data immutability__*, Elixir will duplicate the entire original list, as each of its elements needs to point to a new memory area. Consequently, frequent concatenations at the end of a list can lead to significant memory consumption and hinder performance due to the need to recreate the list many times. With the aim of improving code performance during the concatenation of new elements into a list, this refactoring seeks to replace *tail concatenations* with *head concatenations*, increasing the amount of shared memory between the lists.

* __Examples:__ In the following code, we are concatenating a new element to the end of a list composed of `5_000` elements, which will result in the duplication of the entire original list in memory.

  ```elixir
  # Before refactoring:

  list = Enum.to_list(1..5_000)

  new_list = list ++ [new_element]  # <-- tail concatenation
  ```

  With this refactoring, we simply modify the position where the concatenation of a new element in the list is performed, shifting it to the beginning of the list. This allows for much more memory sharing between the lists and, consequently, improves performance.

  ```elixir
  # After refactoring:

  list = Enum.to_list(1..5_000)

  new_list = [new_element] ++ list # <-- head concatenation
  ```

  The performance difference between tail and head concatenations can be better visualized by the benchmarking below conducted with the [Benchee](https://github.com/bencheeorg/benchee) library in Elixir. Here, we can observe that the refactored version of the code exhibits significantly superior performance.

  ```bash
  Operating System: macOS
  CPU Information: Intel(R) Core(TM) i7-4578U CPU @ 3.00GHz
  Number of Available Cores: 4
  Available memory: 16 GB
  Elixir 1.14.3
  Erlang 25.2

  Benchmark suite executing with the following configuration:
  warmup: 2 s
  time: 5 s
  memory time: 0 ns
  reduction time: 0 ns
  parallel: 4
  inputs: none specified
  Estimated total run time: 14 s

  Benchmarking head_concatenation ...
  Benchmarking tail_concatenation ...

  Name                         ips        average  deviation         median         99th %
  head_concatenation        5.60 M       0.179 μs ±11846.40%       0.148 μs       0.170 μs
  tail_concatenation      0.0260 M       38.43 μs   ±431.79%       21.57 μs      104.06 μs

  Comparison: 
  head_concatenation        5.60 M
  tail_concatenation      0.0260 M - 215.31x slower +38.25 μs
  ```

* __Side-conditions:__ It is important to note that for this refactoring to be applied without altering the code's behavior, the order of elements in the list should not be important for other parts of the system.

  These examples are based on code written in Credo's official documentation. Source: [link](https://hexdocs.pm/credo/Credo.Check.Refactor.AppendSingleItem.html)

[▲ back to Index](#table-of-contents)
___

### Convert nested conditionals to pipeline

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When conditional statements, such as `if..else` and `case`, are nested to create sequences of function calls, the code can become confusing and have poor readability. In these situations, we can adapt these functions by employing [Add or remove a parameter](#add-or-remove-a-parameter) and [Introduce pattern matching over a parameter](#introduce-pattern-matching-over-a-parameter). Then we can place the calls to these modified functions in a pipeline using the Elixir pipe operator (``|>``). This is, therefore, a composite refactoring that has the potential to enhance the readability of code. This refactoring is an alternative to the [Pipeline using "with"](#pipeline-using-with).

* __Examples:__ In the following code, the function `update_game_state/3` uses nested conditional statements to control the flow of a sequence of function calls to `valid_move/2`, `players_turn/2`, and `play_turn/3`. All these sequentially called functions have a return pattern of `{:ok, _}` or `{:error, _}`, which is common in Elixir code.

  ```elixir
  # Before refactoring:

  defp update_game_state(%{status: :started} = state, index, user_id) do
    move = valid_move(state, index)
    if move == :ok do
      players_turn(state, user_id)
      |> case do
        {:ok, marker} -> {:ok, play_turn(state, index, marker)}
        other         -> other
      end
    else
      {:error, :invalid_move}
    end
  end
  ```

  Note that, although this code works perfectly, the nesting of conditionals used to ensure the safe invocation of the next function in the sequence makes the code confusing. Therefore, we can refactor it by replacing these nested conditional statements with a pipeline using pipe operators (`|>`), thereby reducing the number of lines of code and improving readability.

  ```elixir
  # After refactoring:

  defp update_game_state(%{status: :started} = state, index, user_id) do
    state
    |> valid_move(index)
    |> players_turn(state, user_id)
    |> play_turn(state, index, marker)
  end
  ```

* __Side-conditions:__ It is important to note that for this refactoring to be applied without altering the code's behavior, some functions in the pipeline had to have their signatures changed. Specifically, `players_turn/2` and `play_turn/3` became `players_turn/3` and `play_turn/4` respectively. The additional parameter in each of these functions is meant to receive the returns of the previous functions in the pipeline, which are in the patterns `{:ok, _}` or `{:error, _}`, and then guide their internal flows.

  This example is based on an original code by Gary Rennie. Source: [link](https://www.youtube.com/watch?v=V21DAKtY31Q)

[▲ back to Index](#table-of-contents)
___

### Replacing recursion with a higher-level construct

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Grey Literature Review (GLR).

* __Motivation:__ When we read code that uses recursion, it's easy to focus primarily on its mechanics, in other words, the correction of recursion and whether it will pass every test thrown at it. However, due to the level of abstraction that recursive code can have, it can become less expressive, diverting the developer's focus from what should be more important: what the algorithm does and how it does it. This can occur due to the cognitive load required for understanding recursive code, especially when it was developed by someone else. Elixir, like other functional languages, provides many higher-order functions that enable iterations while hiding the details of recursion. This refactoring transforms recursive functions into calls to higher-order functions, making the code less verbose and more maintainable.

* __Examples:__ In the following code, the module `Foo` has two recursive functions, `factorial/1` and `sum_list/1`. Both use recursion to perform iterations.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def factorial(0), do: 1
    def factorial(n), do: n * factorial(n - 1)

    def sum_list([]), do: 0
    def sum_list([head | tail]) do
      head + sum_list(tail)
    end
  end
  ```

  As shown in the following code, we can refactor these functions by replacing recursion with simple calls to `Enum.reduce/3`, which is a higher-order function. In addition to preserving their behavior, the refactored code becomes more concise and readable.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def factorial(n) do
      Enum.reduce(1..n, 1, &(&1 * &2))
    end

    def sum_list(list) do
      Enum.reduce(list, 0, &(&1 + &2))
    end
  end
  ```

  Although this example used the `Enum.reduce/3` function in the refactoring, Elixir has various other built-in higher-order functions that could be used to refactor code with different behaviors than those presented in this example.

[▲ back to Index](#table-of-contents)
___

### Replace a nested conditional in a "case" statement with guards

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Mining Software Repositories (MSR) study.

* __Motivation:__ The `case` statements allow us to compare an expression against many different patterns until we find one that matches. When more complex checks need to be performed within `case` statements, it's possible to use other conditional instructions like `if..else` nested inside a ``case``. This refactoring aims to replace nested conditional statements within a `case` with the use of guards, maintaining the ability to perform more complex pattern matching checks while improving code readability.

* __Examples:__ In the following code, the module `File.Stream` has a function `reduce/3` that uses a nested `if..else` statement within a `case` to perform a more complex pattern matching check.

  ```elixir
  # Before refactoring:

  defmodule File.Stream do
    def reduce(%{path: path, modes: modes}, acc, fun) do
      start_fun =
        fn ->
          case :file.open(path, read_modes(modes)) do
            {:ok, device} -> if :strip_bom in modes, do: strip_bom(device), else: device
            {:error, reason} -> raise(File.Error, reason)
          end
        end
      ...
    end

    ...

  end
  ```

  As shown in the following code, we can refactor this function by replacing the nested `if..else` conditional within the `case` statement with a guard clause. Not only does this preserve the behavior, but it also makes the refactored code more concise and readable.

  ```elixir
  # After refactoring:

  defmodule File.Stream do
    def reduce(%{path: path, modes: modes}, acc, fun) do
      strip_bom? = :strip_bom in modes  #<- "Merge Expression" refactoring!

      start_fun =
        fn ->
          case :file.open(path, read_modes(modes)) do
            {:ok, device} when strip_bom? -> strip_bom(device) #<- Guard replacing nested conditional!
            {:ok, device} -> device
            {:error, reason} -> raise(File.Error, reason)
          end
        end
      ...
    end

    ...

  end
  ```

  Note that in this example, we performed a composite refactoring. In order to facilitate the replacement of the nested conditional command within the `case`, we also performed the [Merge expressions](#merge-expressions) refactoring to create the local variable `strip_bom?`.

  This example is based on an original code by Andrea Leopardi. Source: [link](https://github.com/elixir-lang/elixir/pull/5702)

[▲ back to Index](#table-of-contents)
___

### Replace function call with raw value in a pipeline start

* __Category:__ Functional Refactorings.

* __Source:__ This refactoring emerged from a Mining Software Repositories (MSR) study.

* __Motivation:__ In Elixir and other functional languages such as F#, the pipe operator (``|>``) facilitates chaining function calls, consistently passing the return of one call as the initial parameter of the next. This functionality enhances the clarity of code employing function composition. While pipes can commence with a function call, they are often more readable when initiated with a ``raw`` value. This refactoring targets to change the beginning of a pipeline, extracting the initial parameter from the function call that originally starts the pipe and incorporating this value at the pipeline's start.

* __Examples:__ In the following code, the module `Foo` has a function `bar/1` that takes a list as a parameter, doubles all the values ​​in the list, and then returns the smallest of them. Disregard any performance issues that this code may have and focus solely on the format of the function pipeline used to perform this operation. Before being refactored, this pipeline starts with a call to the `Enum.map/2` function instead of a ``raw`` value, which can make it less readable.

  ```elixir
  # Before refactoring:

  defmodule Foo do
    def bar(list) do
      Enum.map(list, &(&1 * 2)) 
      |> Enum.sort 
      |> Enum.at(0)
    end
  end

   #...Use example...
  iex(1)> Foo.bar([10, 6, 90, 8, 3, 9])
  6
  ```

  As demonstrated in the following code, we can refactor this function by extracting `list`, the first parameter of `Enum.map/2`, and placing this ``raw`` value at the beginning of the pipeline. Although the refactored code has one more line than its previous version, it is more readable because it makes it clearer which value will undergo a series of sequential operations in the pipeline.

  ```elixir
  # After refactoring:

  defmodule Foo do
    def bar(list) do
      list           #<- Raw value!
      |> Enum.map(&(&1 * 2)) 
      |> Enum.sort 
      |> Enum.at(0)
    end
  end

   #...Use example...
  iex(1)> Foo.bar([10, 6, 90, 8, 3, 9])
  6
  ```

[▲ back to Index](#table-of-contents)
___

## Erlang-Specific Refactorings

Erlang-specific refactorings are those that use programming features unique to the Erlang ecosystem (e.g., OTP, typespecs, and behaviours). In this section, 11 different refactorings classified as Erlang-specific are explained and exemplified:

### Generate function specification

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ Despite being a dynamically-typed language, Elixir offers a feature to compensate for the lack of a static type system. By using ``Typespecs``, we can specify the types of each function parameter and of the return value. Utilizing this Elixir feature not only improves documentation, but also can enhance code readability and prepare it to be analyzed for tools like [Dialyzer][Dialyzer], enabling the detection of type inconsistencies, and potential bugs. The goal of this refactoring is simply to use ``Typespecs`` in a function to promote the aforementioned benefits of using this feature.

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

### From defensive to non-defensive programming style

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ This refactoring helps to transform defensive-style error-handling code written in Elixir into supervised processes. This non-defensive style, also known as "Let it crash style", isolates error-handling code from business rule code in a system. When a process is supervised in a tree, it doesn't need to worry about error handling because if errors occur, its respective supervisor will monitor and restart it.

* __Examples:__ The following code shows an example of this refactoring. Before the refactoring, we have a ``GenServer`` process responsible for keeping a numerical counter. Note that it uses the defensive style (``try..rescue``) in the callback responsible for the ``bump/2`` function. Therefore, if a non-numerical value is provided to this function, instead of a crash, the code will simply keep the counter in its current state.

  ```elixir
  # Before refactoring:

  defmodule Counter do
    use GenServer
    ...

    def bump(value, pid_name \\ __MODULE__) do
      GenServer.call(pid_name, {:bump, value})
      get(pid_name)
    end

    ## Callbacks
    ...

    @impl true
    def handle_call({:bump, value}, _from, counter) do
      try do
        {:reply, counter, counter + value}
      rescue
        _e in ArithmeticError -> {:reply, counter, counter}
      end
    end

  end

  #...Use examples...

  iex(1)> Counter.start(15, C2)
  {:ok, #PID<0.120.0>}

  iex(2)> Counter.get(C2)
  15

  iex(3)> Counter.bump(-3, C2)
  12

  iex(4)> Counter.bump("Jose", C2) 
  12          #<= unchanged counter!
  ```

  To maintain this same code behavior without using ``try..rescue`` error-handling mechanisms, we can turn ``Counter`` into a supervised process in a tree, as presented in this [code][Unsupervised process]. Therefore, if a string is provided to ``bump/2``, the process will crash but will be restarted by its supervisor with their last state.

[▲ back to Index](#table-of-contents)
___

### From meta to normal function application

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ The function `apply/3` provided by the Elixir Kernel allows calling any function that has its source module, name, and parameter list defined at runtime. This refactoring allows replacing the use of the `apply/3` function with direct calls to functions that have modules, names, and parameter lists defined at compile time.

* __Examples:__ The following code shows an example of this refactoring.

  ```elixir
  # Before refactoring:

  iex(1)> apply(Enum, :sort, [[4, 3, 2, 1]])
  [1, 2, 3, 4]
  ```

  ```elixir
  # After refactoring:

  iex(1)> Enum.sort([4, 3, 2, 1])
  [1, 2, 3, 4]
  ```

[▲ back to Index](#table-of-contents)
___

### Remove unnecessary calls to length/1

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ In Elixir, lists are always linked. Therefore, the cost of each `length/1` function call is not constant but proportional to the size of the list passed as a parameter. Considering that this cost can be high, many `length/1` calls can be unnecessary, making the code inefficient. This refactoring aims to replace these unnecessary calls, improving the efficiency of the code without modifying its behavior.

* __Examples:__ The following code shows an example of this refactoring. Consider a function `foo/1` that uses `length/1` in a guard clause to check if a list is empty. This `length/1` call is inefficient and unnecessary for very large lists.

  ```elixir
  # Before refactoring:

  defmodule Bar do
    def foo(list) when length(list) == 0 do
      :empty_list
    end

    def foo(list) when length(list) != 0 do
      :non_empty_list
    end
  end
  
  #...Use examples...
  iex(1)> Enum.to_list(1..1_000_000) |> Bar.foo() 
  :non_empty_list
  ```

  This refactoring can replace the use of `length/1` with pattern matching, resulting in a more efficient code with the same behavior, as shown below.

  ```elixir
  # After refactoring:

  defmodule Bar do
    def foo(list) when list == [] do
      :empty_list
    end

    def foo(list) when list != [] do
      :non_empty_list
    end
  end
  
  #...Use examples...
  iex(1)> Enum.to_list(1..1_000_000) |> Bar.foo() 
  :non_empty_list
  ```

[▲ back to Index](#table-of-contents)
___

### Add type declarations and contracts

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ Despite being a dynamically-typed language, Elixir offers a feature to compensate for the lack of a static type system. By using ``Typespecs``, we can specify the types of each function parameter and of the return value. Utilizing this Elixir feature not only improves documentation, but also can enhance code readability and prepare it to be analyzed for tools like [Dialyzer][Dialyzer], enabling the detection of type inconsistencies, and potential bugs. The goal of this refactoring is to use `Typespecs` to create custom data types, thereby naming recurring data structures in the codebase and increasing system readability.

* __Examples:__ The following code examples illustrate this refactoring. Prior to refactoring, we have a function ``set_background/1`` that receives a tuple of three integer elements. This function performs some processing with this tuple and returns an atom. The function interface for ``set_background/1`` is defined in the module attribute ``@spec``.

  ```elixir
  # Before refactoring:

  defmodule Foo do

    @spec set_background({integer, integer, integer}) :: atom
    def set_background(rgb) do
      #do something...
      :ok
    end
  end

  #...Use examples...
  iex(1)> Foo.set_background({150, 25, 89})
  :ok
  ```

  To easier this code understanding and leverage the other aforementioned benefits, we can generate a type specification using the ``@type`` module attribute which is a default feature of Elixir.

  ```elixir
  # After refactoring:

  defmodule Foo do

    @typedoc """
      A tuple with three integer elements between 0..255
    """
    @type color :: {red :: integer, green :: integer, blue :: integer}

    @spec set_background(color) :: atom
    def set_background(rgb) do
      #do something...
      :ok
    end
  end

  #...Use examples...
  iex(1)> Foo.set_background({150, 25, 89})
  :ok

  #...Retrieving code documentation...
  iex(2)> h Foo.set_background/1                           
  @spec set_background(color()) :: atom()

  iex(3)> t Foo.color   #<= type documentation!
  @type color() :: {red :: integer(), green :: integer(), blue :: integer()}

  A tuple with three integer elements between 0..255
  ```

  Note that with the use of ``@type``, we can easily check the type specification using Elixir's helper.

[▲ back to Index](#table-of-contents)
___

### Introduce concurrency

* __Category:__ Erlang-Specific Refactorings.

* __Note:__ Formerly known as "Introduce/remove concurrency".

* __Motivation:__ This refactoring involves introducing concurrent processes to achieve a more optimal mapping between parallel processes and parallel activities of the problem being solved. This eliminates bottlenecks by a better code design, enabling greater scalability and better performance.

* __Examples:__ An example of using this __*refactoring to introduce concurrency*__ can be seen in the following code. `Todo.Database` is a `GenServer` process that is part of a concurrent system. As can be seen in the implementation of its `start/0` function, it is a singleton, meaning there is only one `Todo.Database` process in the entire system. Since this process is responsible for providing access to the system's database for all its N different clients, bottlenecks or other issues can naturally occur. Imagine a situation where the number of calls to the `store/2` function is very large, to the point where this single `Todo.Database` process cannot handle the previous `store/2` call before the subsequent calls arrive for the same function. This could cause an overload of the `Todo.Database` mailbox, resulting in excessive memory usage and ultimately an overflow of the BEAM OS process where this system is executed.

  ```elixir
  # Before refactoring:

  defmodule Todo.Database do
    use GenServer
        
    ...

    def start do
      GenServer.start(__MODULE__, nil, name: __MODULE__) #<-- Singleton process!
    end

    def store(key, data) do
      GenServer.cast(__MODULE__, {:store, key, data})
    end

    def handle_cast({:store, key, data}, state) do
      key
      |> file_name()
      |> File.write!(:erlang.term_to_binary(data))

      {:noreply, state}
    end
        
    ...

  end
  ```

  To avoid this bottleneck in `Todo.Database`, we can refactor the callback function `handle_cast/2`, introducing concurrency by a new ``Task`` process that will be responsible for handling calls to the `store/2` function.

  ```elixir
  # After refactoring:
      
  defmodule Todo.Database do
    use GenServer
    ...

    def handle_cast({:store, key, data}, state) do
      Task.start(fn ->     #<-- Concurrency Introduced!
        key
        |> file_name()
        |> File.write!(:erlang.term_to_binary(data))
      end)

      {:noreply, state}
    end

    ...
  end
  ```

  Although `Todo.Database` continues to be a singleton process, with this refactoring, each call to the `store/2` function will be handled by a different process introduced in `handle_cast/2`, allowing for greater scalability with multiple worker processes executing concurrently.

  This example is based on an original code by Saša Jurić available in the __"Elixir in Action, 2. ed."__ book, where another possibility to introduce concurrency by using a pool of processes is also presented.

[▲ back to Index](#table-of-contents)
___

### Remove concurrency

* __Category:__ Erlang-Specific Refactorings.

* __Note:__ Formerly known as "Introduce/remove concurrency".

* __Motivation:__ This refactoring involves removing unnecessary concurrent processes and replacing them with Elixir regular modules. When processes are used to perform tasks that could be handled by regular modules, aside from compromising code readability, they can lead to excessive memory consumption and system bottlenecks due to the accumulation of unprocessed messages in the mailbox. Therefore, in addition to improving the code design and consequently its readability, this refactoring can enhance the overall performance of a system.

* __Examples:__ An example of using this __*refactoring to remove concurrency*__ can be seen in eliminating the code smell [Code organization by process][Code organization by process]. Here, we have a code that previously used processes, callbacks, and message passing where a simpler regular module and a function call would have enough. This refactoring allowed for the improvement of code quality without altering its behavior.

[▲ back to Index](#table-of-contents)
___

### Add a tag to messages

* __Category:__ Erlang-Specific Refactorings.

* __Motivation:__ In Elixir, processes run in an isolated manner, often concurrently with others. Communication between different processes is performed through message passing. This refactoring aims to adapt processes that communicate with each other by adding tags that identify groups of messages exchanged between them. This identification allows for different treatments of received messages based on their purpose or format.

* __Examples:__ The following code examples illustrate this refactoring. Prior to the refactoring, the modules ``Receiver`` and ``Sender``, which will generate distinct processes, communicate via message exchange. More specifically, the process where ``Sender`` is located sends a message that is received by the ``Receiver`` process, which in turn simply displays the message, regardless of its format.

  ```elixir
  # Before refactoring:

  defmodule Receiver do

    @doc """
      Function for receiving messages from processes.
    """
    def run() do
      receive do
        msg_received -> IO.puts("Message: #{msg_received}")
      after
        30_000 -> IO.puts("Timeout...")
      end
    end

    @doc """
      Create a process to receive a message.
      Messages are received in the run() function of Receiver.
    """
    def create() do
      spawn(Receiver, :run, [])
    end

  end
  ```
  
  ```elixir
  # Before refactoring:

  defmodule Sender do
    @doc """
      Function for sending messages between processes.
        pid_receiver: message recipient
        msg: messages of any type and size can be sent.
    """
    def send_msg(pid_receiver, msg) do
      send(pid_receiver, msg)
    end
  end

  #...Use examples...
  iex(1)> pid = Receiver.create()
  #PID<0.320.0>

  iex(2)> Sender.send_msg(pid, "Hello World!")
  Message: Hello World!
  ```

  Following the refactoring, ``Sender.send_msg/2`` has been transformed into ``Sender.send_msg/3``. Its additional parameter is responsible for receiving the `tag` that will identify the sent message. However, this parameter has a default value (`:msg`) set, so all pre-existing calls to ``Sender.send_msg/2`` will have their behavior preserved after the refactoring.
  
  ```elixir
  # After refactoring:

  defmodule Receiver do

    @doc """
      Function for receiving messages from processes.
    """
    def run() do
      receive do
        {:msg, msg_received} -> IO.puts("Message: #{msg_received}")
        {:sum, {v1, v2}} -> IO.puts("Result: #{v1 + v2}")
        {_, _} -> IO.puts("Won't match!")
      after
        30_000 -> IO.puts("Timeout...")
      end
    end

    @doc """
      Create a process to receive a message.
      Messages are received in the run() function of Receiver.
    """
    def create() do
      spawn(Receiver, :run, [])
    end

  end
  ```
  
  ```elixir
  # After refactoring:

  defmodule Sender do
    @doc """
    Function for sending messages between processes.
      pid_receiver: message recipient
      msg: messages of any type and size can be sent.
      tag: used by receiver to decide what to do
              when a message arrives.
              Default is the atom :msg
    """
    def send_msg(pid_receiver, msg, tag \\ :msg) do
      send(pid_receiver, {tag, msg})
    end
  end

  #...Use examples...
  iex(1)> pid = Receiver.create()
  #PID<0.320.0>

  iex(2)> Sender.send_msg(pid, "Hello World!")
  Message: Hello World!
  
  iex(3)> Sender.send_msg(pid, {1,2}, :sum)
  Result: 3

  iex(4)> Sender.send_msg(pid, msg, :test)
  Won't match!
  ```

  Note that all messages sent between these processes have the format of a tuple ``{tag, msg}`` after the refactoring. In addition, the function ``Receiver.run/0`` now uses pattern matching to provide different treatments for messages identified with different tags. The programmer has the freedom to adapt ``Receiver.run/0`` by configuring all message identification tags relevant to their system.

[▲ back to Index](#table-of-contents)
___

### Register a process

* __Category:__ Erlang-Specific Refactorings.

* __Motivation:__ In Elixir, processes run in an isolated manner, often concurrently with others. Communication between different processes is performed through message passing. This refactoring involves assigning a user-defined name to a process ID and using that user-defined name instead of the process ID in message passing. Any process in an Elixir system can communicate with a registered process even without knowing its ID.

* __Examples:__ The following code examples illustrate this refactoring. The modules ``Receiver`` and ``Sender`` used here are defined in the examples of [Add a tag to messages](#add-a-tag-to-messages). Prior to the refactoring, for a process to send a message specifically to the process of the ``Receiver`` module, it would need to know its identifier (`#PID<0.320.0>`).

  ```elixir
  # Before refactoring:

  iex(1)> pid = Receiver.create()
  #PID<0.320.0>

  iex(2)> Sender.send_msg(pid, "Hello World!")
  Message: Hello World!
  ```

  Following the refactoring, the process with the identifier `#PID<0.320.0>` was registered with the user-defined name `:receiver`. This enables more readable code and allows any other process in the system to communicate with this registered process using only its name.
  
  ```elixir
  # After refactoring:

  iex(1)> pid = Receiver.create()
  #PID<0.320.0>

  iex(2)> Process.register(pid, :receiver)

  iex(3)> Sender.send_msg(:receiver, "Hello World!")
  Message: Hello World!
  ```

[▲ back to Index](#table-of-contents)
___

### Behaviour extraction

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ This refactoring is similar to Extract Interface, proposed by Fowler and Beck for object-oriented languages. In Elixir, a ``behaviour`` serves as an interface, which is a contract that a module can fulfill by implementing functions in a guided way according to the formats of parameters and return types defined in the contract. A ``behaviour`` is an abstraction that defines only the functionality to be implemented, but not how that functionality is implemented. When we find a function that can be repeated in different modules but performs special roles in each of them, it can be a good idea to abstract this function by extracting it to a ``behaviour``, standardizing a contract to be followed by all modules that implement or may implement it in the future.

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
  
  iex(2)> Foo.math_operation(1, "jose")
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
  
  iex(2)> Sum.math_operation(1, "Jose")
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

* __Category:__ Erlang-specific Refactorings.

* __Motivation:__ This refactoring is the inverse of [Behaviour extraction](#behaviour-extraction). Remembering, behaviour extraction aims to define a callback to compose a standardized interface for a function in a module that acts as a ``behaviour definition`` and move the existing version of that function to another module that follows this standardization, implementing the callback (``behaviour instance``). In contrast, Behaviour inlining aims to eliminate the implementations of callbacks in a ``behaviour instance``.

* __Examples:__ To perform this elimination, the function that implements a callback in a ``behaviour instance`` is moved to the ``behaviour definition`` module using [Moving a definition](#moving-a-definition), which will handle possible naming conflicts and update references to that function. If the moved function was the only callback implemented by the ``behaviour instance`` module, the definition of the implemented behaviour (``@behaviour``) should be removed from the ``behaviour instance``, thus turning it into a regular module. Additionally, when the moved function is the last existing implementation of the callback throughout the codebase, this callback should cease to exist, being removed from the ``behaviour definition`` module.
  
  To better understand, take a look at the example in [Behaviour extraction](#behaviour-extraction) in reverse order, that is, ``# After refactoring:`` ->  ``# Before refactoring:``.

[▲ back to Index](#table-of-contents)
___

## About

This catalog was proposed by Lucas Vegi and Marco Tulio Valente, from [ASERG/DCC/UFMG][ASERG].

For more info see the following paper:

* [Towards a Catalog of Refactorings for Elixir](https://www.researchgate.net/publication/373173969_Towards_a_Catalog_of_Refactorings_for_Elixir), International Conference on Software Maintenance and Evolution (ICSME), 2023. [[slides]](https://drive.google.com/file/d/1Vv1o6_mwlCWckfFINbJNzMIU7sJ9ji01/view?usp=drive_link) [[video]](https://youtu.be/W2RI8mIcguM)

Please feel free to make pull requests and suggestions ([Issues][Issues] tab).

[▲ back to Index](#table-of-contents)

## Acknowledgments

Our research is part of the initiative called __[Research with Elixir][ResearchWithElixir]__ (in portuguese). We are supported by [Dashbit](https://dashbit.co/) and [Rebase](https://rebase.com.br/), which are companies that support this initiative:

<div align="center">
  <a href="https://dashbit.co/" alt="Click to learn more about Dashbit!" title="Click to learn more about Dashbit!"><img width="23%" src="https://github.com/lucasvegi/Elixir-Refactorings/blob/main/etc/dashbit_logo.png?raw=true"></a>
 <br><br>
  <a href="https://rebase.com.br/" alt="Click to learn more about Rebase!" title="Click to learn more about Rebase!"><img width="23%" src="https://github.com/lucasvegi/Elixir-Refactorings/blob/main/etc/rebase_logo.png?raw=true"></a>
  <br><br>
</div>

We were also supported by [Finbits](https://www.finbits.com.br/), a Brazilian Elixir-based fintech that is a supporter of this initiative:

<div align="center">
  <a href="https://www.finbits.com.br/" alt="Click to learn more about Finbits!" title="Click to learn more about Finbits!"><img width="15%" src="https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/finbits.png?raw=true"></a>
  <br><br>
</div>

[▲ back to Index](#table-of-contents)

<!-- Links -->
[Elixir Refactorings]: https://github.com/lucasvegi/Elixir-Refactorings
[Issues]: https://github.com/lucasvegi/Elixir-Refactorings/issues
[Elixir]: http://elixir-lang.org
[ASERG]: http://aserg.labsoft.dcc.ufmg.br/
[ElixirInProduction]: https://elixir-companies.com/
[Finbits]: https://www.finbits.com.br/
[ResearchWithElixir]: http://pesquisecomelixir.com.br/
[Feature Envy]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#feature-envy
[Duplicated Code]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#duplicated-code
[Long Parameter List]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#long-parameter-list
[Long Function]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#long-function
[Large Module]: https://github.com/lucasvegi/Elixir-Code-Smells/tree/main/traditional#large-class
[Unnecessary Macros]: https://github.com/lucasvegi/Elixir-Code-Smells#unnecessary-macros
[Complex extractions in clauses]: https://github.com/lucasvegi/Elixir-Code-Smells#complex-extractions-in-clauses
[Unsupervised process]: https://github.com/lucasvegi/Elixir-Code-Smells#unsupervised-process
[Code organization by process]: https://github.com/lucasvegi/Elixir-Code-Smells#code-organization-by-process
[Dialyzer]: https://hex.pm/packages/dialyxir

<!--
[ICPC-ERA]: https://conf.researchr.org/track/icpc-2022/icpc-2022-era
[preprint-copy]: https://doi.org/
[ICPC22-PDF]: https://github.com/lucasvegi/Elixir-Code-Smells/blob/main/etc/Code-Smells-in-Elixir-ICPC22-Lucas-Vegi.pdf
[ICPC22-YouTube]: https://youtu.be/3X2gxg13tXo
[Podcast-Spotify]: http://elixiremfoco.com/episode?id=lucas-vegi-e-marco-tulio
-->
