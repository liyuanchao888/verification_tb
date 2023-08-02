#!/bin/bash
##Usage: ./report_log.sh <TEST_NAME>
report_file=${PROJ_WORK_PATH}/report.html
tc_log=$1
TC_FILE_NAME=$(echo ${tc_log} | awk -F "." '{print $(NF-1)}')
TEST_NAME=${TC_FILE_NAME%_*}
SEED=${TC_FILE_NAME##*_}
#echo -e " log path ${PROJ_WORK_PATH}/$TEST_NAME/${tc_log}  seed is ${SEED}"
if [ ! -e ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} ];
then  STATE=NONE
    echo "<h1> TEST NOT RUN! </h1>" >${PROJ_WORK_PATH}/${TEST_NAME}/NOT_RUN.html
	RESULT="${PROJ_WORK_PATH}/${TEST_NAME}/NOT_RUN.html"
    CPU_TIME=0
elif [ $(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -c "UVM Report Summary") -eq 0 ]; then
    STATE=RUNNING
    RESULT="${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}"
    CPU_TIME=NOT_FINISH    
elif [ $(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -c "testcase fail") -gt 0 ]; then
    STATE=FAILED
    RESULT="${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}"
    START_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "Compiler version" | awk -F ";" '{print $NF}' )
    CPU_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "CPU Time: " | awk -F ";" '{print $1}' | awk -F ":" '{print $NF}' )
    sim_line=`sed -n -e '/V C S   S i m/=' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}`
    SIM_TIME=`sed -n -e ''$((sim_line+1))'p' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | awk -F ":" '{print $NF}' `
elif [ $(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -c "testcase pass") -gt 0 ]; then
    STATE=PASSED
    RESULT="${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}"
    START_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "Compiler version" | awk -F ";" '{print $NF}' )
    CPU_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "CPU Time: " | awk -F ";" '{print $1}' | awk -F ":" '{print $NF}' )
    sim_line=`sed -n -e '/V C S   S i m/=' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}`
    SIM_TIME=`sed -n -e ''$((sim_line+1))'p' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | awk -F ":" '{print $NF}' `
else
    STATE=UNKNOW
    RESULT="${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}"
    START_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "Compiler version" | awk -F ";" '{print $NF}' )
    CPU_TIME=$(cat ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | grep -n "CPU Time: " | awk -F ";" '{print $1}' | awk -F ":" '{print $NF}' )
    sim_line=`sed -n -e '/V C S   S i m/=' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log}`
    SIM_TIME=`sed -n -e ''$((sim_line+1))'p' ${PROJ_WORK_PATH}/${TEST_NAME}/${tc_log} | awk -F ":" '{print $NF}' `
fi

#echo -e "\n\n report_log.sh  start_time :${START_TIME}  CPU_TIME : ${CPU_TIME}  SIM_TIME :${SIM_TIME}"

if [ -e $report_file ];
then
   echo "<script>   addEle(\"${TEST_NAME}\",\"${SEED}\",\"$STATE\",\"$CPU_TIME\",\"$SIM_TIME\",'<a href=\"$RESULT\">TESTCASE LOG</a>')  </script>" >> $report_file
else
   echo ''' 
<head>
    <meta charset="UTF-8">
    <title>TEST RESULT</title>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body{
            margin: 0 20px;
        }
        h3 {
            margin: 50px auto;
            text-align: center;
            font-size: 26px;
        }
        ul{
            width: 100%;
            margin: 50px auto;
            list-style: none;
            font-size: 16px;
        }
        li{
            line-height:40px;
            height: 40px;
            text-align: center;
            border: 1px solid #ccc;
            border-top: none;
        }
        li:first-child{
            display: flex;
        }
        li:first-child div{
            flex:1;
        }
        select{
            width: 80px;
            height: 24px;
            line-height: 24px;
            margin-left: 10px;
            border-radius: 4px;
            vertical-align: text-bottom;
            font-size: 16px;
            padding-left: 5px;
        }
        option{
            height: 30px;
            line-height: 30px;
        }
        .info-box{
            display: flex;
        }
        .info-box >div{
            flex:1;
            border-right: 1px solid #ccc;
        }
        li:first-child{
            background-color: #3F3F3F;
            color: #fff;
            height: 50px;
            line-height: 50px;
            font-size: 18px;
            font-weight: 700;
            border: none;
        }
        .info-box div:last-child{
            border-right: none;
        }
        li:first-child div:first-child{
            flex: inherit;
            width:50px;
        }
        .info-box div:first-child{
            flex: inherit;
            width:50px;
        }
        .red{
            color: red;
            font-weight: 700;
        }
        .show{
            display: block;
        }
        .hidden{
            display: none;
        }
        li:nth-child(2n+3){
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <h3>TEST RESULT</h3>
    <ul>
        <li>
            <div>NO.</div>
            <div>TEST</div>
            <div>SEED</div>
            <div class="state_title">
                <span>STATE</span>
                <select id="select">
                    <option value="ALL">ALL</option>
                    <option value="PASSED">PASSED</option>
                    <option value="RUNNING">RUNNING</option>
                    <option value="FAILED">FAILED</option>
                    <option value="NONE">NONE</option>
                    <option value="UNKNOW">UNKNOW</option>
                </select>
            </div>
            <div>CPU_TIME</div>
            <div>SIM_TIME</div>
            <div>LOG</div>
        </li>

    </ul>
    <script>
        var tables=document.querySelector("ul");
        function addEle(test,seed,state,cpu_time,sim_time,log) {
            var li=document.createElement("li");
            var isFailed= state=="FAILED"?"red":"black";
            li.innerHTML=`
                <div class="info-box ${state}">
                    <div>${tables.children.length++}</div>
                    <div>${test}</div>
                    <div>${seed}</div>
                    <div class="${isFailed}">${state}</div>
                    <div>${cpu_time}</div>
                    <div>${sim_time}</div>
                    <div>${log}</div>
                </div>`;
            tables.appendChild(li);
        };

        function isShow(className,ele) {
            for(var i=0;i<ele.length;i++){
                if(ele[i].classList.contains(className)){
                    ele[i].parentNode.classList.add("show");
                    ele[i].parentNode.classList.remove("hidden");
                }else{
                    ele[i].parentNode.classList.remove("show");
                    ele[i].parentNode.classList.add("hidden");
                }
            }
        }
        var infoBoxs=document.getElementsByClassName("info-box");
        document.getElementById("select").onchange=function (e) {
            switch (this.value){
                case "ALL":
                    for(var i=0;i<infoBoxs.length;i++){
                        infoBoxs[i].parentNode.classList.remove("hidden");
                        infoBoxs[i].parentNode.classList.add("show");
                    }
                    break;
                case "PASSED":
                    isShow("PASSED",infoBoxs)
                    break;
                case "RUNNING":
                    isShow("RUNNING",infoBoxs)
                    break;
                case "FAILED":
                    isShow("FAILED",infoBoxs)
                    break;
                case "UNKNOW":
                    isShow("UNKNOW",infoBoxs)
                    break;
                case "NONE":
                    isShow("NONE",infoBoxs)
                    break;
            }

        }

    </script>
</body>


''' > $report_file
echo "<script>   addEle(\"${TEST_NAME}\",\"${SEED}\",\"$STATE\",\"$CPU_TIME\",\"$SIM_TIME\",'<a href=\"$RESULT\">TESTCASE LOG</a>')  </script>" >> $report_file
fi
