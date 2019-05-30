build-lists: true
slide-dividers: #

# Using Semantic Types to Squash Bugs

# Why is this hard?

- Wrap early
- Unwrap late
- Hard to enforce when it's a String whether it's wrapped or not

# Principle

Use types to represent what the thing is.

- Cheap to start with
- Gives you a solid path to evolve and extract to a module

# Can't we just fix it?

- We could!
- If I can eliminate a class of errors, I want to!

# Goal

- Change the type in a single place
- Address all of the compiler errors
- End up with the bug fixed

# Problem

- Okay, that made it easier to unwrap late
- Can I make it impossible?

# Opaque Types

- Just means "private constructor"
  - Move to module
  - Hide the constructor
  - (But expose the type for annotations)
  - Make functions for using it

```haskell
module PositiveInt exposing (PositiveInt(..))

type PositiveInt = PositiveInt Int
```

# The path of evolving types

- Primitives
- Type with public constructor
- Move to module
- Accessors (get/set) instead of constructor
  - i.e. things that give back the raw value
- "One-stop-shop" (no accessors)
