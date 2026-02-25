# error on invalid input

    Code
      biomass_index("ten", 5)
    Message
      Processing 1 records
    Condition
      Error in `cpue * area_swept`:
      ! non-numeric argument to binary operator

# biomass uses verbosity when global options is set to TRUE

    Code
      biomass_index(10, 10)
    Message
      Processing 1 records
    Output
      [1] 100

