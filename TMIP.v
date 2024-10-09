module TMIP(
    // input signals
    clk,
    rst_n,
    in_valid,
    in_valid2,

    image,
    template,
    image_size,
	action,

    // output signals
    out_valid,
    out_value
    );

input            clk, rst_n;
input            in_valid, in_valid2;

input      [7:0] image;
input      [7:0] template;
input      [1:0] image_size;
input      [2:0] action;

output reg       out_valid;
output reg       out_value;

//==================================================================
// parameter & integer
//==================================================================


//==================================================================
// reg & wire
//==================================================================
integer file,ans_read;
reg[19:0] golden_ans;
integer golden_ans_size;
//==================================================================
// design
//==================================================================
initial begin
    file = $fopen("C:/Users/jacky/Desktop/LAB5_PATTERN/output.txt", "r");
    out_valid = 0;
    out_value = 0;
    ans_read = $fscanf(file,"%d",golden_ans_size);

    while(in_valid !== 1) begin
        @(posedge clk);
    end

    // wait in_valid signals pulls down
    while(in_valid !== 0) begin
        @(posedge clk);
    end

    repeat(4) @(posedge clk);

    // wait in_valid2 signals pulls down
    while(in_valid2 !== 0) begin
        @(posedge clk);
    end

    repeat(5) @(posedge clk);

    for(integer i = 0; i < golden_ans_size; i = i + 1) begin
        ans_read = $fscanf(file,"%b",golden_ans);
        for(integer j = 0; j < 20; j = j + 1) begin
            out_valid = 1;
            out_value = golden_ans[19-j];
            @(posedge clk);
        end
    end
    out_valid = 0;
    out_value = 0;
    $fclose(file);
    @(posedge clk);

end




endmodule