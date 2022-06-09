# Library setup
# ==========================================================================
puts $PROCESS

if {$PROCESS == "65LP"} {
   # Logic libraries 
   set TSMC_PATH "$env(PDKS)/tsmc/N65LP/digital"
   set TARGETCELLLIB_PATH "$TSMC_PATH/Front_End/timing_power_noise/NLDM/tcbn65lp_200a"
   set ADDITIONAL_SEARCH_PATHS [list \
      "$TARGETCELLLIB_PATH" \
      "$TSMC_PATH/Back_End/milkyway/tcbn65lp_200a/cell_frame/tcbn65lp/LM/*" \
      "$synopsys_root/libraries/syn" \
      "./" \
   ]

   # Technology files
   set MW_TECHFILE_PATH "$TSMC_PATH/Back_End/milkyway/tcbn65lp_200a/techfiles"
   set MW_TLUPLUS_PATH "$MW_TECHFILE_PATH/tluplus"
   set MAX_TLUPLUS_FILE "cln65lp_1p09m+alrdl_rcbest_top2.tluplus"
   set MIN_TLUPLUS_FILE "cln65lp_1p09m+alrdl_rcworst_top2.tluplus"

   # Reference libraries 
   set MW_REFERENCE_LIBS "$TSMC_PATH/Back_End/milkyway/tcbn65lp_200a/frame_only/tcbn65lp"
   set SYNOPSYS_SYNTHETIC_LIB "dw_foundation.sldb"

   # set specific corner libraries
   # WC - 0.9V 
   if {$CORNER == "LOW"} {
      # Target corners
      set TARGET_LIBS [list \
         "tcbn65lptc1d0.db" \
         "tcbn65lpbc1d1.db" \
         "tcbn65lpwc0d9.db" \
      ]
      set SYMBOL_LIB "tcbn65lptc1d0.db"
      # Worst case library
      set LIB_WC_FILE   "tcbn65lpwc0d9.db"
      set LIB_WC_NAME   "tcbn65lpwc0d9"
      # Best case library
      set LIB_BC_FILE   "tcbn65lpbc1d1.db"
      set LIB_BC_NAME   "tcbn65lpbc1d1"
      # Operating conditions
      set LIB_WC_OPCON  "WC0D9COM"
      set LIB_BC_OPCON  "BC1D1COM"
   # TC - 1.2V
   } elseif {$CORNER == "HIGH"} {
      # Target corners
      set TARGET_LIBS [list \
         "tcbn65lptc.db" \
         "tcbn65lpbc.db" \
      ]
      set SYMBOL_LIB "tcbn65lptc.db"
      # Worst case library
      set LIB_WC_FILE   "tcbn65lptc.db"
      set LIB_WC_NAME   "tcbn65lptc"
      # Best case library
      set LIB_BC_FILE   "tcbn65lpbc.db"
      set LIB_BC_NAME   "tcbn65lpbc"
      # Operating conditions
      set LIB_WC_OPCON  "NCCOM"
      set LIB_BC_OPCON  "BCCOM"
   }

} elseif {$PROCESS == "65GP"} {
   # Logic libraries 
   set TSMC_PATH "/home/lab.apps/vlsiapps/kits/tsmc/N65RF/1.0c/digital"
   set TARGETCELLLIB_PATH "$TSMC_PATH/Front_End/timing_power_noise/NLDM/tcbn65gplus_140b"
   set ADDITIONAL_SEARCH_PATHS [list \
      "$TARGETCELLLIB_PATH" \
      "$TSMC_PATH/Back_End/milkyway/tcbn65gplus_200a/cell_frame/tcbn65gplus/LM/*" \
      "$synopsys_root/libraries/syn" \
      "./" \
   ]
   set TARGET_LIBS [list \
      "tcbn65gplustc0d8.db" \
      "tcbn65gplusbc0d88.db" \
   ]
   set SYMBOL_LIB "tcbn65gplustc0d8.db"
   set SYNOPSYS_SYNTHETIC_LIB "dw_foundation.sldb"

   # Reference libraries 
   set MW_REFERENCE_LIBS "$TSMC_PATH/Back_End/milkyway/tcbn65gplus_200a/frame_only/tcbn65gplus"
   set MW_ADDITIONAL_REFERENCE_LIBS {}

   # Worst case library
   set LIB_WC_FILE   "tcbn65gplustc0d8.db"
   set LIB_WC_NAME   "tcbn65gplustc0d8"

   # Best case library
   set LIB_BC_FILE   "tcbn65gplusbc0d88.db"
   set LIB_BC_NAME   "tcbn65gplusbc0d88"

   # Operating conditions
   set LIB_WC_OPCON  "NC0D8COM"
   set LIB_BC_OPCON  "BC0D88COM"

   # Technology files
   set MW_TECHFILE_PATH "$TSMC_PATH/Back_End/milkyway/tcbn65gplus_200a/techfiles"
   set MW_TLUPLUS_PATH "$MW_TECHFILE_PATH/tluplus"
   set MAX_TLUPLUS_FILE "cln65g+_1p09m+alrdl_rcbest_top2.tluplus"
   set MIN_TLUPLUS_FILE "cln65g+_1p09m+alrdl_rcworst_top2.tluplus"

} elseif {$PROCESS == "65LP_LVT"} {
   # Logic libraries 
   set TSMC_PATH "$env(PDKS)/tsmc/N65LP/digital"
   set TARGETCELLLIB_PATH "$TSMC_PATH/Front_End/timing_power_noise/NLDM/tcbn65lplvt_200a"
   set ADDITIONAL_SEARCH_PATHS [list \
      "$TARGETCELLLIB_PATH" \
      "$TSMC_PATH/Back_End/milkyway/tcbn65lplvt_200a/cell_frame/tcbn65lp/LM/*" \
      "$synopsys_root/libraries/syn" \
      "./" \
   ]

   # Technology files
   set MW_TECHFILE_PATH "$TSMC_PATH/Back_End/milkyway/tcbn65lplvt_200a/techfiles"
   set MW_TLUPLUS_PATH "$MW_TECHFILE_PATH/tluplus"
   set MAX_TLUPLUS_FILE "cln65lp_1p09m+alrdl_rcbest_top2.tluplus"
   set MIN_TLUPLUS_FILE "cln65lp_1p09m+alrdl_rcworst_top2.tluplus"

   # Reference libraries 
   set MW_REFERENCE_LIBS "$TSMC_PATH/Back_End/milkyway/tcbn65lplvt_200a/frame_only/tcbn65lplvt"
   set SYNOPSYS_SYNTHETIC_LIB "dw_foundation.sldb"

   # set specific corner libraries
   # WC - 0.9V 
   if {$CORNER == "LOW"} {
      # Target corners
      set TARGET_LIBS [list \
         "tcbn65lplvttc1d0.db" \
         "tcbn65lplvtbc1d1.db" \
         "tcbn65lplvtwc0d9.db" \
      ]
      set SYMBOL_LIB "tcbn65lplvttc1d0.db"
      # Worst case library
      set LIB_WC_FILE   "tcbn65lplvtwc0d9.db"
      set LIB_WC_NAME   "tcbn65lplvtwc0d9"
      # Best case library
      set LIB_BC_FILE   "tcbn65lplvtbc1d1.db"
      set LIB_BC_NAME   "tcbn65lplvtbc1d1"
      # Operating conditions
      set LIB_WC_OPCON  "WC0D9COM"
      set LIB_BC_OPCON  "BC1D1COM"
   # TC - 1.2V
   } elseif {$CORNER == "HIGH"} {
      # Target corners
      set TARGET_LIBS [list \
         "tcbn65lplvttc.db" \
         "tcbn65lplvtbc.db" \
      ]
      set SYMBOL_LIB "tcbn65lplvttc.db"
      # Worst case library
      set LIB_WC_FILE   "tcbn65lplvttc.db"
      set LIB_WC_NAME   "tcbn65lplvttc"
      # Best case library
      set LIB_BC_FILE   "tcbn65lplvtbc.db"
      set LIB_BC_NAME   "tcbn65lplvtbc"
      # Operating conditions
      set LIB_WC_OPCON  "NCCOM"
      set LIB_BC_OPCON  "BCCOM"
   }
}
