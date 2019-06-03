build-lists: true
slide-dividers: #

# Using Semantic Types to Squash Bugs

# The app

# Elm syntax

# The Elm Architecture

```elm
type alias Model =
    { ssnInput : String
    , ssnFocus : FocusState
    }

```

# Let's fix the bug!

# The bug from fixing the bug

- This isn't rocket science
- Trial and error

# Fix it, and keep it fixed

- Tests
- Code reviews
- Checklists
- ... 🤔
- Am I really confident it will stay fixed?
- Let's try to eliminate a class of errors!

^ Tests only test what we remember to test
Manually check wrap early...
let's make it easier

# Goal

1. Change the type in a single place
1. Address all of the compiler errors
1. End up with the bug fixed

# Fix it - for real this time!

# Rule of thumb

- Wrap early
- Unwrap late
- But it's a String whether it's wrapped or not

# Tip

Use types to represent what the thing is.

- Semantic types!
- Cheap to start with
- Good stepping stone

# Evolving our type

1. Primitives
1. Type with public constructor

# Problem

- Okay, that made it easier to unwrap late
- Can I make it impossible?

# What are modules?

1. Group types and functions
1. Hide some of them

- The groupings determine what can be hidden
- Ways to organize
- Construct (`Types.elm`, `Views.elm`)
  - Have to expose everything
  - Hard to navigate
- Type & domain concept

# Opaque Types

- Just means "private constructor"
  1. Move to module
  1. Hide the constructor
  1. (But expose the type for annotations)
  1. Make functions for using it

# -

![fit](./img/opaque-types-0.png)

# -

![fit](./img/opaque-types-1.png)

# -

![fit](./img/opaque-types-2.png)

# -

![fit](./img/opaque-types-3.png)

# -

![fit](./img/opaque-types-4.png)

# -

![inline original 100%](./img/opaque-types-4.png)

- Opaque ✅
- Blackbox
- Invert responsibility

# Continuing down the path

1. Primitives
1. Type with public constructor
1. Move to module
1. Control the entrance (accessor, but no constructor)
1. Control the exits (no accessors)
1. "One-stop-shop"

- Invert responsibility

# Adapter

- Decouple the arguments from things owned in Main
  - Model
  - Msg
- Easier to iterate in the same file
- "Make the change easy, then make the easy change." - Kent Beck

# How it helps

- Only one places to make sure its secure
- Only one place if we add encryption/decryption

# Cues

- Enforce constraint
- `ssnInput`, `maskedSsn`, `getSsn`, ...
- Long import list
- Too many responsibilities

^ Our constraint was security

# Thank you!
