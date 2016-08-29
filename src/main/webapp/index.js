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
            table: 'itsm_',
            attachment: false,
            deleted: false,
            tree: false,
            level: false,    // 是否分模块
            modal: false,
            importData: true,
            export: true,
            packPath: 'com.michael.',
            author: 'Michael',
            fields: [
                {
                    edit: true,
                    length: "100",
                    list: true,
                    condition: true,
                    name: "标题",
                    field: "title",
                    require: true,
                    type: "String",
                    id: false,
                    type2: "text"
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
            {name: '树', value: "tree"},
            {name: '富文本', value: "richtext"}
        ];

        $scope.items = [
            {name: "类", value: "entity", checked: true},
            {name: "BO", value: "bo", checked: true},
            {name: "vo", value: "vo", checked: true},
            {name: "Dao", value: "dao", checked: true},
            {name: "Dao实现", value: "dao_impl", checked: true},
            {name: "Service", value: "service", checked: true},
            {name: "Service实现", value: "service_impl", checked: true},
            {name: "Controller", value: "ctrl", checked: true},
            {name: "根js", value: "js_root", checked: true},
            {name: "列表页面", value: "list", checked: true},
            {name: "列表页面JS", value: "list_js", checked: true},
            {name: "编辑页面", value: "edit", checked: true},
            {name: "编辑页面JS", value: "edit_js", checked: true}
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
        var swapItems = function (index1, index2) {
            var fields = $scope.beans.fields;
            fields[index1] = fields.splice(index2, 1, fields[index1])[0];
        };
        $scope.up = function (index) {
            swapItems(index, index - 1);
        };

        $scope.down = function (index) {
            swapItems(index, index + 1);
        };


        $scope.build = function () {
            var fields = $scope.beans.fields || [];
            if (fields.length == 0) {
                AlertFactory.error('请填写字段信息!');
                return false;
            }

            var items = [];
            angular.forEach($scope.items, function (o) {
                if (o.checked) {
                    items.push(o.value);
                }
            });
            if (items.length == 0) {
                AlertFactory.error('请选择要生成的内容!');
                return;
            }
            $scope.beans.items = items;
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
                .error(function () {
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
