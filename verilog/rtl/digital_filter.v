`default_nettype none
module digital_filter (
`ifdef USE_POWER_PINS
    inout vdd,
    inout vss,
`endif
    input wire clk,
    input wire rst_n,
    input wire sclk,
    input wire cs_n,
    input wire unsigned data_in,
    output reg [11:0] data_out,
    output reg new_data,
    output reg serial_data_out
);



endmodule
`default_nettype wire
