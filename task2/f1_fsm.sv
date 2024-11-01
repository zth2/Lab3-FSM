module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    output  logic [7:0] data_out
);

    typedef enum logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge rst) 
        if (rst)
            state <= S0;
        else
            state <= next_state;
    always_comb begin
        next_state = state;
        data_out = 8'b0000_0000;

        case (state)
            S0: begin
                data_out = 8'b0000_0000;
                if (en) next_state = S1;
            end
            S1: begin
                data_out = 8'b0000_0001;
                if (en) next_state = S2;
            end
            S2: begin
                data_out = 8'b0000_0011;
                if (en) next_state = S3;
            end
            S3: begin
                data_out = 8'b0000_0111;
                if (en) next_state = S4;
            end
            S4: begin
                data_out = 8'b0000_1111;
                if (en) next_state = S5;
            end
            S5: begin
                data_out = 8'b0001_1111;
                if (en) next_state = S6;
            end
            S6: begin
                data_out = 8'b0011_1111;
                if (en) next_state = S7;
            end
            S7: begin
                data_out = 8'b0111_1111;
                if (en) next_state = S8;
            end
            S8: begin
                data_out = 8'b1111_1111;
                if (en) next_state = S0; 
            end
            default: begin
                data_out = 8'b0000_0000;
                next_state = S0;
            end
        endcase
    end

endmodule
