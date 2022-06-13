`default_nettype none
module iadc_top(
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
    output wire a_probe_3,

    input wire sclk,
    input wire cs_n,
    input wire unsigned data_in,
    output reg [11:0] data_out,
    output reg new_data,
    output reg serial_data_out
);

    analog_top a_top (
	`ifdef USE_POWER_PINS
	    .vdd(vdd),
	    .vss(vss),
	`endif
        clk(clk),
        rst_n(rst_n),
        debug(debug),
        mod_op(mod_op),
        ip(ip),
        in(in),
        i_bias_1(i_bias_1),
        i_bias_2(i_bias_2),
        a_probe_0(a_probe_0),
        a_probe_1(a_probe_1),
        a_probe_2(a_probe_2),
        a_probe_3(a_probe_3)
    );

    analog_top d_filter (
    `ifdef USE_POWER_PINS
	    .vdd(vdd),
	    .vss(vss),
    `endif
        clk(clk),
        rst_n(rst_n),
        sclk(sclk),
        cs_n(cs_n),
        data_in(mod_op),
        data_out(data_out),
        new_data(new_data),
        serial_data_out(serial_data_out)
    );

    sky130_fd_pr__cap_mim_m3_1_PXTAZD pxtazd_decap (
        .m4(vdd),
        .m3(vss)
    );


endmodule
`default_nettype wire
