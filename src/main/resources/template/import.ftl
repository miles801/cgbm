<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String contextPath = request.getContextPath();
%>
<html>
<head>
    <base href="<%=request.getContextPath()%>/">
    <title>${name}导入</title>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/bootstrap-v3.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/style/standard/css/eccrm-common-new.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/jquery-all.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-all.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-strap-all.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-upload.js"></script>

    <script>
        window.angular.contextPathURL = '<%=contextPath%>';
    </script>
</head>
<body>
<div class="main" ng-app="${module}.${module2}.${entity?uncap_first}.import" ng-controller="Ctrl" style="width: 1000px;margin: 0 auto;">
    <form name="form" class="form-horizontal" role="form" style="margin-top: 50px;">
        <div class="row" eccrm-upload="fileUpload"></div>
        <div class="row" style="padding: 8px 0.16% 15px 12.333333%">
            <div class="box-info">
                <p style="font-size: 14px;font-weight: 700;">注意：</p>

                <p>1. 如果有一条数据不正确，都将会全部失败！</p>
            </div>
        </div>
        <div class="button-row">
            <a class="btn" ng-href="<%=contextPath%>/${module}/${module2}/${entity?uncap_first}/template" target="_blank"
               style="width: 160px;height: 50px;line-height: 50px;">下载数据模板</a>
            <button class="btn" ng-click="importData();" ng-disabled="!canImport"
                    style="margin-left:80px;width: 150px;">执行导入
            </button>
        </div>
    </form>
</div>
</body>
<script type="text/javascript" src="<%=contextPath%>/app//${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}.js"></script>
<script type="text/javascript" src="<%=contextPath%>/app//${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_import.js"></script>
</html>
