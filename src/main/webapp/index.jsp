<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Car Market</title>
</head>
<body>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!-- Optional JavaScript -->
<!-- jQuery,  Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<!-- get Items From db -->
<script>
    setInterval(getAllMarket, 325000);

    <!-- get All Ads-->
    function getAllMarket() {
        var urlGetQuery = './json';
        $.ajax(urlGetQuery).done(function (data) {
            var refreshBody = '';
            console.log(data);
            var json = JSON.parse(data);
            for (item in json) {
                refreshBody += '<tr><td>' + json[item].id.toString() +
                    '</td><td>' + json[item].name +
                    '</td><td>' + json[item].city +
                    '</td><td>' + json[item].price.toString() +
                    '</td><td><img src="<%=basePath %>load?photo="' + json[item].photo + '\"/>' + json[item].photo +
                    '</td><td>' + json[item].description +
                    '</td><td>' + json[item].created.toString() +
                    '</td><td>' + json[item].user +
                    '</td>';
                refreshBody += '</tr>';
            }
            $("#All_Ads").html(refreshBody);
        })
    }

    $(
        getAllMarket()
    )
</script>

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
<br>
<br>
<div class="row pt-3">
    <table class="table table-striped">
        <thead>
        <tr>
            <th width="25px">№</th>
            <th width="155px">Наименование</th>
            <th width="125px">Город</th>
            <th width="100px">Цена</th>
            <th width="150">Фотография</th>
            <th width="250px">Описание</th>
            <th width="80px">Дата</th>
            <th width="100px">Владелец</th>
        </tr>
        </thead>
        <tbody id="All_Ads">
        </tbody>
    </table>
</div>
</body>
</html>