<html ng-app="${appName?uncap_first}App">
	<head>
	    <meta charset="UTF-8">
    	<title>Index</title>
    	<script src='lib/jquery-3.3.1.js'></script>
		<script src='lib/angular143.js'></script>
    	<script src='lib/angular-route143.js'></script>
    	<script src='lib/bootstrap.js'></script>
    	<script src='lib/moment.js'></script>
    	<script src='lib/toastr.js'></script>
    	<script src='lib/bootstrap-datetimepicker.js'></script>
    	
    	
    	<script src="js/app.js"></script>
    	<script src="js/controllers.js"></script>
    	<script src="js/services.js"></script>
    	<script src="js/directives.js"></script>
    	<script src="js/routes.js"></script>
    	
    	<link rel="stylesheet" href="css/bootstrap.css">
    	<link rel="stylesheet" href="css/toastr.css">
    	<link rel="stylesheet" href="css/inputStyle.css">
    	<link rel="stylesheet" href="css/bootstrap-datetimepicker.css">
    	
    	<!--Controllers-->
    <#list classes as class>
    	<script src="js/controllers/${class.name}Controller.js"></script>
    </#list>
        <script src="js/controllers/buttonController.js"></script>

		<!--Factories-->
	<#list classes as class>
    	<script src="js/services/${class.name}Service.js"></script>
    </#list>

		<script src="js/directives/buttonDirective.js"></script>
	</head>
	<body>
		<div class="ext-content">
           <div ng-view>

            </div>
        </div>
	</body>
</html>