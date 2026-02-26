# cpue errors when input is not numeric

    Code
      cpue("five", 10)
    Condition
      Error:
      ! Unsupported input type for cpue():character

# cpue warns when cathc and effort lengths differ

    Code
      cpue(c(100, 20, 30), c(20, 5))
    Condition
      Warning in `catch / effort`:
      longer object length is not a multiple of shorter object length
    Output
      CPUE results for 3  records
      Method:  ratio 
      Gear factor: 1 
      Values:  5 4 1.5 

# cpue uses verbosity when global options is set to TRUE

    Code
      cpue(10, 10)
    Message
      Processing 1 records using ratio method
    Output
      CPUE results for 1  records
      Method:  ratio 
      Gear factor: 1 
      Values:  1 

# print.cpue_result displays expected output

    Code
      print(result)
    Output
      CPUE results for 3  records
      Method:  ratio 
      Gear factor: 1 
      Values:  10 10 20 

