<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Find Route for UW Tacoma Campus</title>
</head>

<body>
<form name="findroute" action="directions" method="GET">
Source<input type="text" id="source" name="source">
Destination<input type="text" id="destination" name="destination"> <input type="button" value="Search Building" onclick="find()"/>
<input type="submit" name="Find Routes"> 
</form>
<script>

      function displayLocation(latitude,longitude){
        var request = new XMLHttpRequest();

        var method = 'GET';
        var url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+latitude+','+longitude+'&key=AIzaSyBuA-pwqjt85cy2_XHhDxcPEBYpDWU0XaU';
        var async = true;

        request.open(method, url, async);
        request.onreadystatechange = function(){
          if(request.readyState == 4 && request.status == 200){
            var data = JSON.parse(request.responseText);
            var address = data.results[0].formatted_address;
            document.getElementById("source").value=address;

          }
        };
        request.send();
      };

      var successCallback = function(position){
        var x = position.coords.latitude;
        var y = position.coords.longitude;
        displayLocation(x,y);
      };

      var errorCallback = function(error){
        var errorMessage = 'Unknown error';
        switch(error.code) {
          case 2:
            errorMessage = 'Position unavailable';
            break;
          case 3:
            errorMessage = 'Timeout';
            break;
        }
        if(error.code==1){
        	 document.getElementById("source").value="";
        	 break;
        }
        document.write(errorMessage);
      };

      var options = {
        enableHighAccuracy: true,
        timeout: 100000,
        maximumAge: 0
      };
      navigator.geolocation.getCurrentPosition(successCallback,errorCallback,options);

</script>
<script language="javascript">
    var xmlhttp;
    function init() {
        // put more code here in case you are concerned about browsers that do not provide XMLHttpRequest object directly
        xmlhttp = new XMLHttpRequest();
    }
    function find() {
        var destination = document.getElementById("destination");
        var url = "http://localhost:8084/webservicedemo/resources/employee/" + destination.value;
        xmlhttp.open('GET',url,true);
        xmlhttp.send(null);
        xmlhttp.onreadystatechange = function() {

            if (xmlhttp.readyState == 4) {
                if ( xmlhttp.status == 200) {
                    var dest = eval( "" +  xmlhttp.responseText + "");
                    if (dest > 0 ) {
                        document.getElementById("destination").value=dest;
                    }
                    else {
                        alert("Invalid Building name");
                    }
                }
                else
                    alert("Error ->" + xmlhttp.responseText);
            }
        };
    }
</script>
</body>

</html>