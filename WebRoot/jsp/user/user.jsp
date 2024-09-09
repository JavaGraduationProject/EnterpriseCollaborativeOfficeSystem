<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="renderer" content="webkit">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户列表</title>
    <!--基础css & js-->
    <link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/font-awesome/3.2.1/css/font-awesome.min.css" rel="stylesheet">
    <link href="/jsp/common/css/bootstrap-extend.css" rel="stylesheet">
    <link href="/jsp/common/css/validate.css" rel="stylesheet">
    <script src="https://cdn.bootcss.com/jquery/2.2.4/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcss.com/angular.js/1.5.0/angular.min.js"></script>
    <script src="/jsp/common/js/angular-md5.min.js"></script>
    <script src="https://cdn.bootcss.com/angular-file-upload/2.5.0/angular-file-upload.min.js"></script>
    <script src="/jsp/common/js/angular-cookie.min.js"></script>
    <script src="/jsp/common/template/baseModule.js"></script>
    <!--七牛云存储-->
    <script src="/jsp/qiniu/js/plupload.full.min.js"></script>
    <script src="/jsp/common/js/qiniu.min.js"></script>
    <script src="/jsp/qiniu/js/qiniu.my.js"></script>
    <!--日期处理-->
    <link href="/jsp/common/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="/jsp/common/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/jsp/common/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="/jsp/common/js/moment.min.js"></script>
</head>
<body ng-app="m" ng-init='index = "员工信息管理"'>
<jsp:include page="/jsp/common/nav.jsp"/>
<div ng-controller="c" class="container" style="width: 98%;">
    <div class="panel panel-default m-t-lg">
        <div class="panel-heading">
            <h4>用户列表</h4>

            <div class="clearfix">
                <label>
                    <button class="btn btn-success pull-left" ng-click="entity._openModal()">
                        <span class="icon-plus m-r"></span>新增&nbsp;用户
                    </button>
                </label>

                <form class="form-inline pull-right" ng-submit="page.refreshTo(1)">
                    <label>角色类型&nbsp;
                        <select class="form-control" ng-model="searchType" ng-options="x.en as x.cn for x in searchTypeArray"
                                ng-change="page.refreshTo(1)"></select>
                    </label>
                    <input class="form-control m-l" type="text"
                           placeholder="用户名/姓名/电话" ng-model="search">
                    <button class="btn btn-primary" type="submit">
                        <span class="icon-search m-r"></span> 搜索
                    </button>
                </form>
            </div>
        </div>
        <%@ include file="/jsp/common/table.jspf" %>
    </div>
    <%--模态框--%>
    <div entity-modal="modal" title="新增 用户" action="add" entity="entity">
        <entity-modal-body>
            <div entity-right-any="avatar" title="头像" entity="entity.entity" e="entity">
                <div id="container" style="width: 330px;">
                    <a class="btn btn-default btn-lg" id="pickfiles" style="width:160px">
                        <i class="glyphicon glyphicon-plus"></i>
                        <span ng-show="qnNgObj.status.firstPick">选择文件</span>
                        <span ng-show="qnNgObj.status.againPick">重新选择</span>
                    </a>
                    <a class="btn btn-default btn-lg" style="width:160px"
                       ng-click="qnUp.start()" ng-show="!qnNgObj.status.upSuccess">
                        <span>确认上传</span>
                    </a>
                    <a class="btn btn-success btn-lg" style="width:160px"
                       ng-show="qnNgObj.status.upSuccess">
                        <i class="glyphicon glyphicon-ok"></i>
                        <span>上传成功</span>
                    </a>

                    <div style="margin-top: 20px;">
                        <img id="imgPrev" width="320px" height="230px" src="" alt="请选择文件!"/>
                    </div>
                </div>
            </div>
             <div entity-edit-text="username" type="text" title="用户名" entity="entity.entity"
                 e="entity" vld="entity.validate"></div>
            <div entity-edit-text="password" type="password" title="密码" entity="entity.entity"
                 e="entity" vld="entity.validate"></div>
            <%--<div entity-edit-text="conPassword" type="password" title="确认密码" entity="entity.entity"
                 e="entity" vld="entity.validate"></div>--%>
            <div entity-edit-text="realname" type="text" title="姓名" entity="entity.entity" e="entity"
                 vld="entity.validate"></div>
            <div entity-edit-text="age" title="年龄" entity="entity.entity"
                 e="entity"></div>
            <div entity-right-any="sex" title="性别" entity="entity.entity"
                 e="entity" >
                 <select id="selectSex" class="form-control" ng-model="addsex"
                        ng-options="x for x in SexTypeArray"></select></div>
            <div entity-edit-text="address" type="text" title="住址" entity="entity.entity"
                 e="entity" vld="entity.validate"></div>
            <div entity-edit-text="phone" type="tel" title="电话" entity="entity.entity"
                 e="entity" vld="entity.validate"></div>
            <div entity-right-any="role" title="角色" entity="entity.entity" e="entity">
                <select id="selectRole" class="form-control" ng-model="addrole"
                        ng-options="x.en as x.cn for x in searchTypeArray"></select>
            </div>
        </entity-modal-body>
    </div>
    <div entity-modal="modal-edit" title="编辑 用户" action="edit" entity="entityEdit">
        <entity-modal-body>
            <div entity-edit-text="phone" type="tel" title="电话" entity="entityEdit.entity"
                 e="entityEdit" vld="entityEdit.validate"></div>
            <div entity-edit-text="address" type="text" title="住址" entity="entityEdit.entity"
                 e="entityEdit" vld="entityEdit.validate"></div>
        </entity-modal-body>
    </div>
    <div entity-modal="modal-del" title="删除 用户信息" action="delete" entity="entityDel">
        <entity-modal-body>
            <h4>确认删除该条用户信息？</h4>
        </entity-modal-body>
    </div>
</div>
<script>
    var m = angular.module("m", ["nm","qiniu","angular-md5"]);
    var c = m.controller("c", function ($rootScope,$scope,page,ajax,$filter,entity,uploader) {
        $scope.search = "";
        $scope.searchTypeArray = [{"cn":"员工","en":"user"}, {"cn":"管理员","en":"admin"}];
        $scope.searchType = "user";
        $scope.SexTypeArray = ["男","女"];

        /**
         * 表格-分页
         */
        $scope.page = page.page(function (current, size) {
            ajax.ajax("/user/getUserPageList", "GET", {
                    current: current,
                    size: size,
                    roleType: $scope.searchType,
                    search: $scope.search
                }).success(function (data) {
                console.log(data);
                if (data.success) {
                    $scope.page.refreshPage(data);
                }
            });
        });
        $scope.ths = [
            {
                name: "用户头像",
                img: function (row) {
                    return row.avatar;
                },
                clas: "circle",
                width: "5%",
                click: function (row) {
                    //$scope.editAvatarModal.modal(row);
                }
            }, {
                name: "用户ID",
                value: function (row) {
                    return row.id;
                },
                width: "5%"
            }, {
                name: "用户名",
                value: function (row) {
                    return row.username;
                },
                width: "10%"
            }, {
             name: "住址",
                 value: function (row) {
                 return row.address;
             },
             width: "10%"
             }, {
                name: "手机号",
                value: function (row) {
                    return row.phone;
                },
                width: "15%"
            }, /*{
             name: "状态",
             value: function (row) {
             return row.disabled == false ? "正常" : "已被禁用";
             },
             width: "15%",
             style: function (row) {
             return {
             "color": row.disabled == false ? "green" : "red"
             }
             }
             },*/ {
                name: "注册时间",
                value: function (row) {
                    return $filter('fmtDateYMdHMcn')(row.createTime);
                },
                width: "20%"
            }, {
                name: "角色类型",
                value: function (row) {
                    return row.role === "user" ? "普通用户" : "管理员";
                      
                },
                width: "10%"
            }
        ];
        $scope.operations = [
            {
                name: function () {
                    return "编辑";
                },
                clas: function () {
                    return {
                        "btn btn-xs btn-default": true
                    };
                },
                click: function (row) {
                    $scope.editObj = row;
                    $scope.entityEdit._openModal(row);
                }
            },{ 
            	name: function () {
                    return "";
                },
                clas: function () {
                    return {
                    	
                        "btn btn-xs btn-danger icon-trash": true
                    };
                },
                click: function (row) {
                    $scope.delObj = row;
                    $scope.entityDel._openModal(row);
                }
            }
        ];
        $scope.$watch('$viewContentLoaded', function () {
            $scope.page.refreshTo(1);
            /**获取七牛云文件上传组件实例*/
            $scope.qnNgObj = {};
            $scope.qnNgObj.status = {
                firstPick: true, againPick: false, upSuccess: false,
                changeStatus: function (f, a, u) {
                    $scope.qnNgObj.status.firstPick = f;
                    $scope.qnNgObj.status.againPick = a;
                    $scope.qnNgObj.status.upSuccess = u;
                }
            };
            $scope.qnUpInit = function () {//新增
                $scope.qnUp = uploader.getUploader($scope,{"pickfiles":"pickfiles","container":"container"},
                    function (resultFile) {
                        $scope.qnFile = resultFile;//文件上传成功后保存在angularjs的作用域中
                        console.log("文件外链: " + $scope.qnFile);
                });
            };
            $scope.qnUp1Init = function () {//编辑
                $scope.qnUp1 = uploader.getUploader($scope,{"pickfiles":"pickfiles1","container":"container1"},
                    function (resultFile) {
                        $scope.qnFile1 = resultFile;//文件上传成功后保存在angularjs的作用域中
                        console.log("文件外链: " + $scope.qnFile1);
                    });
            };
        });
        /**
         * 操作
         */
        $scope.entity = entity.getEntity(
            {	 
            	avatar: "",
                username: "",
                password: "",
                realname: "",
                age:0,
                sex:"",
                address:"",
                phone:"",   
                role: ""
            }, {
                username: {},
                password: {},
                realname: {},
                address:{},
                phone: {},
            },  function () {
                console.log("opened!");
                if($scope.qnUp == "undefined" || $scope.qnUp == null){
                    $scope.qnUpInit();
                }
                $scope.addrole = "user";
                $scope.addsex = "男";
                $scope.qnNgObj.status.changeStatus(true, false, false);
                $("#imgPrev").attr("src", "");
            },function () {
               console.log("submited!");
                if($scope.qnFile !== null && $scope.qnFile !== "undefined"){
                    $scope.entity.entity.avatar = $scope.qnFile;
                }
                console.log($scope.entity.entity.avatar);
                console.log($("#selectRole").val());
                ajax.ajax("/user/addOneUser", "GET", {
                        username: $scope.entity.entity.username,
                        password: $scope.entity.entity.password,
                        realname:$scope.entity.entity.realname,
                        age:$scope.entity.entity.age,
                        sex:$("#selectSex").val().toString(),
                        address:$scope.entity.entity.address,
                        phone:$scope.entity.entity.phone,
                        avatar: $scope.entity.entity.avatar,
                        role: $("#selectRole").val().toString().substring(7)
                        /* tel: $scope.entity.entity.tel,
                        email: $scope.entity.entity.email */
                    }).success(function (data) {
                        console.log(data);
                        if(data.success){
                            $scope.entity._success();
                            $scope.page.refresh();
                        }else {
                            alert(data.message);
                        }
                    }).error(function (data) {
                        console.log(data);
                        $scope.entity._error();
                    });
            }, "modal", null);
        $scope.entityEdit = entity.getEntity(
            {
                username: "",
                avatar: "",
                phone: "",
                role: "",
                address: ""
            }, {
                phone: {},
                address: {}
            }, function () {
                console.log("opened!");
                /*if($scope.qnUp == "undefined" || $scope.qnUp == null){
                    $scope.qnUpInit();
                }
                $scope.addrole = "user";
                $scope.qnNgObj.status.changeStatus(true, false, false);
                $("#imgPrev").attr("src", "");*/
                $scope.entityEdit.entity.phone = $scope.editObj.phone;
                $scope.entityEdit.entity.address = $scope.editObj.address;
            }, function () {
                ajax.ajax("/user/updateOneUser", "GET", {
                    id: $scope.editObj.id,
                    username: $scope.editObj.username,
                    address: $scope.entityEdit.entity.address,
                    phone: $scope.entityEdit.entity.phone,
                    avatar:$scope.editObj.avatar
                }).success(function (data) {
                    console.log(data);
                    if(data.success){
                        $scope.entityEdit._success();
                        alert("修改成功");
                        $scope.page.refresh();
                    }else {
                        alert(data.message);
                    }
                }).error(function (data) {
                    console.log(data);
                    $scope.entityEdit._error();
                });
            }, "modal-edit", {});
             $scope.entityDel = entity.getEntity(
            {
               id:0
            }, {
                
            }, function () {
                console.log("opened!");
            }, function () {
                ajax.ajax("/user/deleteOneUser", "GET", {
                    id: $scope.delObj.id,
                }).success(function (data) {
                    console.log(data);
                    if(data.success){
                        $scope.entityDel._success();
                        alert("删除成功");
                        $scope.page.refresh();
                    }else {
                        alert(data.message);
                    }
                }).error(function (data) {
                    console.log(data);
                    $scope.entityDel._error();
                });
            }, "modal-del", {});
    });
</script>
</body>
</html>
