<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>${param.title}</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/Style/style.css">
</head>
<body>
    <div class = "globalWrapper">
    <div class="headerWrapper">
        <div class="header">
            <a href="<c:url value="/gallery"/>">
                <img src="${pageContext.request.contextPath}/Images/logo.png"/>
            </a>
        </div>
    </div>

    <div class="content">