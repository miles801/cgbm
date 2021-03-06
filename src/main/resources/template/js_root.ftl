/**
* ${name}
* Created by ${author!'CODE GENERATOR'} <#if current??>on ${current}</#if>.
*/
(function (angular) {
    var app = angular.module('${module}.${module2}.${entity?uncap_first}', [
        'ngResource',
        'base.param',
        'eccrm.angular',
        'eccrm.angularstrap'
    ]);

    app.service('${entity}Service', function (CommonUtils, $resource) {
        return $resource(CommonUtils.contextPathURL('/${module}/${module2}/${entity?uncap_first}/:method'), {}, {
            // 保存
            save: {method: 'POST', params: {method: 'save'<#if attachment!false>,attachmentIds:'@attachmentIds'</#if>}, isArray: false},

            // 更新
            update: {method: 'POST', params: {method: 'update'<#if attachment!false>,attachmentIds:'@attachmentIds'</#if>}, isArray: false},

            // 不带分页的列表查询
            query: {method: 'POST', params: {method: 'query'}, isArray: false},

<#if !deleted>
            // 批量启用
            enable: {method: 'POST', params: {method: 'enable', ids:'@ids'}, isArray: false},

            // 批量禁用
            disable: {method: 'POST', params: {method: 'disable', ids:'@ids'}, isArray: false},

            // 查询所有有效的数据，不带分页
            queryValid: {method: 'POST', params: {method: 'query-valid'}, isArray: false},
</#if>
<#if importData>
            // 导入数据
            importData: {method: 'POST', params: {method: 'import'}, isArray: false},

</#if>
            // 根据id查询信息
            get: {method: 'GET', params: {method: 'get', id: '@id'}, isArray: false},

            // 分页查询
            pageQuery: {method: 'POST', params: {method: 'pageQuery', limit: '@limit', start: '@start'}, isArray: false},

            // 根据id字符串（使用逗号分隔多个值）
            deleteByIds: {method: 'DELETE', params: {method: 'delete', ids: '@ids'}, isArray: false}
        })
    });

    app.service('${entity}Param', function(ParameterLoader<#if !deleted>,CommonUtils,${entity}Service</#if>) {
        var o = {
<#if !deleted>
            /**
            * 查询有效的数据并返回一个树形对象，适用于ztree-single
            * @param callback 选中节点后的回调
            */
            validTree: function (callback) {
                return {
                    data: function () {
                        return CommonUtils.promise(function (defer) {
                            var promise = ${entity}Service.queryValid(function (data) {
                                defer.resolve(data.data || []);
                            });
                            CommonUtils.loading(promise);
                        });
                    },
                    position: 'fixed',
                    click: callback
                };
            }
</#if>
        };
<#list fields as attr>
    <#if attr.param?has_content>

        // ${attr.name}
        o['${attr.field}'] = function(callback){
            ParameterLoader.loadSysParam('${attr.param}', callback);
        };

    </#if>
</#list>
        return o;
    });

<#if modal == true>
    app.service('${entity}Modal', function($modal, ModalFactory, AlertFactory, CommonUtils, ${entity}Service) {
        var common = function (options, callback) {
            var defaults = {
                id: null,//id
                pageType: null,     // 必填项,页面类型add/modify/view
                callback: null     // 点击确定后要执行的函数
            };
            options = angular.extend({}, defaults, options);
            callback = callback || options.callback;
            var modal = $modal({
                template: CommonUtils.contextPathURL('/app/${module}/${module2}/${entity?uncap_first}/template/${entity?uncap_first}-modal.ftl.html'),
                backdrop: 'static'
            });
            var $scope = modal.$scope;
            var pageType = $scope.pageType = options.pageType;
            var id = options.id;
            $scope.save = function () {
                var promise = ${entity}Service.save($scope.beans, function(data){
                    AlertFactory.success('保存成功!');
                    angular.isFunction(callback) && callback();
                    $scope.$hide();
                });
                CommonUtils.loading(promise);
            };

            $scope.update = function () {
                var promise = ${entity}Service.update($scope.beans, function(data){
                    AlertFactory.success('更新成功!');
                    angular.isFunction(callback) && callback();
                    $scope.$hide();
                });
                CommonUtils.loading(promise);
            };

            var load = function (id, callback){
                var promise = ${entity}Service.get({id: id}, function(data) {
                    $scope.beans = data.data || {};
                    callback($scope.beans);
                });
                CommonUtils.loading(promise);
            };

            if (pageType == 'add') {
                $scope.beans = {};
            } else if (pageType == 'modify') {
                load(id);
            } else {
                load(id, function () {
                    $('.modal-body').find('input,select,textarea').attr('disabled', 'disabled');
                    $('.modal-body').find('.icons.icon').remove();
                });
            }
        };
    return {
        add: function (options, callback) {
            var o = angular.extend({}, options, {pageType: 'add'});
            common(o, callback);
        },
        modify: function (options, callback) {
            if (!options.id) {
                alert('更新页面加载失败!没有获得ID');
                return;
            }
            var o = angular.extend({}, options, {pageType: 'modify'});
            common(o, callback);
        },
        view: function (options, callback) {
            if (!options.id) {
                alert('明细页面加载失败!没有获得ID');
                return;
            }
            var o = angular.extend({}, options, {pageType: 'view'});
            common(o, callback);
        }
    }
});
</#if>
})(angular);
