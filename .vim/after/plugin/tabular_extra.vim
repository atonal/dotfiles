
if !exists(':Tabularize')
  finish " Give up here; the Tabular plugin musn't have been loaded
endif

AddTabularPattern! robot_variables /}\zs /l4l0l0
AddTabularPattern! clang_variable_block / ./l0
