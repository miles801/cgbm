(function (window) {
    angular.module('eccrm.angular', [
        'eccrm.angular.base',
        'eccrm.angular.date',
        'eccrm.angular.string',
        'eccrm.angular.pagination',
        'eccrm.angular.picker',
        'eccrm.angular.adjustment',
        'eccrm.angular.route',
        // 依赖bindonce.js
        'pasvaz.bindonce'
    ]).factory('eccrmHttpInterceptor', ['$q', '$window', '$log', function ($q, $window, $log) {
        return function (promise) {
            return promise.then(function (response) {
                var data = response.data;
                if (angular.isObject(data)) {
                    var error = data.error;
                    if (error == true) {
                        var msg = data.message || '';
                        if (msg) {
                            msg = '错误信息:' + msg;
                        }
                        var code = data.code || '';
                        if (code) {
                            code = '状态码:[' + code + '],';
                        }
                        $log.error('操作异常! ' + code + ((data.data || {}).detail || ''));
                    }
                }
                return response;
            }, function (response) {
                if (art && angular.isFunction(art.dialog)) {
                    var maxHeight = $(document).height() * 0.6;
                    var maxWidth = $(document).width() * 0.8;
                    art.dialog({
                        padding: 5,
                        fixed: true,
                        resize: true,
                        icon: 'error',
                        content: '<div style="max-height: ' + maxHeight + 'px;max-width:' + maxWidth + 'px;overflow:auto;">' + response.data + '</div>',
                        lock: true
                    });
                } else {
                    var o = $window.open('error.html', 'errorWin', 'height=700, width=1000, top=0,left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
                    o.document.write(response.data);
                }
                return $q.reject(response);
            });
        }
    }]).config(['$httpProvider', function ($httpProvider) {
        // 给所有的ajax请求添加X-Requested-With header
        $httpProvider.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';
        $httpProvider.defaults.headers.common['Cache-Control'] = 'no-cache';
        $httpProvider.defaults.headers.common['If-Modified-Since'] = '0';
        $httpProvider.responseInterceptors.push('eccrmHttpInterceptor');
    }]);

    //基本
    angular.module('eccrm.angular.base', ['ngCookies'])
        .service('Debounce', function () {
            var timer = null;
            return {
                delay: function (fn, delay) {
                    var context = this, args = arguments;
                    clearTimeout(timer);
                    timer = setTimeout(function () {
                        if (!angular.isFunction(fn)) return;
                        fn.apply(context, args);
                    }, delay);
                }
            }
        })
        .service('ArtDialog', function () {
            return {
                loading: function () {
                    return art.artDialog({
                        lock: true,
                        opacity: 0.3,
                        title: '消息',
                        drag: false,
                        esc: false,
                        resize: false,
                        show: false,
                        init: function () {
                            this.hide();
                        }
                    });
                }
            };
        })
        .service('CommonUtils', ['Debounce', '$window', '$q', '$parse', '$cookies', 'ArtDialog', function (Debounce, $window, $q, $parse, $cookies, ArtDialog) {
            var loadingMsg = [];
            var loadingDialog;
            var CommonUtils = function () {

            };
            CommonUtils.prototype = {
                // Debounce延迟函数
                delay: Debounce.delay,

                // 返回上一个页面
                // 如果当前页面是IFRAME，并且ID是以iframe_开头的，则表示当前窗口为页签，当调用该方法时，移除此页签
                back: function () {
                    if (self.frameElement.tagName == "IFRAME" && self.frameElement.id && self.frameElement.id.indexOf("iframe_") == 0) {
                        new CommonUtils().addTab('remove', self.frameElement.id);
                    } else {
                        $window.history.back();
                    }
                },

                // 从Cookie中获取登录上下文信息
                // 返回值：{}
                // 对象中可获取的信息有id（员工id）、username（用户名）、employeeName（员工名称）
                loginContext: function () {
                    var id, username, employeeName;
                    if ($cookies['eccrmContext.id']) {
                        id = $cookies['eccrmContext.id'];
                        username = decodeURI(decodeURI($cookies['eccrmContext.username']));
                        employeeName = decodeURI(decodeURI($cookies['eccrmContext.employeeName']));
                    } else if ($cookies['AuthUser_LoginId']) {
                        username = $cookies['AuthUser_LoginId'];
                    }
                    return {
                        id: id,
                        username: username,
                        employeeName: employeeName
                    }
                },

                // 获取基于ContextPath的访问路径
                // 每一个使用此js的页面都要求提供在页面中window.angular对象中提供一个contextPathURL属性或者在页面中提供一个id为contextPath的属性
                // 如果以上两个都没有提供，则使用相对路径(./url)
                // 参数URL：一般以/开头
                contextPathURL: function (url) {
                    if (!url) return '';
                    var contextPath;
                    if (!window.angular.contextPathURL && window.angular.contextPathURL !== undefined) {
                        contextPath = "/";
                    } else {
                        contextPath = angular.element('head base').attr('href') || window.angular.contextPathURL || angular.element('#contextPath').val() || './';
                    }
                    var lastChar = contextPath.charAt(contextPath.length - 1);
                    var urlStartChar = url.charAt(0);
                    if (lastChar === '/' && urlStartChar === '/') {
                        return contextPath + url.substr(1);
                    } else if (lastChar !== '/' && urlStartChar !== '/') {
                        return contextPath + '/' + url;
                    }
                    return contextPath + url;
                },
                // 使用artDialog插件弹出一个提示框，当只有一个参数时，标题即为内容
                // 参数1（可选）：标题
                // 参数2（必须）：内容
                // 参数3（可选）：图标
                artDialog: function (title, content, icon) {
                    content = content || title;
                    if (!title || content == title) title = '信息';
                    if (art && angular.isFunction(art.dialog)) {
                        var obj = {
                            title: title,
                            content: content
                        };
                        if (typeof icon === 'string') {
                            obj.icon = icon;
                        }
                        art.dialog(obj);
                        return art;
                    } else {
                        alert(title + ':' + content);
                        throw '没有获得art对象!请确保加载了artDialog插件相关的js和css!';
                    }
                },
                // 异步加载数据时显示一个loading效果（可以指定标题），加载过程中，页面不可点击
                // 当数据加载完毕后关闭该效果，并返回响应的数据
                // 接收参数：
                // promise：必须，延迟对象
                // title:可选，默认（Loading...）
                // callback：可选，当数据加载完毕后的回调
                // scope:可选，如果指定了该参数，则在整个异步过程中，将会设置该form为invalid，当请求结束后，将会恢复
                loading: function (promise, title, callback, scope) {
                    loadingDialog = loadingDialog || ArtDialog.loading();
                    // 如果没有未来对象，则直接返回
                    if (!promise) {
                        return;
                    }

                    // 如果只传递了callback
                    if (typeof title === 'function') {
                        callback = title;
                    }

                    var id = this.randomID();// 与消息绑定

                    // 如果没有显示，则显示
                    loadingMsg.unshift({id: id, msg: title});
                    if (loadingDialog.config.show === false) {
                        loadingDialog.title(loadingMsg.shift().msg);
                        loadingDialog.show();
                    }
                    // 禁用form操作
                    if (scope && scope.form) {
                        scope.form.$setValidity(id, false);
                    }
                    var $promise = promise.$promise || promise.promise || $q.when(promise);
                    $promise.then(function (data) {
                        angular.forEach(loadingMsg || [], function (v, index) {
                            if (v.id === id) {
                                loadingMsg.splice(index, 1);// 删除元素
                                // 恢复form操作
                                if (scope && scope.form) {
                                    scope.form.$setValidity(id, true);
                                }
                            }
                        });
                        if (callback && angular.isFunction(callback)) {
                            callback.call(data, data);
                        }
                        // 如果还有消息没有显示，则继续显示，如果都已显示，则隐藏当前对话框
                        if (loadingMsg.length > 0) {
                            var o = loadingMsg.shift();
                            loadingDialog.title(o.msg);
                        } else {
                            loadingDialog.hide();
                        }
                    });
                },
                // 使用artDialog弹出一个带有success图标的成功提示框
                // 参数1（必须）:内容
                // 参数2（可选）：标题
                successDialog: function (content, title) {
                    title = title || '信息';
                    this.artDialog(title, content, 'succeed');
                },

                // 使用artDialog弹出一个带有error图标的错误提示框
                // 参数1（必须）:内容
                // 参数2（可选）：标题
                errorDialog: function (content, title) {
                    title = title || '错误';
                    this.artDialog(title, content, 'error');
                },

                // 获得一个$q延迟对象
                defer: function () {
                    return $q.defer();
                },
                // 使用$q延迟执行指定的函数，并返回结果
                // 参数1（必须）：回调函数，会回传defer对象，defer对象中可以通过isResolved来判断是否正确的返回了结果
                // 参数2（可选）：延迟的毫秒数（默认为0）
                // 参数3（可选）：有如下两种配置
                //      超时时间（默认为5000毫秒），单位为毫秒，即指定时间后没有返回结果，则中止查询
                //      超时配置：{timeout:5000,callback:function(){..超时的的回调函数...  }}
                promise: function (callback, delay, timeout) {
                    if (!angular.isFunction(callback)) {
                        this.artDialog('错误', '使用promise方法必须传递一个回调函数!')
                    }
                    var time = 5000;
                    var timeoutCallback;
                    if (angular.isNumber(timeout)) {
                        time = timeout;
                    } else if (angular.isObject(timeout)) {
                        time = timeout.timeout || 5000;
                        timeoutCallback = timeout.callback;
                    }


                    var defer = $q.defer();
                    defer.isResolved = false;
                    var then = defer.promise.then;

                    var timeoutId;
                    defer.promise.then = (function () {
                        defer.isResolved = true;
                        clearTimeout(timeoutId);
                        return then;
                    })();
                    delay = angular.isNumber(delay) ? delay : 0;
                    this.delay(function () {
                        // 如果指定时间没有返回结果，则自动超时
                        timeoutId = setTimeout(function () {
                            if (angular.isFunction(timeoutCallback)) {
                                timeoutCallback.call(defer);
                            } else {
                                defer.reject('请求超时!');
                            }
                        }, time);
                        callback(defer);
                    }, delay);
                    return defer.promise;
                },
                // 返回一个对象的promise对象
                // 如果参数不是对象，则直接返回原对象
                parseToPromise: function (obj) {
                    if (!obj || (typeof obj !== 'object')) return obj;
                    return obj.promise || obj.$promise || $q.when(obj);
                },
                // 解析angularjs表达式
                // 参数1（必须）：上下文
                // 参数2（必须）：要被解析的字符串
                // 参数3（可选）：要被设置的新的值
                parse: function (context, str, newValue) {
                    if (!angular.isObject(context) && str) {
                        this.artDialog('错误', '解析上下文必须是一个对象,被解析的字符串不能为空!')
                    }
                    var parsed = $parse(str, newValue);
                    return parsed(context);
                },
                // 对字符串使用encodeURI进行两次编码，如果不是字符串，则直接返回
                // 参数1：要被编码的字符串
                encode: function (str) {
                    if (typeof str === 'string') {
                        return encodeURI(encodeURI(str));
                    }
                    return str;
                },
                // funcs[]:要执行的函数链,，每个函数都拥有一个独立的$q.defer()对象
                //      执行完毕需要调用this.resolve()来说明正常执行完成或者this.reject()来说明函数异常终止，将不会执行后面的函数
                //      resolve和reject都将接收一个结果参数
                // success:成功后要执行的方法，接收一个参数（最后一个链式函数执行完毕后返回的值）
                // fail:失败后要执行的方法，接收一个参数（表明失败的原因）
                chain: function (funcs, success, fail) {
                    var defer = $q.defer();
                    var i = 0;
                    var value;
                    var func = function (callback) {
                        var innerDefer = $q.defer();
                        callback.call(innerDefer, value);
                        innerDefer.promise.then(function (successValue) {
                            value = successValue;
                            if (funcs.length == (i + 1)) {
                                success(successValue);
                                return;
                            }
                            i++;
                            func(funcs[i]);
                        }, function (failReason) {
                            defer.reject(failReason);
                        });
                    };
                    func(funcs[i]);
                    defer.promise.then(success, fail);
                    return defer.promise;
                },
                // 删除指定对象/数组中的指定的属性
                // 必须参数：obj：可以为对象或者数组（数组中的元素必须是一个对象）
                // 必须参数：attr：字符串，要从对象中删除的属性名称
                deleteAttr: function (obj, attr) {
                    if (angular.isObject(obj) || angular.isArray(obj)) {
                        if (!attr || typeof attr !== 'string') return;
                        if (angular.isObject()) {
                            delete obj[attr];
                        } else {
                            for (var i = 0; i < obj.length; i++) {
                                if (angular.isObject(obj[i])) {
                                    delete obj[i][attr];
                                }
                            }
                        }
                    }
                },
                // 生成随机ID：值从0-9,a-z,A-Z以及_中随机产生
                // 可选参数：
                //  length<number>：要生成的id的长度（默认为16）
                randomID: function (length) {
                    // 调整长度
                    length = parseInt(length);
                    if (length < 1) {
                        length = 16;
                    }
                    // 设置id元素
                    var keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_'.split('');
                    var keyMaxIndex = keys.length;
                    // 产生id
                    var id = '';
                    (function () {
                        for (var i = length; i > 0; i--) {
                            var index = Math.floor(Math.random() * keyMaxIndex);
                            id += keys[index];
                        }
                    })();
                    return id;
                },
                // 加载一个或多个脚本
                // 必须参数：scripts ，字符串或字符串数组（要加载的脚本的路径）
                // 可选参数：success：function，所有脚本加载完成后的回调
                // 可选参数：fail:function，失败后的回调，可以获取失败的原因
                // FIXME 未完成
                loadScript: function (scripts, success, fail) {
                    var array;
                    if (typeof scripts == 'string') {
                        array = [scripts];
                    } else if (angular.isArray(scripts)) {
                        array = scripts;
                    } else {
                        alert('不合法的参数!');
                        return false;
                    }
                    var context = this;
                    var promise = context.promise;
                    // 批量异步加载
                    var promised = [];
                    angular.forEach(array, function (url) {
                        // 超时时间为8秒
                        promise(function (defer) {
                            alert(url);
                            $.getScript(url, function () {
                                defer.resolve(true);
                            });
                        }, 0, {
                            timeout: 8000, callback: function () {
                                this.reject('请求超时!' + url);
                            }
                        });
                    });

                    // 开始执行加载
                    $q.all(promised, success, fail);
                },

                // 添加页签
                addTab: function (options) {
                    function Tab() {
                    }

                    Tab.prototype = {
                        title: '新页签',// 必须，页签的标题
                        url: '',// 必须，页签要打开的url
                        isRoot: false,// 是否是根页签，只能有一个
                        canClose: true,// 是否允许关闭，根不允许被关闭
                        onClose: null,// 可选，当当前页签被关闭时需要做的操作（该事件会被打开当前页签的那个对象所捕获）
                        onUpdate: null,// 可选，当当前页签的内容被更新之后，被手动设置了更新，则当前事件会被触发
                        targetObj: window.parent,// 页签在哪个窗口中显示，默认将当前窗口的上级窗口
                        targetElm: '#tab',// 页签在指定窗口的哪一个元素上显示
                        active: true// 添加玩页签后是否激活，默认为true
                    };
                    var context = this;

                    // 获取数据
                    var tab = new Tab();
                    if (angular.isObject(options)) {
                        angular.extend(tab, options);
                    }
                    tab.targetObj = tab.targetObj || window.parent || window;
                    var target = tab.targetObj;
                    var element = $(tab.targetObj.document).find(tab.targetElm);
                    if (element.length < 1) {
                        alert('添加页签时，配置错误!');
                        return;
                    }
                    var iframeId = 'iframe_' + this.randomID(4);
                    // 获取模板
                    var isRoot = tab.isRoot;
                    if (isRoot) {
                        target['_eve'] = {};// 当为root时，清空之前的数据
                    }
                    var events = target['_eve'];
                    var canClose = tab.canClose;
                    var getTemplate = function () {
                        var tpl =
                            '<div class="panel panel-tab" style="height: 100%;margin: 0;position: relative;" >' +
                            '   <ul class="nav nav-tabs" style="position: absolute;margin: 5px 0 0 0;width:100%;">' +
                            '   </ul >' +
                            '   <div class="tab-content" style="height: 100%;width:100%;padding-top: 35px;position: absolute;" >' +
                            '    </div >' +
                            '</div >';
                        if (isRoot) {
                            element.find('.panel.panel-tab').remove();
                            var foo = $(tpl);
                            element.append(foo);
                            return foo;
                        }
                        return element.find('.panel.panel-tab');
                    };

                    // 当前的window对象（也是打开页签的对象）
                    var currentWindow = window;
                    // 添加click事件
                    var addListener = function () {
                        var current = this;
                        var clicked = false;
                        current.bind('click', function (e, isActive) {
                            e.stopPropagation();
                            if ($(e.target) == current) {
                                return;
                            }
                            if (isActive == true || isActive === undefined) {
                                clicked = true;
                                current.siblings().removeClass('active');
                                current.addClass('active');
                                // 以前激活状态的iframe隐藏
                                var iframeContainer = current.parent('.nav.nav-tabs').siblings('.tab-content');
                                iframeContainer.find('iframe:visible').hide();

                                var iframeId = current.find('i').attr('target');
                                var activeIframe = iframeContainer.find('#' + iframeId);
                                if (activeIframe.length < 1) {
                                    alert('没有可显示的iframe!');
                                }
                                activeIframe.show();
                            }
                        });
                    };


                    // 添加tab
                    var createTab = function (root) {
                        var li =
                            '<li >' +
                            '    <i target="' + iframeId + (isRoot ? '" >' : '" style="padding-right:25px;">') + tab.title + '</i >' +
                            ((!isRoot && canClose) ? ('    <span id="span_' + iframeId + '" class="icons fork" style="top: 2px; right: 0px; position: absolute; cursor: pointer;" title="关闭"></span >') : '') +
                            '</li >';
                        var $li = $(li);
                        var $iframe = $('<iframe name="' + iframeId + '" id="' + iframeId + '" src="' + context.contextPathURL(tab.url) + '" frameborder="0" style = "border: 0;height: 100%;width: 100%;margin: 0;padding: 0;" > </iframe>');


                        root.find('.nav.nav-tabs').append($li);
                        root.find('.tab-content').append($iframe);

                        $li.find('span').bind('click', function (e) {
                            // 删除注册的事件
                            delete events[iframeId];
                            // 激活其他选项
                            $li.siblings(':eq(0)').trigger('click');

                            // 移除当前tab
                            $li.remove();
                            $iframe.remove();
                            if (angular.isFunction(tab.onClose)) {
                                tab.onClose();
                            }

                        });

                        // 添加更新时通知事件
                        if (!isRoot && angular.isFunction(tab.onUpdate)) {
                            events[iframeId] = tab.onUpdate;
                        }
                        addListener.call($li);
                        return $li;

                    };

                    // 将参数数组转换成普通数组
                    var argFoo = arguments;
                    var getArgumentArray = function () {
                        var args = [];
                        angular.forEach(argFoo, function (o, index) {
                            args.push(o);
                        });
                        return args;
                    };

                    // 功能操作
                    if (typeof options == 'string') {
                        // 移除
                        var nowId = currentWindow.frameElement.id;
                        if ("remove" === options && arguments[1]) {
                            getTemplate().find('#span_' + arguments[1]).trigger('click');
                        } else if ("update" === options) {
                            if (events[nowId]) {
                                events[nowId].apply(getArgumentArray().slice(1));
                            }
                        } else {
                            alert('未知的操作类型:' + options);
                        }
                    } else {
                        // 创建tab并手动触发事件
                        var tabElement = createTab(getTemplate());
                        tabElement.trigger('click', tab.active);
                    }

                },


                // 获得指定模块的注册器，返回一个promise对象，可以通过该对象获取在该模块中注册的各种服务对象的实例
                // 必须参数
                //  appObj：当前的module对象
                //  moduleName：要加载的模块的名称
                // 可选参数
                //  jsPath：moduleName模块如果不存在，则需要通过该路径加载
                lazyLoad: function (appObj, moduleName, jsPath) {
                    var context = this;
                    if (!appObj || !angular.isArray(appObj.requires)) {
                        context.errorDialog('调用CommonUtils.lazyLoad()时出错，第一个参数必须是当前module对象!');
                        return false;
                    }

                    if (!moduleName) {
                        context.errorDialog('调用CommonUtils.lazyLoad()时出错，没有指定需要加载的module的名称!');
                        return false;
                    }
                    var defer = $q.defer();

                    var modules = {};
                    // 注入模块
                    var inject = function () {
                        try {
                            var injector = angular.injector([moduleName]);
                            defer.resolve(injector);
                        } catch (e) {
                            reject('调用CommonUtils.lazyLoad()时出错，注册模块[' + moduleName + ']时失败!');
                        }
                    };

                    // 错误响应
                    var reject = function (errorMsg) {
                        context.errorDialog(errorMsg);
                        defer.reject(errorMsg);
                    };

                    if ($.inArray(moduleName, appObj.requires) != -1) {
                        inject();
                    } else {
                        try {
                            angular.module(moduleName);// 判断模块是否存在
                            inject();
                        } catch (e) {
                            if (!jsPath) {
                                reject('调用CommonUtils.lazyLoad()时出错，注入模块[' + moduleName + ']时失败,且没有指定jsPath!');
                            }
                            $.getScript(jsPath, inject);
                        }
                    }
                    return defer.promise;
                }
            };
            return new CommonUtils();
        }])
        // 权限，一般配合ng-cloak一起使用
        // 用法< eccrm-previlege="这里是资源编号">
        // 当初始化后，会去session的权限编号集合中查询指定的编号是否存在，如果存在则不做操作，如果不存在，则删除当前元素
        .directive('eccrmPrevilege', ['$http', 'CommonUtils', function ($http, CommonUtils) {
            return {
                link: function (scope, element, attr, ctrl) {
                    var code = attr['eccrmPrevilege'];
                    if (!code) return;
                    $http.get(CommonUtils.contextPathURL('/auth/accreditFunc/hasPermission?code=' + code))
                        .success(function (data) {
                            if (data.data == false) {
                                element.remove();
                            }
                        })
                        .error(function (data) {
                            alert('权限查询失败!' + (data.error || data.fail || data.message));
                        });
                }
            }
        }]);


// 时间相关的插件
    angular.module('eccrm.angular.date', [])
        .factory('DateFormat', ['$filter', function ($filter) {
            return function (value, pattern) {
                if (!value) return '';
                return $filter('date')(value, pattern);
            }
        }])
        .filter('eccrmDate', ['DateFormat', function (DateFormat) {
            return function (value) {
                return DateFormat(value, 'yyyy-MM-dd');
            }
        }])
        .filter('eccrmTime', ['DateFormat', function (DateFormat) {
            return function (value) {
                return DateFormat(value, 'HH:mm:ss');
            }
        }])
        .filter('eccrmDatetime', ['DateFormat', function (DateFormat) {
            return function (value) {
                return DateFormat(value, 'yyyy-MM-dd HH:mm:ss');
            }
        }])
        // 倒计时插件
        // 使用方式：<div eccrm-count-down="options"></div>
        // 配置参数：options：{}，配置对象
        // 该对象可以是一个延迟对象(promise对象）或者是一个普通的对象{}
        // 必须属性：
        //    seconds:[number],秒数，如果值为正数，则表示倒计时；如果值为负数，则表示计时
        //    onChange:[function]，当值从正数变为负数时触发的事件
        //    stopWhileZero:true, 当倒计时到0时，是否停止
        .directive('eccrmCountDown', ['CommonUtils', '$timeout', function (CommonUtils, $timeout) {
            return {
                scope: {
                    options: '=eccrmCountDown'
                },
                link: function (scope, element) {
                    var promise = CommonUtils.parseToPromise(scope.options || {});
                    promise.then(function (options) {
                        var value = options.seconds || 0; // 用户配置的秒数

                        // 计时器显示效果：小时：分钟：秒数
                        var hour, minute, seconds;

                        // 计算初始的小时、分钟和秒数
                        var calculate = function () {
                            hour = Math.floor(value / 3600);
                            minute = Math.floor(value / 60 - hour * 60);
                            seconds = value - (hour * 3600 + minute * 60);
                        };

                        // 创建元素
                        var createElement = function (index, className) {
                            return $('<span class="' + (className || "") + '"><img src="' + CommonUtils.contextPathURL("/style/standard/images/number/") + index + '.png" style="margin-left:2px;width:20px;height:30px;display:inline-block;"/></span>');
                        };

                        // 补零操作
                        var addZero = function (v) {
                            if (angular.isNumber(v)) {
                                if (v < 10) {
                                    v = '0' + v;
                                }
                            }
                            return v;
                        };

                        // 添加图片到当前元素内
                        var addElement = function (v, className) {
                            v = addZero(v);
                            var arr = v.toString().split('');
                            angular.forEach(arr, function (foo) {
                                element.append(createElement(foo, className))
                            });

                        };

                        // 事件
                        var hourElm, minuteElm, secondsElm;
                        var hourEvent = function () {
                            hourElm = hourElm || element.find('.hour img');
                            changePicUrl(hourElm, hour);
                        };
                        var minuteEvent = function () {
                            minuteElm = minuteElm || element.find('.minute img');
                            changePicUrl(minuteElm, minute);
                        };
                        var secondEvent = function () {
                            secondsElm = secondsElm || element.find('.seconds img');
                            changePicUrl(secondsElm, seconds);
                        };

                        // 改变url
                        var changePicUrl = function (elems, currentValue) {
                            currentValue = addZero(currentValue);
                            angular.forEach(elems, function (e, index) {
                                var s = currentValue.toString().charAt(index);
                                $(e).attr('src', CommonUtils.contextPathURL('/style/standard/images/number/' + s + '.png'));
                            });
                        };

                        // 倒计时
                        var countDown = function () {
                            // 周期执行
                            setTimeout(function () {
                                var goon = true;
                                // 如果秒数大于0，则执行一秒，然后继续
                                if (seconds > 0) {
                                    seconds--;
                                    secondEvent();
                                    // 如果秒数《=0，则判断是否还有分钟可以借位
                                } else {
                                    if (minute > 0) {
                                        seconds = 59;
                                        minute--;
                                        secondEvent();
                                        minuteEvent();
                                    } else if (hour > 0) {
                                        seconds = 59;
                                        minute = 59;
                                        hour--;
                                        secondEvent();
                                        minuteEvent();
                                        hourEvent();
                                    } else {
                                        goon = false;
                                        // 如果到0不停止，则继续
                                        if (options.stopWhileZero != true) {
                                            expired();
                                        }

                                        // 触发倒计时事件
                                        if (angular.isFunction(options.onChange)) {
                                            scope.$apply(options.onChange);
                                        }
                                    }
                                }
                                changePicUrl();
                                if (goon) {
                                    setTimeout(arguments.callee, 1000);
                                }

                            }, 1000);
                        };

                        // 逾期
                        var expired = function () {
                            setTimeout(function () {
                                if (seconds == 59) {
                                    seconds = 0;
                                    if (minute == 59) {
                                        minute = 0;
                                        hour++;
                                        hourEvent();
                                    } else {
                                        minute++;
                                    }
                                    minuteEvent();
                                } else {
                                    seconds++;
                                }
                                secondEvent();
                                setTimeout(arguments.callee, 1000);
                            }, 1000);
                        };

                        var isExpired = false;
                        if (value < 0) {
                            value = Math.abs(value);
                            isExpired = true;
                        }
                        calculate();
                        addElement(hour, "hour");
                        addElement('_');
                        addElement(minute, "minute");
                        addElement('_');
                        addElement(seconds, "seconds");
                        calculate();
                        isExpired ? expired() : countDown();
                    });
                }
            }
        }]);
    // 倒计时


//字符串相关
    angular.module('eccrm.angular.string', [])
        // 格式化字符串长度，超出部分使用'...'进行替换
        // 参数1（必须）：值
        // 参数2（可选）：最大长度，默认为50
        // 参数3（可选）：替换的后缀，默认为'...'
        .filter('substr', [function () {
            return function (value, length, suffix) {
                if (typeof value !== 'string') return value;
                if (!value)return '';
                length = length || 50;
                suffix = suffix || '...';
                if (value.length > length) {
                    return value.substring(0, length) + suffix;
                }
                return value;
            }
        }]);
//分页
    angular.module('eccrm.angular.pagination', ['eccrm.angular.base'])
        .directive('eccrmPage', ['CommonUtils', '$q', function (CommonUtils, $q) {
            return {
                scope: {
                    pager: '=eccrmPage'
                },
                templateUrl: CommonUtils.contextPathURL('/static/ycrl/javascript/template/page.html'),
                link: function (scope, element, attr, ctrl) {
                    var defaults = {
                        fetch: angular.noop,//查询函数
                        pageSize: [5, 10, 15, 20, 30, 40, 50, 100, 150, 300, 500],
                        start: 0,
                        limit: 15,//每页显示的数量
                        total: 0,//总数据
                        opacity: 1,//透明度
                        firstAndLast: true,//第一页和最后一页按钮
                        allowNav: true,//允许输入页面进行跳转
                        prevAndNext: true,//上一页和下一页的按钮
                        configLimit: true,//显示每页数据
                        currentPage: 1,//当前页号
                        totalPage: 1,//总页数
                        ready: false,
                        totalProperty: 'total',//总记录条数，可以使用字符串或者一个函数
                        next: function () {
                            //没有到最后一页
                            if (this.currentPage < this.totalPage) {
                                this.currentPage++;
                            }
                        },
                        prev: function () {
                            //没有到达第一页
                            if (this.currentPage > 1) {
                                this.currentPage--;
                            }
                        },
                        first: function () {
                            //不是第一页
                            if (this.currentPage != 1) {
                                this.currentPage = 1;
                            }
                        },
                        last: function () {
                            //不是最后一页
                            if (this.currentPage != this.totalPage) {
                                this.currentPage = this.totalPage;
                            }
                        },
                        jump: function (page_no) {//跳转到指定页面
                            //不是当前页，并且大于等于第一页，小于等于最后一页
                            if (this.currentPage != page_no && page_no > 0 && page_no <= this.totalPage) {
                                this.currentPage = page_no;
                            }
                        },
                        init: function () {//初始化分页的参数
                            this.currentPage = 1;
                            this.totalPage = 1;
                            this.start = 0;
                            this.total = 0;
                        },
                        initPaginationInfo: function (total) {
                            this.total = total || 0;
                            this.totalPage = Math.ceil(total / this.limit) || 1;
                        },
                        finishInit: $.noop,//初始化完成的回调
                        load: function () {
                            var current = scope.pager;
                            if (angular.isFunction(current.fetch)) {
                                var s = current.fetch();//支持返回{total:number} obj.promise obj.$promise 或者promise对象
                                if (!s) return;
                                var doInitPagination = function (value) {
                                    var totalProperty = current.totalProperty || 'total';
                                    var total = 0;
                                    if (angular.isNumber(value)) {
                                        total = value;
                                    } else if ((typeof value === 'object') && angular.isNumber(value[totalProperty])) {
                                        total = value[totalProperty];
                                    }
                                    current.initPaginationInfo.call(current, total);
                                };
                                var promise = $q.when(s);
                                promise.then(doInitPagination);
                                return promise;
                            }

                        },
                        query: function () {
                            var current = scope.pager;
                            current.start = 0;
                            current.currentPage = 1;
                            current.load.call(current);
                        }
                    };
                    var pager = scope.pager = angular.extend({}, defaults, scope.pager);
                    var destroy = scope.$watch('pager.currentPage', function (value, oldValue) {
                        // 值未改变不操作
                        if (value === undefined || value === oldValue) return;

                        // 如果是修正之前的错误数据，则也不操作
                        if (oldValue && oldValue > pager.totalPage) {
                            return;
                        }

                        // 如果新的值超出了最大页数，则回到之前的页数
                        if (value > pager.totalPage) {
                            pager.currentPage = oldValue;
                            return;
                        }
                        pager.start = scope.pager.limit * (value - 1);
                        pager.load();
                    });
                    var destroy2 = scope.$watch('pager.limit', function (value, oldValue) {
                        if (value === undefined || value === oldValue) return;
                        pager.start = 0;
                        pager.currentPage = 1;
                        pager.load();
                    });
                    if (angular.isFunction(pager.finishInit)) {
                        pager.finishInit.call(pager);
                    }

                    // 限制可以跳转的页数
                    scope.$on('$destroy', destroy);
                    scope.$on('$destroy', destroy2);

                }
            };
        }])
        // 只可以输入数字的指定
        .directive('inputNumber', function () {
            return {
                link: function (scope, elm) {
                    elm.bind('keydown', function (e) {
                        var keyCode = e.keyCode || e.which;
                        if (!(keyCode > 47 && keyCode < 58)) { //0-9
                            e.preventDefault();
                        }
                    });
                }
            }
        });

//选择
    angular.module('eccrm.angular.picker', [])
        .directive('selectAllCheckbox', [function () {
            return {
                replace: true,
                restrict: 'EA',
                scope: {
                    checkboxes: '=',
                    allselected: '=allSelected',
                    allclear: '=allClear',
                    items: '=selectedItems',
                    anyoneSelected: '='
                },
                template: '<input type="checkbox" ng-model="master" ng-change="masterChange()" ng-cloak>',
                controller: ['$scope', '$element', '$attrs', function ($scope, $element, $attrs) {
                    if (!$scope.items) $scope.items = [];
                    //根改变
                    $scope.masterChange = function () {
                        if ($scope.master) {
                            angular.forEach($scope.checkboxes, function (cb) {
                                $scope.items.push(cb);
                                cb.isSelected = true;
                            });
                        } else {
                            $scope.items = [];
                            angular.forEach($scope.checkboxes, function (cb) {
                                cb.isSelected = false;
                            });
                        }
                    };
                    var destroy = $scope.$watch('checkboxes', function (value) {
                        var allSet = true,
                            allClear = true;
                        if (!value)$scope.items = [];//当checkbox的值发生变化时，清空选中的内容
                        angular.forEach(value, function (cb) {
                            var _ind = $.inArray(cb, $scope.items);
                            if (cb.isSelected) {
                                if (_ind == -1) {
                                    $scope.items && $scope.items.push(cb);
                                }
                                allClear = false;
                            } else {
                                allSet = false;
                                if (_ind != -1) {
                                    $scope.items && $scope.items.splice(_ind, 1);
                                }
                            }
                        });

                        if ($scope.allselected !== undefined) {
                            $scope.allselected = allSet;
                        }
                        if ($scope.allclear !== undefined) {
                            $scope.allclear = allClear;
                        }
                        if ($attrs['anyoneSelected']) {
                            $scope.anyoneSelected = !allClear;
                        }

                        $element.prop('indeterminate', false);
                        if (allSet && $scope.items && $scope.items.length > 0) {
                            $scope.master = true;
                        } else if (allClear) {
                            $scope.master = false;
                        } else {
                            $scope.master = false;
                            $element.prop('indeterminate', true);
                        }
                    }, true);
                    $element.on('$destroy', destroy);
                }]
            }
        }])
    ;

//单选框
//下拉框

//自适应相关
    angular.module('eccrm.angular.adjustment', ['eccrm.angular.base'])
        //自动调节高度
        .directive('eccrmAutoHeight', ['$window', 'Debounce', function ($window, Debounce) {
            return {
                restrict: 'A',
                link: function (scope, ele, attr) {
                    var el = attr['eccrmAutoHeight'];
                    if (!el) return;
                    var _p = ele.parent(), _e = $(el);
                    if (_p.length < 1) {
                        console.debug('没有获得对应的父容器!');
                        return;
                    }
                    if (_e.length < 1) {
                        console.debug('没有获得相对的兄弟元素，无法根据其高度进行自适应!');
                        return;
                    }
                    var changeSize = function () {
                        ele.animate(
                            {height: _p.height() - _e.outerHeight() - 5}, 500
                        );
                    };
                    angular.element(window).on('resize', function () {
                        Debounce.delay(changeSize, 200);
                    });
                    changeSize();
                }
            }
        }]);


    // 路由，以页签的方式展现
    // 配置对象：[]或者未来对象（最终也必须返回数组）
    angular.module('eccrm.angular.route', ['ngRoute', 'ngAnimate', 'eccrm.angular'])
        .directive('eccrmRoute', ['$window', '$location', 'CommonUtils', function ($window, $location, CommonUtils) {
            return {
                scope: {
                    routes: '=eccrmRoute'
                },
                templateUrl: CommonUtils.contextPathURL('static/ycrl/javascript/template/route.html'),
                link: function (scope, element, attr, ctrl) {
                    // 真正的页面地址（/wbs/xx?xx&xxx）
                    var path = $window.location.pathname + ($window.location.search || "");

                    var rs = scope.routes;
                    // 真正保存页签数据
                    scope.data = [];


                    // 获取当前页面的真正地址

                    // 解析数据，生成页签访问地址
                    var handle = function (routes) {
                        if (!routes || !angular.isArray(routes)) {
                            alert('页签加载失败，只支持数组类型!');
                            return false;
                        }
                        angular.forEach(routes, function (value, index) {
                            scope.data.push(value);
                            var url = value.url;
                            if (!url) throw '无效的路由地址';
                            if (url.indexOf('#') !== 0) {
                                url = '#' + url;
                            }
                            value.url = path + url;
                            if (value.active === true) {
                                $location.path(value.url);
                                scope.active = index;
                            }
                        });
                        if (scope.$parent.active == undefined) {
                            scope.$parent.active = 0;
                            $location.path(routes[0].url);
                        }
                    };

                    // 如果直接传递的是数组
                    if (angular.isArray(rs)) {
                        handle(rs);
                        return;
                    }
                    // 如果传递的是未来对象
                    if (angular.isObject(rs)) {
                        var promise = CommonUtils.parseToPromise(rs);
                        promise.then(handle);
                    }

                }
            }
        }]);
})
(window);