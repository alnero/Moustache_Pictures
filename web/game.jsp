<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%--<Set proper title of the header.jsp>--%>
<c:import url="header.jsp">
    <c:param name="title" value="Moustache Game"/>
</c:import>

    <%--<For the database to be available, add changes to your Tomcat conf files>--%>
    <sql:setDataSource var="ds" dataSource="jdbc/web_app"/>
    <sql:query var="results"
            dataSource="${ds}"
            sql="SELECT * FROM moustache_pictures WHERE id >= (SELECT FLOOR( MAX(id) * RAND()) FROM moustache_pictures ) LIMIT 3;"
            scope="session"/>

    <%--<Starting new game win/lost params set to 0>--%>
    <c:if test="${param.action == 'game'}">
        <c:set var="win" value="${0}" scope="session"/>
        <c:set var="lost" value="${0}" scope="session"/>
    </c:if>

    <%--<Get random number of the image to be guessed>--%>
    <jsp:useBean id="random" class="java.util.Random" scope="page"/>
    <c:set var="randomNumber" value="${random.nextInt(3)}" scope="page"/>

    <%--<Create a table with three images and one description>--%>
    <c:set var="tableWidth" value="3"/>

    <table class="images">
        <c:forEach var="image" items="${sessionScope.results.rows}" varStatus="row">

            <c:if test="${row.index % tableWidth == 0}">
                <tr>
            </c:if>

            <c:set var="imageName" scope="page" value="${image.file_name}.${image.file_extention}"/>

            <td style="padding: 30px; " >
                <div>
                    <%--<The image itself is a form to be submitted>--%>
                    <form action='<c:url value="/gallery" />' method="post">
                        <%--<Game continues as long as user chooses images>--%>
                        <input type="hidden" name="action" value="playMore">
                        <%--<Send id of the image to be guessed (the winning one)>--%>
                        <input type="hidden" name="idValueToCheck" value="${results.rows[randomNumber].id}">
                        <%--<Send id of the image choosen by user>--%>
                        <input type="image" src="${pageContext.request.contextPath}/Images/${imageName}"
                               name="imageId" value="${image.id}">
                    </form>
                </div>
            </td>

            <c:if test="${row.index + 1 % tableWidth == 0}">
                </tr>
            </c:if>
        </c:forEach>
    </table>

    <%--<Compare submitted ids and add proper win/lost points. If not submitted set them to 0>--%>
    <c:if test="${param.action == 'playMore'}">
        <c:if test="${param.idValueToCheck == param.imageId}">
            <c:set var="win" value="${sessionScope.win + 1}" scope="session"/>
        </c:if>
        <c:if test="${param.idValueToCheck != param.imageId}">
            <c:set var="lost" value="${sessionScope.lost + 1}" scope="session"/>
        </c:if>
    </c:if>

    <br/>

    <%--<Randomly choosen description for the one of three images>--%>
    <h2>${results.rows[randomNumber].img_descr}?</h2>

    <br/>

    <%--<Score table>--%>
    <span class="greenText">${sessionScope.win}</span>
        <span style="font-size: 26px">:</span>
    <span class="redText">${sessionScope.lost}</span>

<c:import url="footer.jsp"/>