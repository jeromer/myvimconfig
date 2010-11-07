inoremap [ []<LEFT>
inoremap ( (  )<LEFT><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap { {}<LEFT>

" Use 4 spaces for (auto)indent
set shiftwidth=4

" Use 4 spaces for <Tab> and :retab
set tabstop=4

" tabs are expanded to spaces
set expandtab

" convert 'tab' as >-
" convert trailing spaces as '-'
set listchars=tab:>-,trail:-

set makeprg=php\ \.\/bin\/php\/eztemplatecheck\.php\ --debug=error\ --no-colors\ %

" match Error / __ /

" attribute_view_gui
iabbrev ezavg {attribute_view_gui attribute=
" node_view_gui
iabbrev eznvg {node_view_gui view= content_node=

"""""""""" Control structures
"iabbrev ezfe {foreach __ as $k => $val}<CR><CR>{/foreach}
"iabbrev ezfes {foreach __ as $k => $val sequence array( __ ) as $seq}<CR><CR>{/foreach}

"""""""""" Fetch
"iabbrev ezfcn fetch(content, node, hash('node_id' , __ ))<ESC>4h

" content list
"iabbrev ezfcl fetch(content, list, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfcls fetch(content, list, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfcla fetch(content, list, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfclas fetch(content, list, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfclsa fetch(content, list, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))

" content list_count
"iabbrev ezfclc fetch(content, list_count, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfclca fetch(content, list_count, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))

" content tree
"iabbrev ezfct fetch(content, tree, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfcts fetch(content, tree, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfcta fetch(content, tree, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfctas fetch(content, tree, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfctsa fetch(content, tree, hash('parent_node_id', __ ,<CR>'class_filter_type', include,<CR>'class_filter_array', array( __ ),<CR>'sort_by', array( __ ),<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))

" content tree_count
"iabbrev ezfctc fetch(content, tree_count, hash('parent_node_id', __ ,<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))
"iabbrev ezfctca fetch(content, tree_count, hash('parent_node_id', __ ,<CR>'attribute_filter', array( __ ),<CR>'offset', $view_paremeters.offset,<CR>'limit', __ ))