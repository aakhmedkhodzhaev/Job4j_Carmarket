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

    <script>
        function validateLogin() {
            if (document.getElementById("loginAuth").value == '') {
                alert("")
                return false;
            }
            if (document.getElementById("pwd").value == '') {
                alert("")
                return false;
            }
            return true;
        }

        function showData(filter) {
            $.ajax("./", {
                method: "get",
                data: {
                    command: "get_all",
                    filter: filter
                },
                complete: function (data) {
                    var items = JSON.parse(data.responseText);

                    var result = "<thead>\n"
                        + "<tr>\n"
                        + "   <th>№</th>\n"
                        + "   <th>Дата</th>\n"
                        + "   <th>Изображение</th>\n"
                        + "   <th>Город</th>\n"
                        + "   <th>Описание</th>\n"
                        + "   <th>Цена</th>\n"
                        + "   <th>Год выпуска</th>\n"
                        + "</tr>\n"
                        + "</thead>\n"
                        + "<tbody>\n";
                    var index = 1;

                    for (var i = 0; i < items.length; i++) {

                        var item = items[i];
                        result += "<tr>\n";
                        result += "<td style=\"width: 2%;vertical-align: middle\">" + index++ + "</td>\n";
                        result += "<td style=\"width: 170px;vertical-align: middle\">"
                            + timeConverter(item.public_date) + "</td>\n";
                        result += "<td style=\"width: 150px;vertical-align: middle\"><img id=\"picture\" " +
                            "name=\"picture\" style=\"max-width: 150px\"\n"
                            + (item.photoname == ''
                                ?
                                " src=\"\"\n"
                                :
                                " src=\"image_upload/" + item.filename + "\"\n") +
                            " class=\"rounded mx-auto d-block\" alt=\"\"></td>\n";
                        result += "<td style=\"width: 2%;vertical-align: middle\">" + item.market.description + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.price + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.years + "</td>\n";
                        result += "</tr>\n";
                    }
                    result += "</tbody>\n";
                    document.getElementById("table").innerHTML = result;
                    document.getElementById("table").hidden = (items.length == 0);
                }
            })
        };
        $(
            showData()
        )
    </script>
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
<div class="container-left" style="background-color:lightgray;padding:10px">
    <div class="container" style="padding-top: 20px; padding-bottom: 20px">
        <form>
            <div class="form-group">
                <label for="cbMark"><b>Марка</b></label>
                <select class="form-control" id="cbMark" name="cbMark">
                </select>
            </div>
            <div class="form-group form-check">
                <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" id="today"><b>За посление сутки</b>
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