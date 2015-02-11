<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%--<Set proper title of the header.jsp>--%>
<c:import url="header.jsp">
    <c:param name="title" value="Moustache Gallery"/>
</c:import>

    <%--<For the database to be available, add changes to your Tomcat conf files>--%>
    <sql:setDataSource var="ds" dataSource="jdbc/web_app"/>
    <sql:query var="results" dataSource="${ds}" sql="SELECT * FROM moustache_pictures ORDER BY average_ranking DESC"/>

    <%--<Displaying the table with all images in the gallery, ordered by rank acc to sql query>--%>
    <c:set var="tableWidth" value="5"/>

    <table class="images">
    <c:forEach var="image" items="${results.rows}" varStatus="row">

        <c:if test="${row.index % tableWidth == 0}">
            <tr>
        </c:if>

        <c:set var="imageName" scope="page" value="${image.file_name}.${image.file_extention}"/>

        <td>
            ${image.img_descr}
            <a href="<c:url value="/gallery?action=image&imageId=${image.id}"/>">
                <p><img src="${pageContext.request.contextPath}/Images/${imageName}"/></p>
            </a>
        </td>

        <c:if test="${row.index + 1 % tableWidth == 0}">
            </tr>
        </c:if>
    </c:forEach>
    </table>

<c:import url="footer.jsp"/>