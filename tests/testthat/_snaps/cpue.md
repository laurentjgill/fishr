# cpue errors when input is not numeric

    Code
      cpue("five", 10)
    Condition
      Error:
      ! 'catch' must be numeric, got character.

# cpue warns when cathc and effort lengths differ

    Code
      cpue(c(100, 20, 30), c(20, 5))
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      [1] 5.0 4.0 1.5
      attr(,"method")
      [1] "ratio"
      attr(,"gear_factor")
      [1] 1
      attr(,"n_records")
      [1] 3
      attr(,"class")
      [1] "cpue_results"

# cpue uses verbosity when global options is set to TRUE

    Code
      cpue(10, 10)
    Message
      Processing 1 records using ratio method
    Output
      [1] 1
      attr(,"method")
      [1] "ratio"
      attr(,"gear_factor")
      [1] 1
      attr(,"n_records")
      [1] 1
      attr(,"class")
      [1] "cpue_results"

# print.cpue_result displays expected output

    Code
      print(result)
    Output
      [1] 10 10 20
      attr(,"method")
      [1] "ratio"
      attr(,"gear_factor")
      [1] 1
      attr(,"n_records")
      [1] 3
      attr(,"class")
      [1] "cpue_results"

