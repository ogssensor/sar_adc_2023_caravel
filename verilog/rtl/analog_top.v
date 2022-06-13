`default_nettype none
module analog_top(
`ifdef USE_POWER_PINS
    inout vdd,
    inout vss,
`endif
    input wire clk,
    input wire rst_n,
    input wire debug,
    output wire mod_op,

    input wire ip,
    input wire in,
    input wire i_bias_1,
    input wire i_bias_2,
    output wire a_probe_0,
    output wire a_probe_1,
    output wire a_probe_2,
    output wire a_probe_3
);



endmodule
`default_nettype wire
