# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\andrew_clinkenbeard1\Box\SOC\Vitis_Workspace_hw5\hw_5\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\andrew_clinkenbeard1\Box\SOC\Vitis_Workspace_hw5\hw_5\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {hw_5}\
-hw {C:\Users\andrew_clinkenbeard1\Box\SOC\Basic_FPro2\temp_xsa.xsa}\
-proc {microblaze_I} -os {standalone} -out {C:/Users/andrew_clinkenbeard1/Box/SOC/Vitis_Workspace_hw5}

platform write
platform generate -domains 
platform active {hw_5}
platform generate
