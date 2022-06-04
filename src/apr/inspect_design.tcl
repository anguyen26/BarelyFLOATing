puts $BUFFER_TREE_NET_NAMES

if {$BUILD_BUFFER_TREES} {
   if {$BUFFER_TREE_NET_NAMES != ""} {
      set hfo_nets [get_nets $BUFFER_TREE_NET_NAMES]
      report_buffer_tree -from $hfo_nets -hierarchy -nosplit
   }
}
