`default_nettype none

module iadc (
    input wire clk,
    input wire rst_n,
    input wire debug,
    input wire new_data,
    output reg [11:0] data_out,
    output reg mod_op,
    output reg shift,
    output reg serial_data_out,
    output reg d_probe_0,
    output reg d_probe_1,
    output reg d_probe_2,
    output reg d_probe_3,
    
    input wire [1:0] d_clk_grp_1_ctrl,
    input wire [1:0] d_clk_grp_2_ctrl,
    input wire [1:0] a_mod_grp_ctrl,

    output wire op1,
    output wire op2,
    output wire on1,
    output wire on2,
    input wire ip,
    input wire in,
    output wire a_probe_0,
    output wire a_probe_1,
    input wire i_bias_1,
    input wire i_bias_2
);






endmodule 

`default_nettype wire