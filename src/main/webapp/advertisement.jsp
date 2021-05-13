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

        /*
        function doLogout() {

            $.ajax("./ajax", {
                    method : "post",
                    data : {
                        command : "logout"
                    },
                    success : function() {
                        window.location = "index.jsp";
                    }
                }
            );
        }*/

        function gotoMainPage() {
            window.location = "index.jsp";
        }

        function btAddSelClick() {
            var button = document.activeElement;
            var comboBox = document.getElementById("cb" + button.id.toString());
            var edit = document.getElementById("ed" + button.id.toString());

            button.firstChild.data = "qweqwe";
            button.classList.toggle('btn-danger');
            if (parseInt(button.value, 10) == 0) {
                button.innerText = "Выбрать"
                comboBox.hidden = true;
            } else {
                button.innerText = "Добавить"
                comboBox.hidden = false;
            }
            edit.hidden = !comboBox.hidden;
            button.value = (parseInt(button.value, 10) + 1) % 2;
        }

        function loadCities() {
            $.ajax("./ajax", {
                    method: "get",
                    data: {command: "get_cities"},
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option>" + item.name + "</option>\n";
                            }
                            document.getElementById("cbCity").innerHTML = result;
                        }
                    }
                }
            )
        }

        function loadTypes() {
            $.ajax("./ajax", {
                    method: "get",
                    data: {command: "get_types"},
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option>" + item.name + "</option>\n";
                            }
                            document.getElementById("cbType").innerHTML = result;
                            changeType();
                        }
                    }
                }
            )
        }

        function changeType() {
            var cbType = document.getElementById("cbType");

            if (cbType.selectedIndex > -1) {
                $.ajax("./ajax", {
                        method: "get",
                        data: {command: "get_models", type: cbType.options[cbType.selectedIndex].text},
                        complete: function (data) {
                            if (data.responseText.length > 0) {
                                var items = JSON.parse(data.responseText);

                                var result = "";
                                for (var i = 0; i < items.length; i++) {
                                    var item = items[i];
                                    result += "<option>" + item.name + "</option>\n";
                                }
                                document.getElementById("cbModel").innerHTML = result;
                            }
                        }
                    }
                )
                $.ajax("./ajax", {
                        method: "get",
                        data: {command: "get_marks", type: cbType.options[cbType.selectedIndex].text},
                        complete: function (data) {
                            if (data.responseText.length > 0) {
                                var items = JSON.parse(data.responseText);

                                var result = "";
                                for (var i = 0; i < items.length; i++) {
                                    var item = items[i];
                                    result += "<option>" + item.name + "</option>\n";
                                }
                                document.getElementById("cbMark").innerHTML = result;
                            }
                        }
                    }
                )
                $.ajax("./ajax", {
                        method: "get",
                        data: {command: "get_bodies", type: cbType.options[cbType.selectedIndex].text},
                        complete: function (data) {
                            if (data.responseText.length > 0) {
                                var items = JSON.parse(data.responseText);


                                var result = "";
                                for (var i = 0; i < items.length; i++) {
                                    var item = items[i];

                                    console.log(item);

                                    result += "<option>" + item.name + "</option>\n";
                                }
                                document.getElementById("cbBody").innerHTML = result;

                            }
                        }
                    }
                )
            }
        }

        function validate() {

            console.log("----------------")

            var edCity = document.getElementById("edCity");
            var cbCity = document.getElementById("cbCity");
            var edType = document.getElementById("edType");
            var cbType = document.getElementById("cbType");
            var edMark = document.getElementById("edMark");
            var cbMark = document.getElementById("cbMark");
            var edModel = document.getElementById("edModel");
            var cbModel = document.getElementById("cbModel");
            var edBody = document.getElementById("edBody");
            var cbBody = document.getElementById("cbBody");
            var edYear = document.getElementById("edYear");
            var edPrice = document.getElementById("edPrice");
            var edFile = document.getElementById("edFile");

            if (edCity.hidden) edCity.value = cbCity.selectedIndex < 0 ? '' : cbCity.options[cbCity.selectedIndex].value;
            if (edType.hidden) edType.value = cbType.selectedIndex < 0 ? '' : cbType.options[cbType.selectedIndex].value;
            if (edMark.hidden) edMark.value = cbMark.selectedIndex < 0 ? '' : cbMark.options[cbMark.selectedIndex].value;
            if (edModel.hidden) edModel.value = cbModel.selectedIndex < 0 ? '' : cbModel.options[cbModel.selectedIndex].value;
            if (edBody.hidden) edBody.value = cbBody.selectedIndex < 0 ? '' : cbBody.options[cbBody.selectedIndex].value;

            console.log(edBody.value);


            if (edCity.value == '') {
                alert("Не указан город")
                return false;
            }

            if (edType.value == '') {
                alert("Не указан тип")
                return false;
            }
            if (edMark.value == '') {
                alert("Не указана марка")
                return false;
            }
            if (edModel.value == '') {
                alert("Не указана модель ")
                return false;
            }
            if (edBody.value == '') {
                alert("Не указан кузов")
                return false;
            }
            if (edYear.value == '') {
                alert("Не казан год выпуска")
                return false;
            }
            if (edPrice.value == '') {
                alert("Не указана цена")
                return false;
            }

            return true;
        }

        function doCancel() {
            window.location = "index.jsp";
        }

        function changeInactive(id) {
            $.ajax("/ajax", {
                method: "post",
                data: {command: "change_inactive", id: id},
                success: function () {
//                    showData();
                }
            });
        }

        function timeConverter(timestamp) {
            var a = new Date(timestamp);
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var year = a.getFullYear();
            var month = months[a.getMonth()];
            var date = a.getDate();
            var hour = a.getHours();
            var min = a.getMinutes();
            var sec = a.getSeconds();
            var time = date + ' ' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec;
            return time;
        }

        function doSaveData() {

            if (!validate()) return false;

            return true;
        }

        function showData() {

            $.ajax("./ajax", {
                method: "get",
                data: {
                    command: "get_user_cars"
                },
                complete: function (data) {
                    var json = JSON.parse(data.responseText);
                    if (json.data == null) return;
                    document.getElementById("navbar").text = "Car Market | Home [" + json.login + "]";
                    var result = "<thead>\n"
                        + "<tr>\n"
                        + "   <th>№</th>\n"
                        + "   <th>Неактивно</th>\n"
                        + "   <th>Дата</th>\n"
                        + "   <th>Изображение</th>\n"
                        + "   <th>Город</th>\n"
                        + "   <th>Тип</th>\n"
                        + "   <th>Марка</th>\n"
                        + "   <th>Модель</th>\n"
                        + "   <th>Кузов</th>\n"
                        + "   <th>Год выпуска</th>\n"
                        + "   <th>Цена</th>\n"
                        + "</tr>\n"
                        + "</thead>\n"
                        + "<tbody>\n";
                    var index = 1;
                    for (var i = 0; i < json.data.length; i++) {
                        var item = json.data[i];


                        result += "<tr>\n";
                        result += "<td style=\"width: 2%;vertical-align: middle\">" + index++ + "</td>\n";

                        var checked = item.inactive ? "checked" : "";

                        result += "<td class=\"text-center\" style=\"width: 10px;vertical-align: middle\"><input class=\"form-check-input\" "
                            + checked + " type=\"checkbox\" onclick='changeInactive(" + item.id + ")'>&nbsp;</td>";

                        result += "<td style=\"width: 170px;vertical-align: middle\">" + timeConverter(item.timestamp) + "</td>\n";

                        result += "<td style=\"width: 150px;vertical-align: middle\"><img id=\"picture\" name=\"picture\" style=\"max-width: 150px\"\n" +
                            (item.filename == ''
                                ?
                                "                                         src=\"\"\n"
                                :
                                "                                         src=\"image_upload/" + item.filename + "\"\n") +
                            "                                         class=\"rounded mx-auto d-block\" alt=\"\"></td>\n";

                        result += "<td style='vertical-align: middle'>" + item.city.name + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.carmodel.cartype.name + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.carmodel.carmark.name + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.carmodel.name + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.carbody.name + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.year + "</td>\n";
                        result += "<td style='vertical-align: middle'>" + item.price + "</td>\n";
                        result += "</tr>\n";
                    }
                    result += "</tbody>\n";
                    document.getElementById("table").innerHTML = result;
                    document.getElementById("table").hidden = (json.data.length == 0);

                    loadCities();
                    loadTypes();
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