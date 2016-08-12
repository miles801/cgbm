<#assign type="${field.type2!'text'}"/>
<#assign name="${field.name!''}"/>

<#if type == "text" >
<div class="item w300">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <input type="text" class="w200"  ng-model="${bname}.${field.field}" <#if field.require!false>validate validate-required</#if> maxlength="${field.length!40}"/>
</div>
<#elseif type == "text2" >
<div class="item w700">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <input type="text" class="w600"  ng-model="${bname}.${field.field}" <#if field.require!false>validate validate-required</#if> maxlength="${field.length!40}"/>
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
<div class="item w700">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <textarea class="w600" rows="4" ng-model="${bname}.${field.field}" maxlength="1000" <#if field.require!false>validate validate-required</#if>></textarea >
</div>
<#elseif type =='select'>
<div class="item w300">
    <div class="form-label w100">
        <label validate-error="form.${field.field}">${name}:</label>
    </div>
    <select  class="w200" ng-model="${bname}.${field.field}" name="${field.field}" <#if field.require!false>validate validate-required</#if>
             ng-options="foo.name as foo.value for foo in ${field.field}s">
    </select >
</div>
<#elseif type == 'date'>
<div class="item w300">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <label class="w200">
        <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{}" readonly placeholder="点击选择日期"/>
        <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除日期"></i></span>
    </label>
</div>
<#elseif type == 'time'>
<div class="item w300">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <label class="w200">
        <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'HH:mm:ss'}" readonly placeholder="点击选择时间"/>
        <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除时间"></i></span>
    </label>
</div>
<#elseif type == 'datetime'>
<div class="item w300">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <label class="w200">
        <input type="text" ng-model="${bname}.${field.field}" eccrm-my97="{dateFmt:'yyyy-MM-dd HH:mm:ss'}" readonly placeholder="点击选择时间"/>
        <span class="add-on"><i class="icons icon clock" ng-click="${bname}.${field.field}=null" title="点击清除时间"></i></span>
    </label>
</div>
<#elseif type == 'tree'>
<div class="item w300">
    <div class="form-label w100">
        <label>${name}:</label>
    </div>
    <label class="w200">
        <input type="text" ng-model="${bname}.${field.field}" ztree-single="${field.field}Tree" readonly placeholder="点击选择"/>
        <span class="add-on"><i class="icons icon clock" ng-click="clear${field.field?cap_first}();" title="点击清除时间"></i></span>
    </label>
</div>
</#if>