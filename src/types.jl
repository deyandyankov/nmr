type NMR
  jobid::Int
  input_filename::String
  mapper::Function
  reducer::Function
  combiner::Function
end

type MapperException <: Exception
  msg::String
end

type UDFException <: Exception
  msg::String
end
