<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" >
<head >
    <title ></title >

</head >
<body >
<div class="main <#if listPage.conditionRows??>condition-row-<#if listPage.conditionRows &gt; 3 >3<#else>${listPage.conditionRows}</#if></#if>" ng-app="eccrm.${name}.${className}.list"
     ng-controller="${className}ListController"
     <#if listPage.wholePageScroll == true >style="overflow: auto;"</#if>>
    <div eccrm-alert="alert" ></div >
    <#if listPage.queryConditionRows??>
    <div class="list-condition" >
        <div class="block" >
            <div class="block-header" >
                <span class="header-text" >
                    <span class="glyphicons search" ></span >
                    <#if listPage.headerText??>
                        <span >${listPage.headerText}</span >
                    <#else>
                        <span >${cnName}查询</span >
                    </#if>
                </span >
                <#if listPage.headerButtons?? || listPage.queryBarButtons??>
                <span class="header-button" >
                    <#if listPage.headerButtons??>
                        <#list listPage.headerButtons! as btn>
                            <button type="button" class="btn btn-green btn-min" >
                                <span class="glyphicons ${btn.icon!}" ></span > ${btn.name!}
                            </button >
                        </#list>
                    </#if>
                        <#if listPage.queryBarButtons??>
                            <#list listPage.queryBarButtons as button>
                                <#if button.url?? >
                                    <a type="button" class="btn btn-green btn-min" ng-href="${button.url!'#'}" >
                                        <#if button.icon??>
                                            <span class="glyphicons ${button.icon}" ></span >
                                        </#if>
                                    ${button.name}
                                    </a >
                                <#else>
                                    <button type="button" class="btn btn-green btn-min" ng-click="${button.click!''}" >
                                        <#if button.icon??>
                                            <span class="glyphicons ${button.icon}" ></span >
                                        </#if>
                                    ${button.name}
                                    </button >
                                </#if>
                            </#list>
                        </#if>
                </span>
                </#if>
            </div >
            <div class="block-content" >
                <div class="content-wrap">
                <#list (listPage.queryConditionRows)! as row>
                    <div class="row" >
                        <#list (row.elements)! as element>
                            <#include "element.ftl">
                        </#list>
                    </div >
                </#list>
                </div>
            </div >
        </div >
    </div >
    </#if>
    <div class="list-result <#if listPage.allowPager==false>no-pagination</#if>" >
        <div class="block" >
            <div class="block-header" >
            <#if listPage.tableHeaderText??>
                <div class="header-text" >
                    <span class="glyphicons list" ></span >
                    <span >${listPage.tableHeaderText}</span >
                </div >
            <#elseif listPage.defaultName! = true>
                <div class="header-text" >
                    <span class="glyphicons list" ></span >
                    <span >${cnName!''}</span >
                </div >
            </#if>
            <#if listPage.tableHeaderButtons?? && (listPage.tableHeaderButtons?size > 0)>
                <span class="header-button" >
                <#list (listPage.tableHeaderButtons)! as button>
                    <#if button.url??>
                        <a type="button" class="btn btn-green btn-min" ng-href="${button.url!'#'}" >
                            <#if button.icon??>
                                <span class="glyphicons ${button.icon}" ></span >
                            </#if>
                        ${button.name}
                        </a >
                    <#else>
                        <button type="button" class="btn btn-green btn-min" ng-click="${button.click!''}" >
                            <#if button.icon??>
                                <span class="glyphicons ${button.icon}" ></span >
                            </#if>
                        ${button.name}
                        </button >
                    </#if>
                </#list>
                </span >
            </#if>
            </div >
            <div class="block-content" >
                <div class="content-wrap">
                    <div class="table-responsive panel panel-table" >
                        <table class="table table-striped table-hover" >
                            <thead class="table-header" >
                                <tr >
                                <#if listPage.allowCheckbox! = true>
                                    <td >
                                        <input type="checkbox" style="height: 12px;" ng-model="checkAll" />
                                    </td >
                                </#if>
                                <#list (listPage.items)! as item>
                                    <td >${item!''}</td >
                                </#list>
                                </tr >
                            </thead >
                            <tbody class="table-body" >
                                <tr ng-show="!${className}s || !${className}s.total || ${className}s.data.length==0" >
                                <#if listPage.allowCheckbox! = true>
                                    <td colspan="${listPage.items?size+1}" class="text-center" >没有查询到数据！</td >
                                <#else>
                                    <td colspan="${listPage.items?size}" class="text-center" >没有查询到数据！</td >
                                </#if>
                                </tr >
                            </tbody >
                        </table >
                    </div >
                </div>
                </div >
            </div>
    </div >
    <#if listPage.allowPager==true>
    <div class="list-pagination" eccrm-page="pager" ></div >
    </#if>
</div >
</div >

</body >
</html >