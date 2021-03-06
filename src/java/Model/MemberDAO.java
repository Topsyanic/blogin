/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lahiru De silva
 */
public class MemberDAO {
    private final Connection connection;

    public MemberDAO() throws SQLException {
        connection = Database.getConnection();
    }

    public List<Blog> getAllTrendingPosts() throws SQLException {
        List<Blog> Trendingposts = new ArrayList<Blog>();
         
        PreparedStatement preparedStatement = connection.prepareStatement("select * from blogs where status=? and likeCount>=? and commentCount>=? ORDER BY date DESC");
        //preparedStateement to execute the SQL query
        preparedStatement.setString(1, "Accepted");
        preparedStatement.setInt(2, 50);
        preparedStatement.setInt(3, 20);
        ResultSet rs = preparedStatement.executeQuery();
        //executing the preparedStatement objetc

        while (rs.next()) {
            //while the ResultSet object has another value in the set, this while loop will get executed
            int BlogId = rs.getInt("blogId");
            String Title = rs.getString("title");
            String imageURL = rs.getString("imageUrl");
            String userName = rs.getString("username");
            String Category = rs.getString("category");
            String Body = rs.getString("body");
            String date = rs.getString("date");
            int likeCount = rs.getInt("likeCount");
            int commentCount = rs.getInt("commentCount");
            
            //getting all the values in the ResultSet object separately into String variables

            Blog postsList = new Blog(Category,Title,Body,imageURL,userName,BlogId,date,likeCount,commentCount);
            //instantiating object with the String varibales

            Trendingposts.add(postsList);
            //adding the object to the ArrayList

        }
        return Trendingposts;
    }

   

    public List<Blog> getAllFollowerPosts(String username) throws SQLException {
        List<Blog> blogs = new ArrayList<>();
        //PreparedStatement statement = connection.prepareStatement("select * from followers where username=?");
        PreparedStatement statement = connection.prepareStatement("select * from blogs inner join followers where blogs.status=? and blogs.username=followers.followers and followers.username=? ORDER BY date DESC");
        statement.setString(1, "Accepted");
        statement.setString(2, username);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
             int BlogId = rs.getInt("blogId");
            String Title = rs.getString("title");
            String imageURL = rs.getString("imageUrl");
            String userName = rs.getString("username");
            String Category = rs.getString("category");
            String Body = rs.getString("body");
            String date = rs.getString("date");
            int likeCount = rs.getInt("likeCount");
            int commentCount = rs.getInt("commentCount");
            Blog postsList = new Blog(Category,Title,Body,imageURL,userName,BlogId,date,likeCount,commentCount);
            blogs.add(postsList);

        }

        return blogs;
    }

    public boolean upgradeAccount(String username,String role) {
        try{
             PreparedStatement ps = connection.prepareStatement("update users set roles=? where username=?");
             ps.setString(1, role);
             ps.setString(2, username);
             ps.executeUpdate();
             return true;
         }catch (Exception e){
             e.printStackTrace();
          }
        return false;
    }
    
    
}
