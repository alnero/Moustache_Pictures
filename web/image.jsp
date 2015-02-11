<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%--<Set proper title of the header.jsp>--%>
<c:import url="header.jsp">
    <c:param name="title" value="Moustache Image"/>
</c:import>

    <%--<For the database to be available, add changes to your Tomcat conf files>--%>
    <sql:transaction dataSource="jdbc/web_app">

        <sql:query var="results" sql="SELECT * FROM moustache_pictures WHERE id = ?">
            <sql:param>${param.imageId}</sql:param>
        </sql:query>

        <%--<Display image with actual rank>--%>
        <c:set var="image" scope="page" value="${results.rows[0]}"/>
        <c:set var="imageName" scope="page" value="${image.file_name}.${image.file_extention}"/>
        <c:set var="averageRanking" value="${image.average_ranking}"/>

        <%--<Compute and set new rank if user votes>--%>
        <c:if test="${param.action == 'rate'}">
            <c:set var="newRanking" scope="page" value="${image.ranking + 1}"/>
            <c:set var="newAverageRanking" scope="page"
                   value="${(image.average_ranking * image.ranking + param.rating) / (image.ranking + 1)}"/>
            <c:set var="averageRanking" value="${newAverageRanking}"/>

            <sql:update sql="update moustache_pictures set ranking=?, average_ranking=? where id=?">
                <sql:param>${newRanking}</sql:param>
                <sql:param>${newAverageRanking}</sql:param>
                <sql:param>${param.imageId}</sql:param>
            </sql:update>
        </c:if>

    </sql:transaction>

    <h2>${fn:toUpperCase(image.img_descr)}</h2>

    <p/><p/>

    <div class="crop">
        <p><img src="${pageContext.request.contextPath}/Images/${imageName}"/></p>
    </div>

    <form action="<c:url value="/gallery" />" method="post">
        <input type="hidden" name="action" value="rate">
        <input type="hidden" name="imageId" value="${image.id}">
        <table class="content" style="text-align: left;">
            <tr>
                <td><input type="radio" name="rating" value="3">3 - Excellent!</td>
            </tr>
            <tr>
                <td><input type="radio" name="rating" value="2">2 - Good!</td>
            </tr>
            <tr>
                <td><input type="radio" name="rating" value="1">1 - OK</td>
            </tr>
            <tr>
                <td style="text-align: center"><input type="submit" value="Rate"></td>
            </tr>
        </table>
    </form>

    <%--<Rank is shown up to one decimal point>--%>
    <h3 style="color: red">
        <fmt:formatNumber value="${averageRanking}" maxFractionDigits="1"/>
    </h3>

<c:import url="footer.jsp"/>