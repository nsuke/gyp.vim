" Vim syntax file
" Language:     Gyp
" Maintainer:   Kelan Champagne  (http://yeahrightkeller.com)
" URL:          https://github.com/kelan/gyp.vim

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif


syn keyword gypCommentTodo      TODO FIXME XXX TBD contained
syn match   gypLineComment      "#.*" contains=@Spell,gypCommentTodo

syn region  gypStringS          start=+'+  end=+'\|$+  contains=gypSection,gypTargetSection
syn match   gypNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"

syn keyword gypSection          variables includes targets conditions target_defaults
syn keyword gypTargetSection    actions all_dependent_settings configurations defines dependencies direct_dependent_settings include_dirs libraries link_settings sources target_conditions target_name type msvs_props xcode_config_file xcode_framework_dirs mac_bundle_resources xcode_settings destination files inputs outputs copies default_configuration dependencies_original postbuilds product_dir product_extension product_name product_prefix rules run_as standalone_static_library suppress_wildcard toolset toolsets process_outputs_as_sources action rule action_name rule_name cflags cflags_c cflags_cc ldflags

syn keyword gypPredefined       PRODUCT_DIR INTERMEDIATE_DIR SHARED_INTERMEDIATE_DIR EXECUTABLE_PREFIX EXECUTABLE_SUFFIX SHARED_LIB_PREFIX SHARED_LIB_SUFFIX STATIC_LIB_PREFIX STATIC_LIB_SUFFIX RULE_INPUT_ROOT RULE_INPUT_EXT RULE_INPUT_NAME RULE_INPUT_PATH DEPTH executable static_library shared_library OS

if exists("gyp_fold")
    syn match gypFunction "\<function\>"
    syn region  gypFunctionFold start="\<function\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match gypSync  grouphere gypFunctionFold "\<function\>"
    syn sync match gypSync  grouphere NONE "^}"

    setlocal foldmethod=syntax
    setlocal foldtext=getline(v:foldstart)
else
    syn keyword gypFunction function
    syn match gypBraces    "[{}\[\]]"
    syn match gypParens    "[()]"
endif

syn sync fromstart
syn sync maxlines=100

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_gyp_syn_inits")
  if version < 508
    let did_gyp_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink gypComment          Comment
  HiLink gypLineComment      Comment
  HiLink gypCommentTodo      Todo
  HiLink gypNumber           gypValue
  HiLink gypStringS          String

  HiLink gypSection          Special
  HiLink gypTargetSection    Conditional
  HiLink gypPredefined       SpecialChar

  delcommand HiLink
endif

let b:current_syntax = "gyp"
