<%-- 
    Document   : viewBlogs
    Created on : Nov 16, 2020, 8:33:43 AM
    Author     : Raaid
--%>

<%@page import="Model.LikeDao"%>
<%@page import="Model.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" rel="stylesheet" href="css/viewBlogs.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="css/memberHomePage.css">
        <link rel="icon" href="Images/Capture.PNG" type="image/icon type">
        <link type="text/css" rel="stylesheet" href="css/searchBox.css">
        <!-- Font Awesome -->


        <title>View my blogs</title>
    </head>
    <body>

        <div class="page-wrapper bg-dark p-t-100 p-b-50" >

            <a href="BloggerController" style=text-decoration:none;color:white;padding-left:20px>Go Back</a>
            <br>
            <br>
            <br>
            <form action="BloggerController" style="margin:auto;max-width:1000px;">
                <input type="hidden" class="" name="command" value="SEARCH" />
                <input type="text" placeholder="Please enter keyword.." name="keyword">


            </form>
         

            <h2 class="heading">My blogs</h2 >
            <table style="border:1px solid black;margin-left:auto;margin-right:auto;">
                <tr>
                    <th>Date</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>View</th>
                </tr>
                <c:forEach var="tempBlog" items="${BLOGLIST}">
                    <c:url var="deleteLink" value="BloggerController">
                        <c:param name="command" value="DELETE"/>
                        <c:param name="blogId" value="${tempBlog.blogId}"/>
                    </c:url>
                    <c:url var="viewLink" value="/viewFullBlogPage.jsp">
                        <c:param name="command" value="VIEWFULL"/>
                        <c:param name="blogId" value="${tempBlog.blogId}"/>
                        <c:param name="title" value="${tempBlog.title}"/>
                        <c:param name="body" value="${tempBlog.body}"/>
                        <c:param name="category" value="${tempBlog.category}"/>
                        <c:param name="imageUrl" value="${tempBlog.imageURL}"/>
                        <c:param name="date" value="${tempBlog.date}"/>
                    </c:url>
                    <c:url var="updateLink" value="/updateBlogPage.jsp">
                        <c:param name="command" value="UPDATE"/>
                        <c:param name="blogId" value="${tempBlog.blogId}"/>
                        <c:param name="title" value="${tempBlog.title}"/>
                        <c:param name="body" value="${tempBlog.body}"/>
                    </c:url>
                    <tr>
                        <td>${tempBlog.date}</td>
                        <td>${tempBlog.title}</td>
                        <td>${tempBlog.category}</td>
                        <td><a  class="changeLink" href="${viewLink}">View</a>
                    </tr>
                </c:forEach>
            </table>
            <br>
            <br>
            <h2>  Statistics</h2>
            <div class="trending">
                <div class="trendingCards">
                    <br>
                    <br>
                    <h4> Your most liked post</h4>
                    <h4 class="body" style=>${likeBlog.title}
                    </h4>
                    <img src="${likeBlog.imageURL}" width="300" >
                    <h4>${likeBlog.date}</h4>
                </div>
                <div class="trendingCards">
                    <br>
                    <br>
                    <h4> Your most Commented post</h4>
                    <h4 class="body" style=>${likeBlog.title}
                    </h4>
                    <img src="${commentBlog.imageURL}" width="300">
                    <h4>${commentBlog.date}</h4>
                </div>

            </div>
    </body>
</html>
