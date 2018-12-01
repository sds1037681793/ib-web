<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ page import="org.apache.shiro.authc.ExcessiveAttemptsException"%>
<%@ page import="org.apache.shiro.authc.IncorrectCredentialsException"%>
<%@ page import="com.rib.base.util.StaticDataUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<% String systemName = StaticDataUtils.getSystemName(); %>
<%
	if (org.apache.shiro.SecurityUtils.getSubject().getPrincipal() != null) {
	    response.sendRedirect(request.getContextPath() + "/main");
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>智慧园区大数据平台</title>
    <link rel="stylesheet" href="${ctx}/static/css/base/common.css">
    <link rel="stylesheet" href="${ctx}/static/css/base/login.css">
    <script src="${ctx}/static/component/jquery/jquery-1.9.1.min.js"></script>
    
</head>
<body>
    <img src="${ctx}/static/img/base/login_bg.jpg" class="img_bg">
    <main class="main-body">
        <div class="login-wrap clearfix">
            <p class="declaration">
                THE WISDOM OF THE
                <br>
                PARK BIG DATA
                <br>
                PLATFORM
            </p>
            <h1 class="siteName">智慧园区大数据平台</h1>
            <form class="login_form clearfix" name="" id="loginForm" action="${ctx}/login" method="post">
                
                    <%
                        String error = (String) request.getAttribute(FormAuthenticationFilter.DEFAULT_ERROR_KEY_ATTRIBUTE_NAME);
                        if(error != null){
                    %>
                        <div>
                            <div class="alert alert-error input-medium controls" style="margin-left: 80px; margin-bottom: 5px; line-height: 17px;">
                                登录失败，请重试
                            </div>
                        </div>
                    <%
                        } else {
                    %>
                        <!-- <div style="height: 40px;"></div> -->
                    <%
                        }
                    %>
                
                <div class="userInput userName">
                    <i class="icon icon-loginName i-block"></i>
                    <input class="text-blue" name="username" type="text" required>
                </div>
                <div class="userInput password">
                    <i class="icon icon-password i-block"></i>
                    <input class="text-blue" name="password" type="password" required>
                </div>
                <div class="checkbox mt20 fs14">
                    <label for="i_remember" class="text-blue">
                        <input class="hide" type="checkbox" name="rememberMe" id="i_remember"><i class="nochecked i-block v-middle"></i> 记住密码
                    </label>
                </div>
                <div class="checkbox fs14">
                    <label for="i_forget" class="text-blue">
                        <input class="hide" type="checkbox" name="isForget" id="i_forget"><i class="nochecked i-block v-middle"></i> 忘记密码?
                    </label>
                    <a href="#" class="text-blue link_forget"> 点这里</a>
                </div>
                <input class="mt20 btn btn-login-submit pull-right" type="submit" value="登录">
            </form>
        </div>
        
    </main>
</body>
<script type="text/javascript">
var ctx = "${ctx}";
var locationUrl = window.location.host;
</script>
<script src="${ctx}/static/js/base/login.js"></script>


</html>