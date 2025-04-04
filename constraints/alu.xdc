# Create a Vritual Clock 



# second clock

create_clock -period 10.000 -name clk_virtual1  
set_input_delay -clock [get_clocks clk_virtual1] -min 0.500 [get_ports alu_control]
set_input_delay -clock [get_clocks clk_virtual1] -max 1.200 [get_ports alu_control]

set_input_delay -clock [get_clocks clk_virtual1] -max 1.800 [get_ports a]
set_input_delay -clock [get_clocks clk_virtual1] -min 0.500 [get_ports a]
set_input_delay -clock [get_clocks clk_virtual1] -min 0.500 [get_ports b]
set_input_delay -clock [get_clocks clk_virtual1] -max 2.100 [get_ports b]

set_output_delay -clock [get_clocks clk_virtual1] -min -add_delay 1.200 [get_ports result]
set_output_delay -clock [get_clocks clk_virtual1] -max 2.000 [get_ports result]



create_clock -period 10.000 -name clk_virtual
set_input_delay -clock [get_clocks clk_virtual] -max -add_delay 1.000 [get_ports alu_control]
#set_input_delay -clock [get_clocks clk_virtual] -max 0.500 [get_ports a]
#set_input_delay -clock [get_clocks clk_virtual] -max 0.500 [get_ports b]
set_output_delay -clock [get_clocks clk_virtual] -max -add_delay 1.800 [get_ports result]



#set_input_delay -clock [get_clocks clk_virtual] 2.000 [get_ports {{a[0]} {a[1]} {a[2]} {a[3]} {a[4]} {a[5]} {a[6]} {a[7]}}]
create_clock -period 10.000 -name virtual_clock
set_input_delay -clock [get_clocks virtual_clock] -min -add_delay 0.100 [get_ports {a}]
set_input_delay -clock [get_clocks virtual_clock] -max -add_delay 0.600 [get_ports {a}]
set_output_delay -clock [get_clocks virtual_clock] -min -add_delay 0.400 [get_ports {result}]
set_output_delay -clock [get_clocks virtual_clock] -max -add_delay 1.200 [get_ports {result}]
set_output_delay -clock [get_clocks virtual_clock] -max -add_delay 1.200 [get_ports {result}]
