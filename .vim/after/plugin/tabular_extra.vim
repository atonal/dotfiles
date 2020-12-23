
if !exists(':Tabularize')
  finish " Give up here; the Tabular plugin musn't have been loaded
endif

AddTabularPattern! robot_variables /}\zs /l4l0l0

AddTabularPattern! align_consecutive_assignments /[^[:space:]]\+ *= *[^[:space:]]\+/l1
AddTabularPattern! align_consecutive_declarations /=/l1

" TODO: indent
AddTabularPipeline! clang_variable_block /=/
      \ map(a:lines, "substitute(v:val, '.\\zs \\{2,}' , ' ' , 'g')")
      \ | map(a:lines, 'execute("normal! ==")')
      \ | tabular#TabularizeStrings(a:lines, '\S\+\s*=\s*.\+', 'l1')
      \ | tabular#TabularizeStrings(a:lines, '=', 'l1')

AddTabularPipeline! suppress_spaces / /
      \ map(a:lines, "substitute(v:val, '  *' , ' ' , 'g')")

AddTabularPipeline! variable_block /=/
      \ tabular#TabularizeStrings(a:lines, '[^[:space:]]\+ *= *.\+', 'l1')
