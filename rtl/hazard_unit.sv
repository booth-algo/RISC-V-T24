module hazard_unit (
    input logic [4:0] Rs1_E,
    input logic [4:0] Rs2_E,
    input logic [4:0] Rd_M,
    input logic [4:0] Rd_W,
    input logic RegWrite_M,
    input logic RegWrite_W,
    output logic [1:0] forwardA_E,
    output logic [1:0] forwardB_E

);

    // Data hazard
    always_comb begin
        // forwardA_E
        // 00 : RD1_E : no forwarding
        // 01 : Result_W : forwarding from EX/MEM (after data memory)
        // 10 : ALUResult_M : forwarding from MEM/WB (after ALU)

        if (RegWrite_M && (Rd_M != 0) && (Rd_M == Rs1_E)) begin
            forwardA_E = 2'b10;
        end 
        else if (RegWrite_W && (Rd_W != 0) && (Rd_W == Rs1_E)) begin
            forwardA_E = 2'b01;
        end 
        else begin
            forwardA_E = 2'b00;
        end

        // forwardB_E
        // 00 : RD2_E : no forwarding
        // 01 : Result_W : forwarding from EX/MEM (after data memory)
        // 10 : ALUResult_M : forwarding from MEM/WB (after ALU)

        if (RegWrite_M && (Rd_M != 0) && (Rd_M == Rs2_E)) begin
            forwardB_E = 2'b10;
        end 
        else if (RegWrite_W && (Rd_W != 0) && (Rd_W == Rs2_E)) begin
            forwardB_E = 2'b01;
        end 
        else begin
            forwardB_E = 2'b00;
        end
    end

    // Control hazard

    // Stall control

    // Flush control



endmodule
