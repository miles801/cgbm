<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
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
                        <a type="button" class="btn btn-green btn-min" ng-click="reset();"> 重置 </a>
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
                            <#if field.id>
                            <#elseif type == "text" >
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <input type="text" class="w120" ng-model="${bname}.${field.field}"
                                           maxlength="${field.length!40}"/>
                                </div>
                            <#elseif type == 'checkbox'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <label class="w120">
                                        <input type="checkbox" ng-model="${bname}.${field.field}"/> <span
                                            style="margin-left:5px;">${name}</span>
                                    </label>
                                </div>
                            <#elseif type == 'radio'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <label class="w120" ng-repeat="foo in ${field.field}s"
                                           style="margin-left:$index==0?'0':'12px';">
                                        <input type="radio" ng-model="${bname}.${field.field}"/> <span
                                            style="margin-left:5px;">${name}</span>
                                    </label>
                                </div>
                            <#elseif type =='select'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <select class="w120" ng-model="${bname}.${field.field}"
                                            ng-options="foo.value as foo.name for foo in ${field.field}s"
                                            ng-change="query();"> </select>
                                </div>
                            <#elseif type == 'date'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <div class="w120 pr">
                                        <input type="text" class="w120" ng-model="${bname}.${field.field}"
                                               eccrm-my97="{}" readonly placeholder="点击选择日期"/>
                                        <span class="add-on"><i class="icons icon clock"
                                                                ng-click="${bname}.${field.field}=null"
                                                                title="点击清除日期"></i></span>
                                    </div>
                                </div>
                            <#elseif type == 'time'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <div class="w120 pr">
                                        <input type="text" class="w120" ng-model="${bname}.${field.field}"
                                               eccrm-my97="{dateFmt:'HH:mm:ss'}" readonly placeholder="点击选择时间"/>
                                        <span class="add-on"><i class="icons icon clock"
                                                                ng-click="${bname}.${field.field}=null"
                                                                title="点击清除时间"></i></span>
                                    </div>
                                </div>
                            <#elseif type == 'datetime'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <div class="w120 pr">
                                        <input type="text" class="w120" ng-model="${bname}.${field.field}"
                                               eccrm-my97="{dateFmt:'yyyy-MM-dd HH:mm:ss'}" readonly
                                               placeholder="点击选择时间"/>
                                        <span class="add-on"><i class="icons icon clock"
                                                                ng-click="${bname}.${field.field}=null"
                                                                title="点击清除"></i></span>
                                    </div>
                                </div>
                            <#elseif type == 'tree'>
                                <div class="item w200">
                                    <div class="form-label w80">
                                        <label>${labelText}:</label>
                                    </div>
                                    <div class="w120 pr">
                                        <input type="text" class="w120" ng-model="${bname}.${field.field}"
                                               ztree-single="${field.field}Tree" readonly placeholder="点击选择"/>
                                        <span class="add-on"><i class="icons icon fork"
                                                                ng-click="clear${field.field?cap_first}();"
                                                                title="点击清除"></i></span>
                                    </div>
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
                        <a type="button" class="btn btn-green btn-min" ng-click="exportData();"
                           ng-disabled="!pager.total" ng-cloak> 导出数据 </a>
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
                                <td style="width: 20px;">序号</td>
                            <#assign size=2/>
                            <#list fields as field>
                                <#if field.list && !field.id>
                                    <#assign size=size+1/>
                                    <td>${field.name}</td>
                                </#if>
                            </#list>
                            <#if deleted>
                            <#else >
                                <td>状态</td>
                            </#if>
                                <td>操作</td>
                            </tr>
                            </thead>
                            <tbody class="table-body">
                            <tr ng-show="!beans || !beans.total">
                                <#if deleted>
                                <td colspan="${size+1}" class="text-center">没有查询到数据！</td>
                                <#else >
                                <td colspan="${size+2}" class="text-center">没有查询到数据！</td>
                                </#if>
                            </tr>
                            <tr bindonce ng-repeat="foo in beans.data" ng-cloak>
                                <td><input type="checkbox" ng-model="foo.isSelected"/></td>
                                <td bo-text="pager.start+$index+1"></td>
                            <#list fields as field>
                                <#if field.id>
                                <#elseif field.list && field_index==0>
                                <td>
                                    <a ng-click="view(foo.id)" bo-text="foo.${field.field}" class="cp" title="点击查看详情"></a>
                                </td>
                                <#elseif field.list && field_index gt 0>
                                        <#if field.param?has_content>
                                <td bo-text="foo.${field.field}Name"></td>
                                        <#elseif field.date??>
                                <td bo-text="foo.${field.field}|eccrmDatetime"></td>
                                        <#else>
                                <td bo-text="foo.${field.field}"></td>
                                        </#if>
                                </#if>
                            </#list>
                            <#if deleted>
                            <#else >
                                <td>
                                    <a ng-class="{'green':!foo.deleted,'red':foo.deleted}" bo-text="foo.deleted?'禁用':'启用'"
                                       class="bgc"></a>
                                </td>
                            </#if>
                                <td class="text-left">
                                    <a class="btn-op blue" ng-click="modify(foo.id);">编辑</a>
                                <#if deleted>
                                    <a class="btn-op red" ng-click="remove(foo.id);">删除</a>
                                <#else >
                                    <a class="btn-op green" ng-click="enable(foo.id);" ng-if="foo.deleted">启用</a>
                                    <a class="btn-op red" ng-click="disable(foo.id);" ng-if="!foo.deleted">禁用</a>
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
<script type="text/javascript" src="<%=contextPath%>/app/${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}.js"></script>
<script type="text/javascript" src="<%=contextPath%>/app/${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_list.js"></script>
</html>