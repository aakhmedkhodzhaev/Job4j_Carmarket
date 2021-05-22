<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <title>Car Market | Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script>
        function doLogout() {
            window.location = "index.jsp";
        }
    </script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" id="navbar" href="#">Car Market</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" onclick="gotoMainPage();">Главная страница</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" onclick="doLogout()">Выход</a>
        </li>
    </ul>
</nav>

<div class="container-left" style="background-color:lightgray;padding:10px">

    <div class="container" style="padding-top: 20px; padding-bottom: 20px">
        <form action="/carseller/add_data" method="post" enctype="multipart/form-data">
            <table width="100%" cellspacing="10px">
                <tr>
                    <td>
                        <table width="100%">
                            <tr>
                                <td><b>Наименование Объявления:</b></td>
                            </tr>
                            <tr>
                                <td>
                                    <input class="form-control" id="descriptions" name="descriptions"/>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Город</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cbCity" name="cbCity">
                                    </select>
                                    <input type="text" style="width:100%" id="edCity" name="edCity" hidden/>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success" id="City" onclick="btAddSelClick();"
                                            value="0">Добавить
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Тип</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cbType" name="sellist1" onchange="changeType();">
                                    </select>
                                    <input type="text" style="width:100%" id="edType" name="edType" hidden/>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success" id="Type" onclick="btAddSelClick();"
                                            value="0">Добавить
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Марка</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cbMark" name="cbMark">
                                    </select>
                                    <input type="text" style="width:100%" id="edMark" name="edMark" hidden/>
                                </td>
                                <td style="width:100px">
                                    <button type="button" class="btn btn-success" id="Mark" onclick="btAddSelClick();"
                                            value="0">Добавить
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Модель</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cbModel" name="cbModel">
                                    </select>
                                    <input type="text" style="width:100%" id="edModel" name="edModel" hidden/>
                                </td>
                                <td style="width:100px">
                                    <button type="button" class="btn btn-success" id="Model" onclick="btAddSelClick();"
                                            value="0">Добавить
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>Кузов</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cbBody" name="cbBody">
                                    </select>
                                    <input type="text" style="width:100%" id="edBody" name="edBody" hidden/>
                                </td>
                                <td style="width:100px">
                                    <button type="button" class="btn btn-success" id="Body" onclick="btAddSelClick();"
                                            value="0">Добавить
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <table>
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td><b>Год выпуска</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="number" id="edYear" name="edYear">
                                                        </td>
                                                    </tr>
                                                </table>

                                            </td>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td><b>Цена</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input type="number" id="edPrice" name="edPrice"
                                                                   width="70px">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>

                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br>
                                    <input type="file" id="edFile" name="edFile">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <br>
                                    <button type="submit" class="btn btn-primary" style="float:left;
                                       margin-right:10px" onclick="return validate();">Принять
                                    </button>
                                </td>
                                <td>
                                    <br>
                                    <button type="button" onclick="doCancel();" class="btn btn-danger"
                                            style="float:right">Отмена
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</div>

<table class="table table-striped" id="table">
</table>


</body>
</html>