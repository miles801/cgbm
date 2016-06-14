<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>编辑</title>
</head>
<body>
<div class="main" ng-app="eccrm.${name}.${className}.edit" ng-controller="${className}EditCtrl">
    <div class="row-10 block">
        <div class="block-header">
                <span class="header-text">
                    <span class="glyphicons info-sign"></span>
                <#if editPage.headerText??>
                    <span>${editPage.headerText}</span>
                <#else>
                    <span>${cnName}基本信息</span>
                </#if>
                </span>
                <span class="header-button">
                <#if editPage.headerButtons?? >
                    <#list editPage.headerButtons! as btn>
                        <button type="button" class="btn btn-green btn-min">
                            <span class="glyphicons ${btn.icon!}"></span> ${btn.name!}
                        </button>
                    </#list>
                <#else>
                    <button type="button" class="btn btn-green btn-min" ng-if="!page.type || page.type=='add'"
                            ng-click="save()" ng-disabled="!form.$valid">
                        <span class="glyphicons disk_save"></span> 保存
                    </button>
                    <#if editPage.saveAndNew! = true>
                        <button type="button" class="btn btn-green btn-min" ng-if="!page.type || page.type=='add'"
                                ng-click="save(true)" ng-disabled="!form.$valid">
                            <span class="glyphicons disk_open"></span> 保存并新建
                        </button>
                    </#if>
                    <button type="button" class="btn btn-green btn-min" ng-if="page.type && page.type=='modify'"
                            ng-click="update()" ng-disabled="!form.$valid && !canUpdate">
                        <span class="glyphicons claw_hammer"></span> 更新
                    </button>
                </#if>
                    <a type="button" class="btn btn-green btn-min"
                       ng-click="back();">
                        <span class="glyphicons message_forward"></span> 返回
                    </a>
                </span>
        </div>
        <div class="block-content">
            <div class="content-wrap">
                <form name="form" class="form-horizontal" role="form">
                    <div style="display: none;">
                        <input type="hidden" id="pageType" value=""/>
                        <input type="hidden" id="id" value=""/>
                    <#--<input type="hidden" id="pageType" value="${pageType}" />-->
                    <#--<input type="hidden" id="id" value="${id}" />-->
                    </div>
                <#list editPage.formRows as row>
                    <div class="row">
                        <#list row.elements as element>
                                    <#include "element.ftl">
                                </#list>
                    </div>
                </#list>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script type="text/javascript" src="app/${path}/${className}.js"></script>
<script type="text/javascript" src="app/${path}/edit/${className}_edit.js"></script>
</html>