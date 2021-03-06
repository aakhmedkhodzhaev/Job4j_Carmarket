<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Car Market | Home</title>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" href="#">CarMarket</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item dropdown" id="menu_personal_area">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                Личный кабинет
            </a>
            <div class="dropdown-menu">
                <a id="menuLogin" class="dropdown-item" href="auth.do">Авторизация</a>
                <a id="menuRegister" class="dropdown-item" href="reg.do">Регистрация</a>
                <a id="menuNotes" hidden="true" class="dropdown-item" onclick="showMyNotes();">Мои объявления</a>
                <a id="menuLogout" hidden="true" class="dropdown-item" onclick="doLogout();">Выход</a>
            </div>
        </li>
        <li hidden class="nav-item">
            <a class="nav-link" href="#">Поиск</a>
        </li>
    </ul>
</nav>
<div class="container-left" style="background-color:white;padding:10px">
    <div class="container" style="padding-top: 20px; padding-bottom: 20px">
        <form>
            <div class="form-group">
                <label for="cbMark"><b>Марка</b></label>
                <select class="form-control" id="cbMark" name="cbMark">
                </select>
            </div>
            <div class="form-group form-check">
                <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" id="today"><b>За посление 24 часа</b>
                </label>
            </div>
            <div class="form-group form-check">
                <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" id="pics"><b>С фотографией</b>
                </label>
            </div>
            <button type="button" class="btn btn-primary" style="float:left;
                                       margin-right:10px" onclick="showData(getFilter());">Поиск
            </button>
            <button type="button" onclick="resetFilter();" class="btn btn-danger" style="float:right">Сбросить</button>
            <br>
        </form>
    </div>
</div>
<table class="table table-striped" id="table">
</table>
</body>
</html>