<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" isELIgnored="false" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%@ page import="java.util.*" %>
		<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
			<%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
				<html>
					<meta charset="UTF-8">
				<style>
					#customers {
						font-family: Arial, Helvetica, sans-serif;
						border-collapse: ;
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

					button:hover {
						background-color: chartreuse;
						color: red;
					}

					button:focus {
						background-color: #f53643;
						text-decoration: none;
						box-shadow: 0 5px #f53643;
					}

					button:active {
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

					h3 {
						background-color: #06d6a0;
						color: #f2f2f2;
						text-align: center;
					}
				</style>

				<head>
					<title>HTML5 Component</title>
					<link rel="stylesheet" type="text/css" href="${BASE_FOLDER}/css/parceiroCSS.css">
					<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
					<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
					<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
					<snk:load /> <!-- essa tag deve ficar nesta posição -->

					<script type='text/javascript'>
						function abrirContatos(CODPARC) {
							var params = { 'CODPARC': CODPARC };
							openApp('br.com.sankhya.core.cad.parceiros', params);
						}

					</script>

				</head>

				<body>


					<snk:query var="parceiros">
						select * from TGFPAR where CODPARC IN (:CODPARC) order by CODPARC asc
					</snk:query>
					<tr></tr>
					<div class="container" id="customers">
						<table border="1">
							<caption>
								<h3>MOVIMENTAÇÃO FINANCEIRA POR PARCEIRO</h3>
							</caption>
							<tr>
								<th>Código</th>
								<th>Nome do Parceiro</th>
								<th> </th>
								<th> </th>
							</tr>
							<c:forEach items="${parceiros.rows}" var="row">
								<tr>
									<td>
										<c:out value="${row.CODPARC}" />
									</td>
									<td>
										<c:out value="${row.NOMEPARC}" />
									</td>
									<td>
										<button onclick="javascript:abrirContatos( ${row.CODPARC} )">Ver
											contatos</button>
									</td>
									<td>

									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</body>

				</html>