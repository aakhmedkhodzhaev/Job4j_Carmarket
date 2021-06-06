<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 09.05.2021
  Time: 23:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="cp1251" %>
<html lang="en">
<head>
    <title>Car Market | Home</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        function loadCities() {
            $.ajax("./ajax", {
                    method: "get",
                    data: {operation: "cities"},
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                            }
                            document.getElementById("cmCity").innerHTML = result;
                            console.log(data);
                        }
                    }
                }
            )
        }

        function loadMark() {
            $.ajax("./ajax", {
                    method: "get",
                    data: {operation: "brand"},
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                            }
                            document.getElementById("cmMark").innerHTML = result;
                            console.log(data);
                        }
                    }
                }
            )
        }

        function loadModel() {
            var id = $('#cmMark').val();
            console.log(id);
            $.ajax("./ajax", {
                    method: "get",
                    data: {operation: "model"},
                    id: id,
                    complete: function (data) {
                        if (data.responseText.length > 0) {
                            var items = JSON.parse(data.responseText);
                            var result = "";
                            for (var i = 0; i < items.length; i++) {
                                var item = items[i];
                                result += "<option value=" + item.id + ">" + item.name + "</option>\n";
                            }
                            document.getElementById("cmModel").innerHTML = result;
                            console.log(data);
                        }
                    }
                }
            )
        }

        function doLogout() {
            window.location = "index.jsp";
        }

        loadCities();
        loadMark();
        loadModel();
    </script>
</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" id="navbar" href="#">Car Market</a>

    <!-- Links -->
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" onclick="gotoMainPage();">������� ��������</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" onclick="doLogout()">�����</a>
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
                                <td><b>������������ ����������:</b></td>
                            </tr>
                            <tr>
                                <td>
                                    <input class="form-control" id="descriptions" name="descriptions"/>
                                </td>
                            </tr>
                            <tr>
                                <td><b>�����</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cmCity" name="cmCity">
                                    </select>
                                    <input type="text" style="width:100%" id="iCity" name="iCity" hidden/>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success" id="City" onclick="btAddSelClick();"
                                            value="0">��������
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>�����</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cmMark" name="cmMark">
                                    </select>
                                    <input type="text" style="width:100%" id="iMark" name="iMark" hidden/>
                                </td>
                                <td style="width:100px">
                                    <button type="button" class="btn btn-success" id="Mark" onclick="btAddSelClick();"
                                            value="0">��������
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><b>������</b></td>
                            </tr>
                            <tr>
                                <td width="100%">
                                    <select class="form-control" id="cmModel" name="cmModel">
                                    </select>
                                    <input type="text" style="width:100%" id="iModel" name="iModel" hidden/>
                                </td>
                                <td style="width:100px">
                                    <button type="button" class="btn btn-success" id="Model" onclick="btAddSelClick();"
                                            value="0">��������
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
                                                        <td><b>��� �������</b></td>
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
                                                        <td><b>����</b></td>
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
                                       margin-right:10px" onclick="return validate();">�������
                                    </button>
                                </td>
                                <td>
                                    <br>
                                    <button type="button" onclick="doCancel();" class="btn btn-danger"
                                            style="float:right">������
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