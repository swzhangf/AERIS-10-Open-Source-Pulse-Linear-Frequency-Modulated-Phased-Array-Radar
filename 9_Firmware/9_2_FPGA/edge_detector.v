module edge_detector_enhanced (
    input wire clk,
    input wire reset_n,
    input wire signal_in,
    output wire rising_falling_edge
);

(* ASYNC_REG = "TRUE" *) reg signal_in_prev;
(* ASYNC_REG = "TRUE" *) reg signal_in_prev2;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        signal_in_prev <= 1'b0;
        signal_in_prev2 <= 1'b0;
    end else begin
        signal_in_prev <= signal_in;
        signal_in_prev2 <= signal_in_prev;
    end
end

// Rising edge: was low, now high (with synchronization) signal_in_prev & ~signal_in_prev2;
//Falling edge: was high, now low (with synchronization) falling_edge = ~signal_in_prev & signal_in_prev2
assign rising_falling_edge = (signal_in_prev & ~signal_in_prev2)|(~signal_in_prev & signal_in_prev2);


endmodule