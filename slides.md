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
