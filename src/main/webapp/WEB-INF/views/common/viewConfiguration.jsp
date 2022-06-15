<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL 관련 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<!-- springframework 관련 -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!-- Device 환경설정 -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- path -->
<c:set var="path" value="${pageContext.request.contextPath }" />

<!-- JQuery -->
<script src="${path}/js/jquery.js"></script>

<!-- 부트스트랩 CSS/JS -->
<script src="${path}/js/bootstrap.min.js"></script>
<link href="${path}/css/bootstrap.min.css" rel="stylesheet">

<!-- 자체제작 CSS (부트스트랩에 없는 자체제작 css는 앞에 vf_가 붙어 있습니다.) -->
<link rel="stylesheet" href="${path}/css/header.css?ver=2" />

<!-- 구글폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Nanum+Gothic&display=swap" rel="stylesheet">


