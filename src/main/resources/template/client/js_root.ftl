(function (angular) {
    var app = angular.module('${moduleName}.${className?uncap_first}', [
        'eccrm.angular',
        'eccrm.angular.ztree',
        'eccrm.base.param'
    ]);

    // web层访问接口服务
    app.service('${className}Service', function (CommonUtils, $resource) {
        return $resource(CommonUtils.contextPathURL('/${moduleName}/${className}/:method'), {}, {

            // 保存
            save: {method: 'POST', params: {method: 'save'}, isArray: false},

            // 更新
            update: {method: 'POST', params: {method: 'update'}, isArray: false},

            // 根据id查询明细
            // 必须参数：
            //      id:业务对象ID
            get: {method: 'GET', params: {method:'get', id: '@id'}, isArray: false},

            // 分页查询,支持后台BO的所有查询条件
            // 可选参数：
            //      所有BO对象的属性
            pageQuery: {method: 'POST', params: {method: 'query', limit: '@limit', start: '@start'}, isArray: false},

            // 查询有效的数据
            //  可选参数：
            //      所有BO对象的属性
            queryValid: {method:'GET', params:{method:'queryValid'},isArray:false},

            // 根据id删除/注销对应的数据
            // 必须参数：
            //  ids:id，如果是多个值（即批量删除），使用英文逗号进行分隔
            deleteByIds: {method: 'DELETE', params: {method: 'delete', ids: '@ids'}, isArray: false}

        })
    });

    // 定义业务参数、系统参数的服务
    app.service('${className}', function(ParameterLoader,CommonUtils){
        return {

        }
    });

    // 定义树
    app.service('${className}Tree', function(${className}Service, CommonUtils){
        return {
            // 单选，与ztree-single插件一起使用
            pick: function(){},

            // 显示树，一般用于维护界面
            tree: function(){
            },
            // 显示有效树，一般用于给其他模块调用
            validTree: function(){
            }
        }
    });


})(angular);
