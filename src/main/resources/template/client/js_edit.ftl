(function (window, angular, $) {
    var app = angular.module('${moduleName}.${className?uncap_first}.edit', [
        '${moduleName}.${className?uncap_first}',
        'eccrm.angular',
        'eccrm.angularstrap'<#if ztree?? && ztree==true>,
        'eccrm.angular.ztree'
</#if>
    ]);

    app.controller('${className}EditCtrl', function ($scope, CommonUtils, ${className}Service) {

        // 定义变量&方法
        var pageType;               // 页面类型
        var id;                 // 当前数据的ID
        $scope.beans;           // 当前业务对象

        // 保存后的结果处理
        var successResult = function(){

        }
        // 保存
        $scope.save = function () {
            var promise = ${className}Service.save($scope.beans);
            CommonUtils.loading(promise, '更新中...', saveResult, $scope);
        }

        // 更新后的结果处理
        var updateResult = function(){
        }

        // 更新
        $scope.update = function () {
            var promise = ${className}Service.update($scope.beans);
            CommonUtils.loading(promise,'更新中...',updateResult,$scope);
        }

        // 根据ID加载数据
        var load = function(id, callback){
            var promise = ${className}Service.get({id: id});
            CommonUtils.loading(promise,'加载中...',callback);
        }


// ======================================= 真正初始化页面的地方============================

        // 初始化变量
        $scope.beans = {};
        pageType = $('#pageType').val();
        id = $('#id').val();

        // 根据页面类型初始化页面
        if(pageType=='add') {               // 新建页面

        } else if(pageType == 'modify') {   // 编辑页面
            load(id, function(data){
                $scope.beans = data.data || {};
            });
        } else {                        // 查看页面
            load(id, function(data){
                $scope.beans = data.data || {};
                $('input,textarea,select').attr('disabled', 'disabled');
            });
        }
    });
})(window, angular, jQuery);