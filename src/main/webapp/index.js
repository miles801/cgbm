(function () {
    var app = angular.module('code', [
        'eccrm.angular',
        'eccrm.angularstrap'
    ]);
    app.controller('Ctrl', function ($scope, $http, CommonUtils, AlertFactory, ModalFactory) {
        // 基础信息
        $scope.beans = {
            project: 'd:/workspace/lr/itsm',
            module: 'itsm',
            module2: 'survey',
            entity: 'Subject',
            table: 'itms_subject',
            attachment: true,
            deleted: false,
            tree: false,
            level: true,    // 是否分模块
            modal: false,
            importData: false,
            export: false,
            packPath: 'eccrm.survey.questionbank',
            author: 'Michael',
            fields: [
                {
                    edit: true,
                    condition: true,
                    length: "100",
                    list: true,
                    name: "标题",
                    field: "title",
                    require: true,
                    type: "String",
                    type2: "text2"
                },
                {
                    edit: true,
                    condition: false,
                    length: "1000",
                    list: false,
                    field: "description",
                    name: "描述",
                    type: "String",
                    type2: "textarea"
                },
                {
                    edit: true,
                    field: "content",
                    condition: false,
                    length: "1000",
                    list: false,
                    name: "内容",
                    require: true,
                    type: "String",
                    type2: "textarea"
                }
            ]
        };


        $scope.type = [
            {name: 'String', value: 'String'},
            {name: 'Date', value: 'Date'},
            {name: 'Integer', value: 'Integer'},
            {name: 'Boolean', value: 'Boolean'},
            {name: 'Double', value: 'Double'}
        ];

        $scope.type2 = [
            {name: '文本', value: "text"},
            {name: '长文本', value: "text2"},
            {name: '下拉框', value: "select"},
            {name: '复选框', value: "checkbox"},
            {name: '单选框', value: "radio"},
            {name: '文本域', value: "textarea"},
            {name: '日期', value: "date"},
            {name: '时间', value: "time"},
            {name: '日期时间', value: "datetime"},
            {name: '树', value: "tree"}
        ];

        $scope.add = function (bean) {
            var fields = $scope.beans.fields || [];
            if (fields.length == 0) {
                bean.type = 'String';
                bean.type2 = 'text';
                bean.length = 40;
                bean.condition = true;
                bean.list = true;
                bean.edit = true;
            }
            var o = angular.extend({}, bean);
            o.name = null;
            o.field = null;
            fields.push(o);
        };

        $scope.remove = function (index) {
            $scope.beans.fields.splice(index, 1);
        };


        $scope.build = function () {
            var fields = $scope.beans.fields || [];
            if (fields.length == 0) {
                AlertFactory.error('请填写字段信息!');
                return false;
            }
            var names = {};
            var error = false;
            angular.forEach(fields, function (o) {
                if (names[o.field]) {
                    AlertFactory.error('字段重复!' + o.name + (o.field));
                    error = true;
                } else {
                    names[o.field] = o.field;
                }
            });
            if (error) {
                return;
            }
            $http.post(CommonUtils.contextPathURL('/code'), $scope.beans)
                .success(function () {
                    alert('成功');
                })
                .errors(function () {
                    alert('请求失败!');
                });
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
