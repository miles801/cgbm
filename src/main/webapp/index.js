(function () {
    var app = angular.module('code', []);
    app.controller('CodeCtrl', function ($scope) {
        // 基础信息
        $scope.common = {
            rootPath: 'D:/workspace/ulane/wbs/cisco/',
            moduleName: 'survey',
            overwrite: true,
            packageName: 'eccrm.survey.questionbank',
            auth: 'Michael',
            className: 'QuestionCategory'
        };

        // 服务端可配置项
        $scope.server = [
            {name: '权限', value: 'permission', checked: false},
            {name: '动态树', value: 'dynamicTree', checked: false},
            {name: '附件', value: 'attachment', checked: false},
            {name: '保存', value: 'permission', checked: true},
            {name: '更新', value: 'permission', checked: true},
            {name: '高级分页查询', value: 'pageQuery', checked: true},
            {name: '有效分页查询', value: 'pageQueryValid', checked: false},
            {name: 'ID查询', value: 'findById', checked: true},
            {name: '批量删除', value: 'batchDelete', checked: true},
            {name: '权限分页查询', value: 'permissionPageQuery', checked: true},
            {name: '权限集合查询', value: 'permissionQuery', checked: true}
        ];

        // 构建清单
        $scope.items = [
            {name: 'BO', value: 'bo', checked: true},
            {name: 'VO', value: 'vo', checked: true},
            {name: 'Web层', value: 'ctrl', checked: true},
            {name: 'Service', value: 'service', checked: true},
            {name: 'Service实现', value: 'serviceImpl', checked: true},
            {name: 'DAO', value: 'dao', checked: true},
            {name: 'DAO实现', value: 'daoImpl', checked: true},
            {name: '实体类', value: 'domain', checked: true},
            {name: '映射文件', value: 'mapping', checked: true}
        ];
        $scope.attributes = [{type: 'String'}];


        $scope.addAttr = function () {
            $scope.attributes.push({type: 'String'});
        };

        $scope.removeAttr = function (index) {
            $scope.attributes.splice(index, 1);
        };

        $scope.$on('addAttribute', $scope.addAttr);

        $scope.build = function () {
            var options = {};
            // 获得基础配置
            angular.extend(options, $scope.common);

            // 获得服务端配置
            options.serverOptions = angular.extend({}, $scope.serverOptions);
            angular.forEach($scope.server, function (o) {
                options.serverOptions[o.value] = o.checked;
            });

            // 获得客户端配置
            options.clientOptions = angular.extend({}, $scope.clientOptions);

            // 获得构建清单
            options.buildOptions = angular.extend({}, $scope.buildOptions);

            console.dir(options);
        };
    });

    // 按下回车事触发事件
    app.directive('eventKeydown', function () {
        return {
            link: function (scope, element, attr, ctrl) {
                var eventName = attr['eventKeydown'];
                element.keydown(function (e) {
                    var keycode = e.which || e.keyCode;
                    if (keycode !== 13) {
                        return;
                    }
                    scope.$apply(function () {
                        scope.$emit(eventName);
                    });
                });
            }
        };
    });
})();


// 类信息
//      是否有附件
//      是否动态树（在service和dao中需要依赖）
// service接口层信息
//      保存
//      更新
//      查询有效的子节点（树）
//      高级分页查询
//      根据ID查询
//      批量删除
//      批量注销
//      批量启用
//      带权限的分页查询（权限）
//      带权限的集合查询（权限）
// dao接口层信息
//      保存
//      更新
//      查询集合
//      查询总记录数
//      批量删除
//      带权限的集合查询（权限）
//      带权限的总记录数查询（权限）
//      查询有效的子节点（树）
// Controller层信息
//      保存
//      跳转新建页面
//      更新
//      跳转更新页面
//      根据ID查询
//      跳转明细页面
//      批量删除
//      高级分页查询
//      带权限的分页查询（是否权限）
//      带权限的集合查询（是否权限）
//      查询有效的节点（树）
//  根js
//      POST:保存
//      PUT：更新
//      POST：高级分页查询
//      POST：带权限的高级分页查询
//      POST：带权限的集合查询
//      DELETE：批量删除
//      GET：根据ID查询
//      GET：查询子节点（树）
//      左侧树（树）
//      树形单选（树）
//      弹出层新增、编辑、明细（是否弹出）
//
//  列表页面js
//      新增、更新、明细（如果是弹出，则调用模型，否则跳转页面）
//      删除、批量删除
//      查询
//      初始化左侧树（树）
//  编辑页面js（不是弹出）
//      保存
//      更新
//
//