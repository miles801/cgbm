/**
* ${name}列表
* Created by ${author!'CODE GENERATOR'} <#if now??>on ${now}</#if>.
*/
(function (window, angular, $) {
    var app = angular.module('${module}.${module2}.${entity?uncap_first}.list', [
        'eccrm.angular',
        'eccrm.angularstrap',
        '${module}.${module2}.${entity?uncap_first}'
    ]);
    app.controller('Ctrl', function ($scope, CommonUtils, AlertFactory, ModalFactory, ${entity}Service, ${entity}Param) {
        var defaults = { }; // 默认查询条件

        $scope.condition = angular.extend({}, defaults);

        // 重置查询条件并查询
        $scope.reset = function () {
            $scope.condition = angular.extend({}, defaults);
            $scope.query();
        };

    <#list fields as attr>
        <#if attr.param?has_content>

        // 参数：${attr.name}
        $scope.${attr.field}s = [{name:'全部'}];
        ${entity}Param.${attr.field}(function(o) {
            $scope.${attr.field}s.push.apply($scope.${attr.field}s, o);
        });
        </#if>
    </#list>
    
        // 查询数据
        <#if page==false>
        $scope.query = function() {
            var promise = ${entity}Service.pageQuery($scope.condition, function(data){
                $scope.beans = data.data || {total: 0};
            });
            CommonUtils.loading(promise);
        };
        </#if>
        <#if page>
        $scope.query = function() {
            $scope.pager.query();
        };
        $scope.pager = {
            fetch: function () {
                var param = angular.extend({}, {start: this.start, limit: this.limit}, $scope.condition);
                $scope.beans = [];
                return CommonUtils.promise(function(defer){
                    var promise = ${entity}Service.pageQuery(param, function(data){
                        param = null;
                        $scope.beans = data.data || {total: 0};
                        defer.resolve($scope.beans);
                    });
                    CommonUtils.loading(promise, 'Loading...');
                });
            },
            finishInit: function () {
                this.query();
            }
        };
        </#if>
    
        // 删除或批量删除
        $scope.remove = function (id) {
            if(!id){
                var ids = [];
                angular.forEach($scope.items||[],function(o) {
                    ids.push(o.id);
                });
                id = ids.join(',');
            }
            ModalFactory.confirm({
                scope: $scope,
                content: '<span class="text-danger">数据一旦删除将不可恢复，请确认!</span>',
                callback: function () {
                    var promise = ${entity}Service.deleteByIds({ids: id}, function(){
                        AlertFactory.success('删除成功!');
                        $scope.query();
                    });
                    CommonUtils.loading((promise));
                }
            });
        };
    
        // 新增
        $scope.add = function () {
            CommonUtils.addTab({
                title: '新增${name}',
                url: '/${module}/${module2}/${entity?uncap_first}/add',
                onUpdate: $scope.query
            });
        };
    
        // 更新
        $scope.modify = function (id) {
            CommonUtils.addTab({
                title: '更新${name}',
                url: '/${module}/${module2}/${entity?uncap_first}/modify?id=' + id,
                onUpdate: $scope.query
            });
        };
    
        // 查看明细
        $scope.view = function (id) {
            CommonUtils.addTab({
                title: '查看${name}',
                url: '/${module}/${module2}/${entity?uncap_first}/detail?id=' + id
            });
        };

    <#if deleted==false>
        // 启用
        $scope.enable = function (id) {
            ModalFactory.confirm({
                scope: $scope,
                content: '<span class="text-success">是否启用，请确认!</span>',
                callback: function () {
                    var promise = ${entity}Service.enable({ids: id}, function(){
                        AlertFactory.success('操作成功!');
                        $scope.query();
                    });
                    CommonUtils.loading(promise);
                }
            });
        };

        // 禁用
        $scope.disable = function (id) {
            ModalFactory.confirm({
                scope: $scope,
                content: '<span class="text-danger">是否禁用，请确认!</span>',
                callback: function () {
                    var promise = ${entity}Service.disable({ids: id}, function(){
                        AlertFactory.success('操作成功!');
                        $scope.query();
                    });
                    CommonUtils.loading(promise);
                }
            });
        };
    </#if>

        // 导出数据
        $scope.exportData = function () {
            if ($scope.pager.total < 1) {
                AlertFactory.error('未获取到可以导出的数据!请先查询出数据!');
                return;
            }
            var o = angular.extend({}, $scope.condition);
            o.start = null;
            o.limit = null;
            window.open(CommonUtils.contextPathURL('/${module}/${module2}/${entity?uncap_first}/export?' + encodeURI(encodeURI($.param(o)))));
        };

    });
})(window, angular, jQuery);