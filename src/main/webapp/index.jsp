<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<style type="text/css">
body,html,#allmap {
	width: 100%;
	height: 100%;
	overflow: hidden;
	margin: 0;
}
</style>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=B2b0799067587d4b8d811256dffd6af1"></script>
<title>叠加行政区划图</title>
</head>
<body>
	<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
	// 百度地图API功能
	var map = new BMap.Map("allmap"); // 创建Map实例
	//map.centerAndZoom("宜兴", 15); // 初始化地图,设置中心点坐标(以城市名的方式)和地图级别
	var point = new BMap.Point(119.826323, 31.373006);// 初始化地图,设置中心点坐标
	map.centerAndZoom(point, 15); //初始化地图级别

	map.enableScrollWheelZoom(); //开启鼠标滚轮缩放功能。仅对 PC 上有效。
	//添加标注点
	addMarker(new BMap.Point(119.826323, 31.373006));
	
	
	//addMarker(new BMap.Point(119.822748,31.370107));

	/**
	 *	编写自定义函数,创建标注
	 **/
	function addMarker(point) {
		var marker = new BMap.Marker(point);
		map.addOverlay(marker);
	}

	/**
	 *	叠加行政区划图
	 **/
	function getBoundary() {
		var bdary = new BMap.Boundary();
		bdary.get("宜兴", function(rs) { //获取行政区域
			map.clearOverlays(); //清除地图覆盖物       
			var count = rs.boundaries.length; //行政区域的点有多少个
			for ( var i = 0; i < count; i++) {
				var ply = new BMap.Polygon(rs.boundaries[i], {
					strokeWeight : 2,
					strokeColor : "#ff0000"
				}); //建立多边形覆盖物
				map.addOverlay(ply); //添加覆盖物
				map.setViewport(ply.getPath()); //调整视野 
				map.setZoom(12); //设置缩放级别
				//map.enableScrollWheelZoom();
			}
		});
	}

	//	setTimeout(function() {
	//		getBoundary();
	//	}, 1500);
</script>

