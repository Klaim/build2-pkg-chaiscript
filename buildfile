

root_dir = $src_base/chaiscript
include_dir = $root_dir/include
source_dir = $root_dir/src
staticlibs_dir = $root_dir/static_libs
headers = {hxx}{$include_dir/**}


cc.poptions =+ "-I$include_dir"

liba{chaiscript_stdlib} : {hxx cxx}{$staticlibs_dir/chaiscript_stdlib}
liba{chaiscript_parser} : {hxx cxx}{$staticlibs_dir/chaiscript_parser}

exe{chai} : cxx{$source_dir/main} chaiscript_stdlib chaiscript_parser

# workaround msvc preprocessor issue: https://lists.build2.org/archives/users/2018-March/000290.html
if ($cxx.id == 'msvc')
    obj{*}: cc.reprocess = true


#####################################################################################
# This is extracted from dependencies from build2 repos,
# this is the way they setup their dependencies packages.
# Uncomment and complete once we are ready to actually publish
# a package.

#
#./: {*/ -build/} doc{INSTALL README version} file{manifest}
#
## The version file is auto-generated (by the version module) from manifest.
## Include it in distribution and don't remove when cleaning in src (so that
## clean results in a state identical to distributed).
##
#doc{version}: file{manifest}
#doc{version}: dist  = true
#doc{version}: clean = ($src_root != $out_root)
#
## Don't install tests or the INSTALL file.
##
#dir{test/}:      install = false
#doc{INSTALL}@./: install = false

######################################################################################


