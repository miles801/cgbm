(function (window, angular, $) {

    var app = angular.module('${moduleName}.${className?uncap_first}.list', [
        '${moduleName}.${className?uncap_first}',
        'eccrm.angular',
        'eccrom.angularstrap'
    ]);

    app.controller('${className}ListCtrl', function ($scope, CommonUtils, ${className}Service) {

        // 定义变量&方法
        $scope.condition={};            // 存放查询条件
        $scope.beans={total:0,data:[]}; // 存放结果数据

<#if listPage.allowPager==true>
        $scope.pager = {                // 配置分页
            fetch: function () {
                var param = angular.extend({}, {start: this.start, limit: this.limit}, $scope.condition);
                return CommonUtils.promise(function(defer){
                    var promise = ${className}Service.pageQuery(param);
                    CommonUtils.loading(promise,'数据加载中...',function(data){
                        data = data.data || { total: 0, data: []};
                        defer.resolve(data);
                        $scope.beans = data;
                    });
                });
            }
        }
</#if>
        // 查询数据
        $scope.query = function() {     // 查询
            $scope.pager.query();
        }


// ======================================= 真正初始化页面的地方============================



    });
})(window, angular, jQuery);