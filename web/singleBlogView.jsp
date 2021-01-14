<%-- 
    Document   : testHomepage
    Created on : Dec 7, 2020, 1:05:37 PM
    Author     : kanchana
--%>

<%@page import="Model.CommentDao"%>
<%@page import="Model.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Colorlib Templates">
        <meta name="author" content="Colorlib">
        <meta name="keywords" content="Colorlib Templates">
        <title>Viewing blog...</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
        <link href="css/singleBlogView.css" rel="stylesheet" media="all">
    </head>

    <body>
        <div class="page-wrapper bg-dark p-t-100 p-b-50">
            <div class="wrapper wrapper--w900">
                <div class="card card-6">
                    <div class="card-heading">
                        <c:forEach var="tempBlog" items="${BLOGLIST}">

                            <h2 class="title">Blog Id : ${tempBlog.blogId}</h2>

                        </div>
                        <div class="card-body">
                            <div class="card-footer">

                                <div class="name">${tempBlog.date} </div>
                            </div>
                            <div class="form-row">

                                <div class="name">${tempBlog.title}</div>
                                <div class="value" > 

                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name"></div>
                                <div class="value">
                                    <div class="input-group">
                                        <img src=${tempBlog.imageURL} alt="imageurl" height="160">
                                    </div>
                                </div>
                            </div>
                            <div class="card-footer">
                                <p> ${tempBlog.body}</p>
                                <br>
                            </div>
                            <div class="card-footer">
                                <div class="addCom">
                                    <form action="CommentServlet" method="GET">
                                        <input type="hidden" name="command" value="COMMENT"/>
                                        <input type="hidden" name="blogId" value='${tempBlog.blogId}'/>
                                        <input type="hidden" name="Author" value='${tempBlog.author}'/>
                                        <input type="hidden" name="PhotoUrl" value='${tempBlog.imageURL}'/>
                                        <textarea name="comment" placeholder="Write a comment." rows="4" required></textarea><br><br>
                                        <input  type="submit" value="Add comment" name="addComment" onsubmit="myFunction();" />
                                    </form><br> </div>
                            </div>
                        </c:forEach>
                        <div class="card-footer">
                            <p style="font-size: 17px; margin-left: 25px; font-weight: 700;">Comments</p></div>
                        <div class="card-footer">
                            <table class="table4comments">

                                <c:forEach var="tempCom" items="${COM_LIST}">

                                    <c:url var="deleteLink" value="CommentServlet">
                                        <c:param name="command" value="DELETE" />
                                        <c:param name="commentId" value="${tempCom.commentId}"/>
                                        <c:param name="username" value='<%=request.getParameter("username")%>'/>
                                    </c:url>  
                                    <tr>

                                        <td><b style="font-size: 14px; margin-right: 20px;">${tempCom.username}</b>${tempCom.date}<br>
                                            <br> ${tempCom.comment} </td>
                                        <td><b style="margin-left: 105px;" hidden="true">${tempCom.commentId}</b> </td>
                                        <td><a href="${deleteLink}">X</a></td>
                                    </tr>
                                </c:forEach>
                            </table><br></div>
                    </div>

                </div>


            </div>

        </div>

    </div>



    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="js/global.js"></script>



</body>
</html>
