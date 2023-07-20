# There is a description of the following documents

(first modifying the testbench to fix the dut,and run the script)

## 1. configuration(cfg_sim.ini)

   modify proj_path to your project path in **cfg_sim.ini**

## 2. run the script to compile & simulation(./run.sh)

   - run the script(will prompt that all command)
       ```
       a) open the teminal 
       b) cd to example_uvm_ut/7_testcase/1_script
       c) ./run.sh
       ```       

        - for example:
        
          [yuanchao.li@cr6 1_script]$ ./run.sh 
                                                                                            
                ================ run single testcase ==================                        
                                                                                               
                Usage:                                                                         
                          ./run.sh <file_path> [C/S/CS] [G]                                
                                                                                               
                [opt]:                                                                         
                file_path        -- Testcase path                                              
                CS or [empty]    -- Comp & Sim                   Default Both                  
                C                -- only Compile file.           Default No                    
                S                -- only Simulation file.        Default No                    
                G                -- Simulation with GUI.         Default No GUI                
                                                                                               
                example:                                                                       
                      ./run.sh C                          -- only compile file no GUI          
                      ./run.sh ../sv001_xxx_tc001_yyy C G -- only compile file throught GUI    
                      ./run.sh ../sv001_xxx_tc001_yyy S   -- only run simulation no GUI        
                      ./run.sh ../sv001_xxx_tc001_yyy     -- compile and run simulation no GUI

   ###    i) compile
    When executing a single test example you should first compile (do 1_compile.tcl) ,enter:
  ```   
  ./run.sh C
  ```
  
   ###    ii) simulation
   
    Then executing the case you want (do 2_sim.tcl),enter:
  ```
  ./run.sh ../sv001_xxx_tc001_yyy S
  ```
   ###    iii) compile & simulation
   ```
   ./run.sh ../sv001_xxx_tc001_yyy 
   ```

## 3. regression & report (Makefile)

- run the script(will prompt that all command)
               
       a) open the teminal 
       b) cd to example_uvm_ut/7_testcase/1_script
       c) make 

     - for example :
         
       [yuanchao.li@cr6 1_script]$ make
            
                ```
                usage:
                    make [opt]                                                                            
                
                [opt]:
                    help       -- default,display some info about how to use the srcipt                     
                    all        -- comp ,sim                                                                 
                    comp       -- compile                                                                   
                    sim        -- testcase simulation                                                       
                    regr       -- run regression                                                            
                    report     -- report all testcase html report                                           
                    clean      -- clear all comp & sim file(../2_work/*)                                    
                    cv_merge   -- merge file of coverage info                                               
                    cv_view    -- review the ucdb file of coverage info on questasim                        
                    cv_report  -- review coverage report                                                    
                    cv_clean   -- clear coverage file(ucdb)                                                 
                
                example:
                    if want to compile & simulation,please enter 'make all tc=../tc_path' in terminal     
                    if want to compile the file,please enter 'make comp' in terminal                      
                    if want to run testcase simulation,please enter 'make sim tc=../tc_path' in terminal   
                ```

   ###    i) regression simulation
     
   **This is script which will compile , collect all testcase (search all ../7_testcase/xx_tc/test_case.cfg file)  and regression all testcase,enter:**
     
     make regr
     

   ###    ii) regression report
    
   **This is script which will report the regression simulation on html file,enter:**
         
     make report
