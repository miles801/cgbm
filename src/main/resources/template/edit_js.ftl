/**
* ${name}编辑
* Created by ${author!'CODE GENERATOR'} <#if now??>on ${now}</#if>.
*/
(function (window, angular, $) {
    var app = angular.module('${module}.${module2}.${entity?uncap_first}.edit', [
        'eccrm.angular',
        'eccrm.angularstrap',
<#if tree>
        'eccrm.angular.ztree',
<#else >
    <#list fields as attr>
        <#if attr.type2=='tree'>
        'eccrm.angular.ztree',
            <#break >
        </#if>
    </#list>
</#if>
        '${module}.${module2}.${entity?uncap_first}'
    ]);

    app.controller('Ctrl', function ($scope, CommonUtils, AlertFactory, ModalFactory, ${entity}Service, ${entity}Param) {

        var pageType = $('#pageType').val();
        var id = $('#id').val();

        $scope.back = CommonUtils.back;

<#-- 参数 -->
    <#list fields as attr>
        <#if attr.param??>

        // 参数：${attr.name}
        $scope.${attr.field}s = [{name:'请选择...'}];
        ${entity}Param.${attr.field}(function(o) {
            $scope.${attr.field}s.push.apply($scope.${attr.field}s, o);
        });
        </#if>
    </#list>

<#-- 树形 -->
<#list fields as field>
    <#if field.type2=='tree'>

    // 树：${field.name}
    $scope.${field.field}Tree = ${entity}Param.${field.field}Tree(function (o) {
        $scope.beans.${field.field} = o.id;
        $scope.beans.${field.field?substring(0,field.field?length-2)}Name = o.name;
    });
    // 清除数据
    $scope.clear${field.field?cap_first} = function () {
        $scope.beans.${field.field} = null;
        $scope.beans.${field.field?substring(0,field.field?length-2)}Name = null;
    };
    </#if>
</#list>

        <#if attachment>
        <#-- 附件 -->
        // 附件上传
        $scope.uploadOptions = {
            showLabel:false,
            bid : id ,
            btype : '${module}.${module2}.${entity}'
        };
        </#if>
        // 保存
        $scope.save = function (createNew) {
<#if attachment>
            $scope.beans.attachmentIds = $scope.uploadOptions.getAttachmentIds().join(',');
</#if>
            var promise = ${entity}Service.save($scope.beans, function (data) {
                AlertFactory.success('保存成功!');
                CommonUtils.addTab('update');
                if (createNew === true) {
                    $scope.beans = {};
                } else {
                    $scope.form.$setValidity('committed', false);
                    CommonUtils.delay($scope.back, 2000);
                }
            });
            CommonUtils.loading(promise);
        };


        // 更新
        $scope.update = function () {
<#if attachment>
            $scope.beans.attachmentIds = $scope.uploadOptions.getAttachmentIds().join(',');
</#if>
            var promise = ${entity}Service.update($scope.beans, function (data) {
                AlertFactory.success('更新成功!');
                $scope.form.$setValidity('committed', false);
                CommonUtils.addTab('update');
                CommonUtils.delay($scope.back, 2000);
            });
            CommonUtils.loading(promise, '更新中...');
        };

        // 加载数据
        $scope.load = function (id) {
            var promise = ${entity}Service.get({id: id}, function (data) {
                $scope.beans = data.data || {};
            });
            CommonUtils.loading(promise, 'Loading...');
        };


        if (pageType == 'add') {
            $scope.beans = {};
        } else if (pageType == 'modify') {
            $scope.load(id);
        } else if (pageType == 'detail') {
            $scope.load(id);
            $('input,textarea,select').attr('disabled', 'disabled');
        } else {
            AlertFactory.error($scope, '错误的页面类型');
        }
    });
})(window, angular, jQuery);