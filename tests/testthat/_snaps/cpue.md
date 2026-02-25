# cpue errors when input is not numeric

    Code
      cpue("five", 10)
    Condition
      Error:
      ! 'catch' must be numeric, got character.

# cpue warns when cathc and effort lengths differ

    Code
      cpue(c(100, 20, 30), c(20, 5))
    Message
      Processing 3 records
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      [1] 5.0 4.0 1.5

# cpue uses verbosity when global options is set to TRUE

    Code
      cpue(10, 10)
    Output
      [1] 1

