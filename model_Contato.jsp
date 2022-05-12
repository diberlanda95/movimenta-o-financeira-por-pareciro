<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@ page import="java.util.*" %>
        <%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
            <%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
                <html lang="pt-br">
                <meta charset="UTF-8">

                <style>
                    body {
                        background-color: #ddd;
                    }

                    #customers {
                        font-family: Arial, Helvetica, sans-serif;
                        border-collapse: collapse;
                        width: 100%;
                    }

                    #customers td,
                    #customers th {
                        border: 1px solid #ddd;
                        padding: 8px;
                        text-align: center;
                    }

                    #customers tr:nth-child(even) {
                        background-color: #f2f2f2;
                    }

                    #customers tr:hover {
                        background-color: #ddd;
                    }

                    #customers th {
                        padding-top: 12px;
                        padding-bottom: 12px;
                        text-align: center;
                        background-color: #06d6a0;
                        color: white;
                    }

                    #customers thead {
                        padding-top: 12px;
                        padding-bottom: 12px;
                        text-align: center;
                        background-color: #06d6a0;
                        color: white;
                    }

                    .center {
                        text-align: center;
                    }

                    button {
                        display: inline-block;
                        padding: 12px;
                        font-size: 12px;
                        cursor: pointer;
                        text-align: center;
                        text-decoration: none;
                        outline: none;
                        color: yellow;
                        background-color: #06d6a0;
                        border: none;
                        border-radius: 15px;
                        box-shadow: 0 5px dimgrey;
                    }

                    .button:hover {
                        background-color: chartreuse;
                        color: red;
                    }

                    .button:focus {
                        background-color: #f53643;
                        text-decoration: none;
                        box-shadow: 0 5px #f53643;
                    }

                    .button:active {
                        background-color: #06d6a0;
                        box-shadow: 0 5px yellow;
                        transform: translateY(4px);
                    }

                    div.sticky {
                        position: -webkit-sticky;
                        position: sticky;
                        top: 0;
                        padding: 5px;
                        background-color: #cae8ca;
                        border: 2px solid #4CAF50;
                    }

                    div.fixed {
                        overflow-y: auto;
                        height: 260px;
                    }

                    div.fixed thead th {
                        position: sticky;
                        top: 0;
                    }
                </style>

                <head>
                    <title>HTML5 Component</title>
                    <link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/contatoCSS.css">
                    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


                    <snk:load /> <!-- essa tag deve ficar nesta posição -->
                </head>

                <body>

                    <snk:query var="contatos">
                        SELECT

                        FIN.NUFIN
                        ,CAB.NUNOTA
                        ,TO_CHAR(FIN.DTVENCINIC, 'DD/MM/YYYY') AS VENCIMENTO
                        ,TO_CHAR(FIN.DHBAIXA, 'DD/MM/YYYY') AS BAIXA
                        ,FIN.CODNAT
                        ,FIN.CODCENCUS
                        ,TO_CHAR(CAB.VLRNOTA, 'L9G999G990D99') AS VLRNOTA
                        ,TO_CHAR(FIN.VLRBAIXA, 'L9G999G990D99') AS VLRBAIXA
                        ,TO_CHAR(CAB.DTENTSAI, 'DD/MM/YYYY') AS DTSAI
                        ,PAR.CODPARC
                        ,PAR.NOMEPARC
                        ,PRO.CODPROD
                        ,PRO.DESCRPROD
                        FROM TGFFIN FIN,
                        TGFCAB CAB,
                        TGFITE ITE,
                        TGFPAR PAR,
                        TGFPRO PRO


                        WHERE FIN.NUNOTA = CAB.NUNOTA
                        AND CAB.NUNOTA = ITE.NUNOTA
                        AND CAB.CODPARC = PAR.CODPARC
                        AND ITE.CODPROD = PRO.CODPROD
                        AND PAR.CODPARC = :CODPARC
                        AND CAB.DTENTSAI BETWEEN :PERIODO.INI AND :PERIODO.FIN
                        ORDER BY CAB.DTENTSAI ASC

                    </snk:query>

                    <tr></tr>
                    <div class="container" id="customers">
                        <div class="sticky">
                            <p>Digite algo no campo de entrada para procurar:</p>
                            <input class="form-control" id="myInput" name="myInput" type="text" placeholder="Procurar..."><br>
                            <button class="button" class="btn btn-primary btn-block" onclick="abrirfinanceiro()"><i
                                    class="mdi mdi-plus"></i>Abrir Financeiro</button>
                            <button class="button" class="btn btn-primary btn-block"
                                onclick="exportTableToExcel('idDaTabela')"> Exportar para Excel</button><br>
                        </div>
                        <div class="fixed">
                            <table id="idDaTabela" class="table table-bordered table-striped">
                                <thead id="customers">
                                    <tr>
                                        <th>N. Financeiro</th>
                                        <th>N. Nota</th>
                                        <th>Dt. Vencimento</th>
                                        <th>Dt. Baixa</th>
                                        <th>Cod. Natureza</th>
                                        <th>Cod. Centro Resultado</th>
                                        <th>Vlr. Nota</th>
                                        <th>Vlr. Baixa</th>
                                        <th>Dt. Entrada/Saida</th>
                                        <th>Cod. Produto</th>
                                        <th>Produto</th>
                                        <th>OBS</th>
                                    </tr>
                                </thead>
                                <c:forEach items="${contatos.rows}" var="row">
                                    <tbody id="myTable">
                                        <tr id="idTr" onmouseover="style.color='blue'" onmouseout="style.color='black'">
                                            <td>
                                                <c:out value="${row.NUFIN}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.NUNOTA}" />
                                            </td>
                                            <td id="dtvencinic">
                                                <c:out value="${row.VENCIMENTO}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.BAIXA}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.CODNAT}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.CODCENCUS}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.VLRNOTA}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.VLRBAIXA}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.DTSAI}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.CODPROD}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.DESCRPROD}" />
                                            </td>
                                            <td><input type="text" placeholder="Observação"><button class="button"
                                                    class="btn btn-primary btn-block" ng-click="()"><i
                                                        class="mdi mdi-plus"></i>Editar</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </c:forEach>
                            </table>
                        </div>
                    </div>
                    <script>
                        $(document).ready(function () {
                            $("#myInput").on("keyup", function () {
                                var value = $(this).val().toLowerCase();
                                $("#myTable tr").filter(function () {
                                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                                });
                            });
                        });

                        function exportTableToExcel(idDaTabela, filename = '') {
                            var downloadLink;
                            var dataType = 'application/vnd.ms-excel';
                            var tableSelect = document.getElementById(idDaTabela);
                            var tableHTML = tableSelect.outerHTML.replace(/ /g, '%20');

                            // Especificar o nome do arquivo

                            filename = filename ? filename + '.xls' : 'excel_data.xls';

                            // Criar download do link
                            downloadLink = document.createElement("a");
                            document.body.appendChild(downloadLink);

                            if (navigator.msSaveOrOpenBlob) {
                                var blob = new Blob(['\ufeff', tableHTML], {
                                    type: dataType
                                });
                                navigator.msSaveOrOpenBlob(blob, filename);

                            } else {

                                //Criar um link para o arquivo
                                downloadLink.href = 'data:' + dataType + ', ' + tableHTML;

                                // Configuração para o Arquivo do Nome
                                downloadLink.download = filename;

                                downloadLink.click();
                            }
                        }

    
                        jQuery(function ($) {
                            $("#dtvencinic").mask("dd/mm/aaaa");

                        });

                        function abrirfinanceiro(){
                            var valor = document.getElementById("myInput").value;
                            openApp('br.com.sankhya.com.mov.CentralNotas', valor);
						
                        }

                    </script>
                </body>

                </html>