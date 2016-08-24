<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>${name}编辑</title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/bootstrap-v3.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/style/standard/css/eccrm-common-new.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/jquery-all.js" ></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-all.js" ></script>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-strap-all.js" ></script>
<#if attachment>
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-upload.js"></script>
</#if>
<#if date>
    <script type="text/javascript" src="<%=contextPath%>/vendor/My97DatePicker/WdatePicker.js" ></script>
</#if>
<#if tree>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/zTree/css/ztree.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-ztree-all.js"></script>
<#else >
    <#list fields as attr>
        <#if attr.type2=='tree'>
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/vendor/zTree/css/ztree.css">
    <script type="text/javascript" src="<%=contextPath%>/static/ycrl/javascript/angular-ztree-all.js"></script>
        <#break >
        </#if>
    </#list>
</#if>
    <script>
        window.angular.contextPathURL = '<%=contextPath%>';
    </script>
</head>
<body>
<div class="main" ng-app="${module}.${module2}.${entity?uncap_first}.edit" ng-controller="Ctrl" style="overflow: auto;">
    <div class="block">
        <div class="block-header">
                <span class="header-button">
                    <c:if test="${r"${pageType eq 'add'}"}">
                    <a class="btn btn-green btn-min" ng-click="save()" ng-disabled="!form.$valid">保存 </a>
                    <a class="btn btn-green btn-min" ng-click="save(true)" ng-disabled="!form.$valid">保存并新建 </a>
                    </c:if>
                    <c:if test="${r"${pageType eq 'modify'}"}">
                    <a type="button" class="btn btn-green btn-min" ng-click="update()" ng-disabled="!form.$valid"> 更新 </a>
                    </c:if>
                    <a class="btn btn-green btn-min" ng-click="back();">返回 </a>
                </span>
        </div>
        <div class="block-content">
            <div class="content-wrap">
                <form name="form" class="form-horizontal" role="form">
                    <div style="display: none;">
                        <input type="hidden" id="pageType" value="${r"${pageType}"}"/>
                        <input type="hidden" id="id" value="${r"${id}"}"/>
                    </div>
                    <div class="row float">
                <#list fields as field>
                    <#assign bname="beans"/>
                    <#assign type="${field.type2!'text'}"/>
                    <#assign name="${field.name!''}"/>
                    <#if field.edit>
                        <#if type == "text" >
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <input type="text" class="w200"  ng-model="${bname}.${field.field}" <#if field.require!false>validate validate-required</#if> maxlength="${field.length!40}"/>
                            </div>
                        <#elseif type == "text2" >
                            <div class="item w900 break">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <input type="text" class="w800"  ng-model="${bname}.${field.field}" <#if field.require!false>validate validate-required</#if> maxlength="${field.length!40}"/>
                            </div>
                        <#elseif type == 'checkbox'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <label class="w200">
                                    <input type="checkbox" ng-model="${bname}.${field.field}" /> <span style="margin-left:5px;">${name}</span>
                                </label>
                            </div>
                        <#elseif type == 'radio'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <label class="w200" ng-repeat="foo in ${field.field}s" style="margin-left:$index==0?'0':'12px';">
                                    <input type="radio" ng-model="${bname}.${field.field}" /> <span style="margin-left:5px;">${name}</span>
                                </label>
                            </div>
                        <#elseif type == 'textarea'>
                            <div class="item w900 break">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <textarea class="w800" rows="4" ng-model="${bname}.${field.field}" maxlength="1000" <#if field.require!false>validate validate-required</#if>></textarea >
                            </div>
                        <#elseif type =='select'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label validate-error="form.${field.field}">${name}:</label>
                                </div>
                                <select  class="w200" ng-model="${bname}.${field.field}" name="${field.field}" <#if field.require!false>validate validate-required</#if>
                                         ng-options="foo.value as foo.name for foo in ${field.field}s">
                                </select >
                            </div>
                        <#elseif type == 'date'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <div class="w200 pr">
                                    <input type="text" class="w200" ng-model="${bname}.${field.field}" eccrm-my97="{}" readonly placeholder="点击选择日期"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除日期"></i></span>
                                </div>
                            </div>
                        <#elseif type == 'time'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <div class="w200 pr">
                                    <input type="text" class="w200" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'HH:mm:ss'}" readonly placeholder="点击选择时间"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除时间"></i></span>
                                </div>
                            </div>
                        <#elseif type == 'datetime'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <div class="w200 pr">
                                    <input type="text" class="w200" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'yyyy-MM-dd HH:mm:ss'}" readonly placeholder="点击选择时间"/>
                                    <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除"></i></span>
                                </div>
                            </div>
                        <#elseif type == 'tree'>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>${name}:</label>
                                </div>
                                <div class="w200 pr">
                                    <input type="text" class="w200" ng-model="${bname}.${field.field}" ztree-single="${field.field}Tree" readonly placeholder="点击选择"/>
                                    <span class="add-on"><i class="icons icon fork" ng-click="clear${field.field?cap_first}();" title="点击清除"></i></span>
                                </div>
                            </div>
                        </#if>
                    </#if>
                </#list>
                    </div>
                    <#if attachment>
                    <div class="row float break">
                        <div class="item w1000">
                            <div class="form-label w100">
                                <label>附件:</label>
                            </div>
                            <div class="w900">
                                <div  eccrm-upload="uploadOptions"></div>
                            </div>
                        </div>
                    </div>
                    </#if>
                    <c:if test="${r"${pageType ne 'add'}"}">
                        <div class="row float break" ng-cloak>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>创建人:</label>
                                </div>
                                <span class="w200 sl">{{beans.creatorName}}</span>
                            </div>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>创建时间:</label>
                                </div>
                                <div class="w200 sl">{{beans.createdDatetime|eccrmDatetime}}</div>
                            </div>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>最后更新人:</label>
                                </div>
                                <span class="w200 sl">{{beans.modifierName}}</span>
                            </div>
                            <div class="item w300">
                                <div class="form-label w100">
                                    <label>最后时间:</label>
                                </div>
                                <div class="w200 sl">{{beans.modifiedDatetime|eccrmDatetime}}</div>
                            </div>
                        </div>
                    </c:if>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="<%=contextPath%>/app/${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}.js" ></script>
<script type="text/javascript" src="<%=contextPath%>/app/${module}/${module2}/${entity?uncap_first}/${entity?uncap_first}_edit.js" ></script>
</html>