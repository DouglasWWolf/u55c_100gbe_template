//====================================================================================
//                        ------->  Revision History  <------
//====================================================================================
//
//   Date     Who   Ver  Changes
//====================================================================================
// 04-Apr-25  DWW     1  Initial creation
//====================================================================================

/*

    Manages the Ethernet/QSFP status LEDs

    The order of the LEDS is:
        leds[0] = The green activity LED
        leds[1] = The green link-status LED
        leds[2] = The yellow link-status LED

*/

//`define IMPLEMENT_ACTIVITY

module u55c_leds #(FREQ_HZ = 250000000)
(
    input   clk,
    input   async_link_status,
    
    `ifdef IMPLEMENT_ACTIVITY
    input   activity,
    `endif

    output[2:0] leds

);

`ifndef IMPLEMENT_ACTIVITY
    assign leds[0] = 0;
`endif

wire link_status;

// The green status LED is on when we have ethernet link
assign leds[1] = (link_status == 1);

// The yellow LED is on when the ethernet link is down.
assign leds[2] = (link_status == 0);

//=============================================================================
// Synchronize "async_link_status" into "link_status"
//=============================================================================
xpm_cdc_single #
(
   .DEST_SYNC_FF(4),   
   .INIT_SYNC_FF(0),   
   .SIM_ASSERT_CHK(0), 
   .SRC_INPUT_REG(0)   
)
sync_link_stat
(
   .dest_out(link_status), 
   .dest_clk(clk), 
   .src_in  (async_link_status)
);
//=============================================================================


endmodule


