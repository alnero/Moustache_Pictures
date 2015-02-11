<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--<Set proper title of the header.jsp>--%>
<c:import url="header.jsp">
    <c:param name="title" value="Upload Image"/>
</c:import>

    <text style="color:#ff7f50"> Click little moustache to upload your png image to server... </text>


    <div align="center" style="margin-top: 20px">
        <%--<Choose file dialog is hidden behind the image>--%>
        <form action="${pageContext.request.contextPath}/uploader" method="post" enctype="multipart/form-data">
            <div class="image-upload">
                <label for="file-input">
                    <img width=60 src="${pageContext.request.contextPath}/Images/upload.png"/>
                </label>

                <%--<Choosing a file automatically submits the form, refer to onchange attribute>--%>
                <input id="file-input" type="file" name="file" onchange="form.submit()">
            </div>
        </form>
    </div>

    <hr width="50%"/>
    <br/>

    <text style="color:#ff7f50"> ${sessionScope.uploadResultMsg} </text>
    <br/>
    <br/>

    <%--<Dispalay the uploaded image, in order to work properly edit Run/Debug Conf of Intellij Idea>--%>
    <c:if test="${sessionScope.uploadFileName != null}">
        <div class="images">
            <img src="/images/${sessionScope.uploadFileName}">
        </div>
    </c:if>

    <br/>
    <br/>

<c:import url="footer.jsp"/>
