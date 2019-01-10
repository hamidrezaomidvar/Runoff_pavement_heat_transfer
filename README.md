# Runoff_pavement_heat_transfer
The instruction for running the code (similar for both full and simple model)

1- To run the model, the user needs to run Main.m: this file contains calls to various functions as well as the main time step loop

2- The model parameters, constants, and thermal properties of air, water, and pavement can be changes in param_properties.m

3- The spin up period for the model is in ground_prof.m; The user can change the spin up period, but should be careful to have similar data period with the time resolution as the the model

4- The atmospheric data are loaded for the model in loadData_before_rain.m, loadData_during_rain.m, and loadData_after_rain.m for before, during, and after rainfall periods respectively

5- The results and variables will be saved in Results folder at the end of each run

6- The atmospheric data are in broadmead_2016 folder (the name can be change as long as it is consistent with the code)

7- The main function that solve the heat equations in the runoff, pavement and at the boundaries (surface energy budget) is in Heat.m

8- The function that takes care of transient mesh is in mesh_transient.m

9- Note that the user can change the resolution of the mesh as long as it is consistent with stability of the code

10- The instability is captured by the code, and the run is finished when the code goes unstable. 
