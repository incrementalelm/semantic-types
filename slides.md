build-lists: true
slide-dividers: #

# Using Semantic Types to Squash Bugs

# The Code

# -

```elm
googleLink : String -> String
googleLink rawValue =
  -- I promise, this is the raw value!
```

# -

![150%](./believe.gif)

# Opaque Types

# Rules

1. Wrap early
1. Unwrap late

# 1. Wrap Early

- The earlier the better
- Best case?
- Prove its origin

# 2. Unwrap Late

- Never pass the primitive anywhere until the moment of use

# Steps

1. Create new module
1. Create opaque type

# Why Not Just "Fix It"?

- Could go in and read the code and find the problem.
- Ordering of things I trust
  - Comments
  - Parameter names
  - Types
  - Gatekeeper types
- I don't want to fix it once. I want to prevent it from happening again.

# Why do you trust semantic types more than variable names?

- Levels of trust
  - Comment
  - Variable name
  - Function name (to convert from type)
  - Type
- Why?
  - How much support does the compiler give me?
  - How likely am I to change it when the meaning changes?
