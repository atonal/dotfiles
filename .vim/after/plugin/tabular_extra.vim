
if !exists(':Tabularize')
  finish " Give up here; the Tabular plugin musn't have been loaded
endif

AddTabularPattern! robot_variables /}\zs /l4l0l0

AddTabularPattern! align_consecutive_assignments /[^[:space:]]\+ *= *[^[:space:]]\+/l1
AddTabularPattern! align_consecutive_declarations /=/l1

AddTabularPipeline! clang_variable_block / /
      \ map(a:lines, "substitute(v:val, '^ *', '', '')")
      \ | tabular#TabularizeStrings(a:lines, '[^[:space:]]\+ *= *[^[:space:]]\+', 'l1')
      \ | tabular#TabularizeStrings(a:lines, '=', 'l1')
