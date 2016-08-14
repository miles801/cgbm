<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String contextPath = request.getContextPath();
%>
<html lang="en">
<head>
    <title>${name}列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/bootstrap-v3.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/style/standard/css/eccrm-common-new.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/jquery-all.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-all.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-strap-all.js"></script>
<#if date>
    <script type="text/javascript" src="<%=contextPath%>/vendor/My97DatePicker/WdatePicker.js"></script>
</#if>
<#if tree>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/zTree/css/ztree.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-ztree-all.js"></script>
</#if>
    <script>
        window.angular.contextPathURL = '<%=contextPath%>';
    </script>
</head>
<body>
<div class="main condition-row-1" ng-app="${module}.${module2}.${entity?uncap_first}.list" ng-controller="Ctrl">
    <div class="list-condition">
        <div class="block">
            <div class="block-header">
                <span class="header-button">
                        <a type="button" class="btn btn-green btn-min" ng-click="condition={};"> 重置 </a>
                        <a type="button" class="btn btn-green btn-min" ng-click="query();"> 查询 </a>
                </span>
            </div>
            <div class="block-content">
                <div class="content-wrap">
                    <div class="row float">
                    <#list fields as field>
                        <#assign bname="condition"/>
                        <#assign type="${field.type2!'text'}"/>
                        <#assign labelText="${field.name!''}"/>
                    <#if field.condition>
                        <#if type == "text" >
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <input type="text" class="w120"  ng-model="${bname}.${field.field}"  maxlength="${field.length!40}"/>
                            </div>
                        <#elseif type == "text2" >
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <input type="text" class="w120"  ng-model="${bname}.${field.field}"  maxlength="${field.length!40}"/>
                            </div>
                        <#elseif type == 'checkbox'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120">
                                    <input type="checkbox" ng-model="${bname}.${field.field}" /> <span style="margin-left:5px;">${labelText}</span>
                                </label>
                            </div>
                        <#elseif type == 'radio'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120" ng-repeat="foo in ${field.field}s" style="margin-left:$index==0?'0':'12px';">
                                    <input type="radio" ng-model="${bname}.${field.field}" /> <span style="margin-left:5px;">${labelText}</span>
                                </label>
                            </div>
                        <#elseif type == 'textarea'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <textarea class="w120" rows="4" ng-model="${bname}.${field.field}" maxlength="1000" ></textarea >
                            </div>
                        <#elseif type =='select'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label validate-error="form.${field.field}">${labelText}:</label>
                                </div>
                                <select  class="w120" ng-model="${bname}.${field.field}" name="${field.field}"
                                         ng-options="foo.name as foo.value for foo in ${field.field}s">
                                </select >
                            </div>
                        <#elseif type == 'date'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120">
                                    <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{}" readonly placeholder="点击选择日期"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除日期"></i></span>
                                </label>
                            </div>
                        <#elseif type == 'time'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120">
                                    <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'HH:mm:ss'}" readonly placeholder="点击选择时间"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除时间"></i></span>
                                </label>
                            </div>
                        <#elseif type == 'datetime'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120">
                                    <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'yyyy-MM-dd HH:mm:ss'}" readonly placeholder="点击选择时间"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除时间"></i></span>
                                </label>
                            </div>
                        <#elseif type == 'tree'>
                            <div class="item w200">
                                <div class="form-label w80">
                                    <label>${labelText}:</label>
                                </div>
                                <label class="w120">
                                    <input type="text" ng-model="${bname}.${field.field}" ztree-single="${field.field}Tree" readonly placeholder="点击选择"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="clear${field.field?cap_first}();" title="点击清除时间"></i></span>
                                </label>
                            </div>
                        </#if>
                    </#if>
                    </#list>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="list-result <#if !page>no-pagination</#if>">
        <div class="block">
            <div class="block-header">
                <div class="header-text">
                    <span>${name}列表</span>
                </div>
            <span class="header-button">
                <#if export>
                    <a type="button" class="btn btn-green btn-min" ng-click="exportData();" ng-disabled="!pager.total" ng-cloak> 导出数据 </a>
                </#if>
                    <a type="button" class="btn btn-green btn-min" ng-click="add();"> 新建 </a>
                    <a type="button" class="btn btn-green btn-min" ng-click="remove();" ng-disabled="!anyone" ng-cloak> 删除 </a>
            </span>
            </div>
            <div class="block-content">
                <div class="content-wrap">
                    <div class="table-responsive panel panel-table">
                        <table class="table table-striped table-hover">
                            <thead class="table-header">
                            <tr>
                            <td class="width-min">
                                <div select-all-checkbox checkboxes="beans.data" selected-items="items"
                                     anyone-selected="anyone"></div>
                            </td>
                            <#assign size=2/>
                            <#list fields as field>
                                <#if field.list>
                                    <#assign size=size+1/>
                                    <td>${field.name}</td>
                                </#if>
                            </#list>
                            <td>操作</td>
                            </tr>
                            </thead>
                            <tbody class="table-body">
                            <tr ng-show="!beans || !beans.total">
                            <td colspan="${size}" class="text-center">没有查询到数据！</td>
                            </tr>
                            <tr bindonce ng-repeat="foo in beans.data" ng-cloak>
                                <td><input type="checkbox" ng-model="foo.isSelected"/></td>
                                <#list fields as field>
                                    <#if field.list>
                                        <td bo-text="${field.field}"></td>
                                    </#if>
                                </#list>
                                <td class="text-left">
                                    <a class="btn-op blue" ng-click="modify(foo.id);">编辑</a>
                                    <#if deleted>
                                    <a class="btn-op red" ng-click="remove(foo.id);">删除</a>
                                    <#else >
                                    <a class="btn-op green" ng-click="enable(foo.id);">启用</a>
                                    <a class="btn-op red" ng-click="diable(foo.id);">禁用</a>
                                    </#if>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
<#if page>
    <div class="list-pagination" eccrm-page="pager"></div>
</#if>
</div>
</body>
<script type="text/javascript"
        src="<%=contextPath%>/app/${module}/<#if module2??>${module2}/</#if>${entity?uncap_first}/${entity?uncap_first}.js"></script>
<script type="text/javascript"
        src="<%=contextPath%>/app/${module}/<#if module2??>${module2}/</#if>${entity?uncap_first}/${entity?uncap_first}_list.js"></script>
</html>