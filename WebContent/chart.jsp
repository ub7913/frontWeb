<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      // Load the Visualization API and the corechart package.로드 하기
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', '부서');
        data.addColumn('number', '사원수');

        var datatable = []; //[['인사', 5],[],..]
        //ajax // 차트로 쓰려면 [[]](배열안에 배열)써야 하는데 지금 [{}](배열안에 객체)의 구조라서 바꿔 줘야 함
        $.ajax({
        	async : false,
        	url :"ajax/ChartData.do" ,
        	dataType : "json",
        	success : function(datas){
        		for(i=0; i<datas.length; i++) {
        			datatable.push( [ datas[i].name, parseInt(datas[i].cnt) ] );
        		}
        		//chart.draw내용의 function을 집어 넣으면 됨(async하는 것보다 function을 넣는것을 더 권장함)ㄴ
        	}
        });
        data.addRows(datatable);//디폴트가 어싱크라서 데이터 받아오기 전에 add 된다. 데이터를 정리 한다음에 add되야 하므로 async하던 chart.draw 내용을 success안에 넣던 해야 한다.

        // Set chart options
        var options = {'title':'부서별 사원수',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));//PieChart : 필요 차트 쓰면 됨 BarChart 등등
        chart.draw(data, options);
      }
    </script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>