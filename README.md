# Subsystem Verification of Pulpino RTL
This project aims at subsystem verification of Pulpino RTL block

# Block Diagram
![subsytem_pulpino_internal drawio](https://user-images.githubusercontent.com/104111334/165580090-eb38da10-eb85-4215-92ef-d75c178e8427.png)

# Key Features
1. Standard SPI mode
2. Full Duplex SPI System
3. Single master SPI and single slave SPI
4. Single master axi4 and single slave AXI4
5. APB4 Interconnect for peripherals 
6. Clock divider
7. Asynchronous active low hard reset
8. Software reset
9. SPI transfer length
10. Appending Dummy Data 
11. Separate TXFIFO and RXFIFO
12. Interrupt Configuration

# Testbench Architectural Diagram
![subsystem_TB_architecture drawio](https://user-images.githubusercontent.com/104111334/165580115-db9677bc-633e-4a5b-b94d-7954d6a5db73.png)

# Developers, Welcome
We believe in growing together and if you'd like to contribute, please do check out the contributing guide below:  
https://github.com/mbits-mirafra/pulpino__spi_master__subsystem_verification/blob/development_branch_v1/contribution_guidelines.md

# Installation - Get the VIP collateral from the GitHub repository

```
# Checking for git software, open the terminal type the command
git version

# Get the VIP collateral
git clone git@github.com:mbits-mirafra/pulpino__spi_master__subsystem_verification.git
```

# Running the test

### Using Mentor's Questasim simulator 

```
cd pulpino__spi_master__subsystem_verification/sim/questasim

# Compilation:  
make compile

# Simulation:
make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>

ex: make simulate test=basic_write_test uvm_verbosity=UVM_HIGH

# Note: You can find all the test case names in the path given below   
pulpino__spi_master__subsystem_verification/src/hvl_top/testlists/regression.list

# Wavefrom:  
vsim -view <test_name>/waveform.wlf &

ex: vsim -view basic_write_test/waveform.wlf &

# Regression:
make regression testlist_name=<regression_testlist_name.list>
ex: make regression testlist_name=regression.list

# Coverage: 
 ## Individual test:
 firefox <test_name>/html_cov_report/index.html &
 ex: firefox basic_write_test/html_cov_report/index.html &

 ## Regression:
 firefox merged_cov_html_report/index.html &

```

### Using Cadence's Xcelium simulator 

```
cd pulpino__spi_master__subsystem_verification/sim/cadence_sim

# Compilation:  
make compile

# Simulation:
make simulate test=<test_name> uvm_verbosity=<VERBOSITY_LEVEL>

ex: make simulate test=basic_write_test uvm_verbosity=UVM_HIGH

# Note: You can find all the test case names in the path given below   
pulpino__spi_master__subsystem_verification/src/hvl_top/testlists/regression.list

# Wavefrom:  
simvision waves.shm/ &

# Regression:
make regression testlist_name=<regression_testlist_name.list>
ex: make regression testlist_name=regression.list

# Coverage:   
imc -load cov_work/scope/test/ &
```

## Technical Document 
https://github.com/mbits-mirafra/pulpino__spi_master__subsystem_verification/blob/development_branch_v1/doc/subsystem_verification_architectural_document.pdf

## User Guide  
https://github.com/mbits-mirafra/pulpino__spi_master__subsystem_verification/blob/development_branch_v1/doc/user_guide.pdf 

## Contact Mirafra Team  
You can reach out to us over mbits@mirafra.com

For more information regarding Mirafra Technologies please do checkout our officail website:  
https://mirafra.com/

