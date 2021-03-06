
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module led_w2(

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

//	//////////// SEG7 //////////
//	HEX0,
//	HEX1,
//	HEX2,
//	HEX3,
//	HEX4,
//	HEX5,
//	HEX6,
//	HEX7,
//
//	//////////// GPIO, GPIO connect to GPIO Default //////////
//	GPIO 
);

//=======================================================
//  PARAMETER declarations
//=======================================================

// nope, I'm gonna place it below
	
//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input 		          		CLOCK2_50;
input 		          		CLOCK3_50;

//////////// LED //////////
//output		     [8:0]		LEDG;
output reg   	     [8:0]		LEDG = 8'b0_0011_1000;
output reg		    [17:0]		LEDR;

//////////// KEY //////////
input 		     [3:0]		KEY;

//////////// SW //////////
input 		    [17:0]		SW;

//////////// SEG7 //////////
//output		     [6:0]		HEX0;
//output		     [6:0]		HEX1;
//output		     [6:0]		HEX2;
//output		     [6:0]		HEX3;
//output		     [6:0]		HEX4;
//output		     [6:0]		HEX5;
//output		     [6:0]		HEX6;
//output		     [6:0]		HEX7;
//
////////////// GPIO, GPIO connect to GPIO Default //////////
//inout 		    [35:0]		GPIO;


//=======================================================
//  REG/WIRE declarations
//=======================================================
reg				[2:0]   		key0diy;
reg				[2:0]   		key1diy;
reg				[2:0]   		key2diy;
reg 				[2:0]			turn;
reg				[32:0]		counter_inc;

//=======================================================
//  Structural coding
//=======================================================


parameter shift_time = 32'd24_999_999;     	// determintion of the shift time
always @(posedge CLOCK_50)
begin
		counter_inc <= counter_inc + 1'b1;		// tell <space>'<amount of bit>

		key0diy <= {key0diy[1:0] ,KEY[3]};			// setting the shape of led	
		if (!key0diy[2]&&key0diy[1])
			LEDG[7:0] <= SW[7:0];
			
		if (LEDG[7])
			LEDR[0] <= 1'b1;
		else if (LEDG[0])
			LEDR[0] <= 1'b0;
			
		if (counter_inc == shift_time)begin
			LEDG <= LEDR[0] ? LEDG >> 1 : LEDG << 1;	// LEDR[0] decides left/right shifting
			counter_inc <= 0;
		end
			
end
endmodule
