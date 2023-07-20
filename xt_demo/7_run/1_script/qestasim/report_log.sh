#!/bin/bash
##Usage: ./test_log.sh <TEST_NAME>
report_file=../2_work/report.html
TEST_NAME=$1

if [ ! -e ../$TEST_NAME/testcase.log ];
then  STATE=NONE
      RESULT="./NOT_RUN.html"
      TIME=0
elif [ $(cat ../$TEST_NAME/testcase.log | grep -c "UVM Report Summary") -eq 0 ]; then
    STATE=RUNNING
    RESULT="../$TEST_NAME/testcase.log"
    TIME=NOT_FINISH    
elif [ $(cat ../$TEST_NAME/testcase.log | grep -c "testcase fail") -gt 0 ]; then
    STATE=FAILED
    RESULT="../$TEST_NAME/testcase.log"
    TIME=$(cat ../$TEST_NAME/testcase.log | tail -n -10 |head -n -9 )
elif [ $(cat ../$TEST_NAME/testcase.log | grep -c "testcase pass") -gt 0 ]; then
    STATE=PASSED
    RESULT="../$TEST_NAME/testcase.log"
    TIME=$(cat ../$TEST_NAME/testcase.log | tail -n -10 |head -n -9 )
fi


if [ -e $report_file ];
then
   echo "<script>   addEle(\"$TEST_NAME\",\"$STATE\",\"$TIME\",'<a href=\"$RESULT\">TESTCASE LOG</a>')  </script>" >> $report_file
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
            <div class="state_title">
                <span>STATE</span>
                <select id="select">
                    <option value="ALL">ALL</option>
                    <option value="PASSED">PASSED</option>
                    <option value="RUNNING">RUNNING</option>
                    <option value="FAILED">FAILED</option>
                    <option value="NONE">NONE</option>
                </select>
            </div>
            <div>TIME</div>
            <div>LOG</div>
        </li>

    </ul>
    <script>
        var tables=document.querySelector("ul");
        function addEle(test,state,time,log) {
            var li=document.createElement("li");
            var isFailed= state=="FAILED"?"red":"black";
            li.innerHTML=`
                <div class="info-box ${state}">
                    <div>${tables.children.length++}</div>
                    <div>${test}</div>
                    <div class="${isFailed}">${state}</div>
                    <div>${time}</div>
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
                case "NONE":
                    isShow("NONE",infoBoxs)
                    break;
            }

        }

    </script>
</body>


''' > $report_file
echo "<script>   addEle(\"$TEST_NAME\",\"$STATE\",\"$TIME\",'<a href=\"$RESULT\">TESTCASE LOG</a>')  </script>" >> $report_file
fi
