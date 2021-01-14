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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Lahiru De silva
 */
public class FollowDAO {

    private final Connection connection;

    public FollowDAO() throws SQLException {
        connection = Database.getConnection();
    }

    public boolean follow(Follow follow) {
        try {
            PreparedStatement ps = connection.prepareStatement("insert into followers(username, followers, status)" + "values(?,?,?)");
            ps.setString(1, follow.getUsername());
            ps.setString(2, follow.getFollowers());
            ps.setString(3, "following");

            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAO.class.getName()).log(Level.SEVERE, null, ex);
            return true;
        }
        return false;

    }

    public List<Users> viewAllUsers() {
        List<Users> users = new ArrayList<>();
        try {
            PreparedStatement statement = connection.prepareStatement("select users.* from users left join followers on (users.username=followers.followers or users.username=followers.username) where followers.followers is NULL and roles!=?;");
            statement.setString(1,"moderator");
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                String username = rs.getString("username");
                String photoUrl = rs.getString("photoUrl");
                Users user = new Users(username, photoUrl);
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }
        return users;
    }

    public List<Users> viewAllFollowers(String Username) throws SQLException {
        List<Users> followers = new ArrayList<>();
        //PreparedStatement statement = connection.prepareStatement("select * from followers where username=?");
        PreparedStatement statement = connection.prepareStatement("select users.`photoUrl`,followers.status,followers.followers from users inner join followers where users.username=followers.followers and followers.username=?");
        statement.setString(1, Username);
        ResultSet rs = statement.executeQuery();
        while (rs.next()) {
            String Followers = rs.getString("followers");
            String Status = rs.getString("status");
            String photoUrl = rs.getString("photoUrl");
            Users follow = new Users(Username, Followers, Status, photoUrl);
            followers.add(follow);

        }

        return followers;
    }

    public List<Blog> getAllBloggerPosts(String username) throws SQLException {
        List<Blog> posts = new ArrayList<Blog>();

        PreparedStatement preparedStatement = connection.prepareStatement("select * from blogs where username=?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String BlogId = rs.getString("blogId");
            String Title = rs.getString("title");
            String imageURL = rs.getString("imageUrl");
            String userName = rs.getString("username");
            String Category = rs.getString("category");
            String Body = rs.getString("body");
            String date = rs.getString("date");
            Blog postsList = new Blog(Integer.parseInt(BlogId),Category,Title,Body,imageURL,userName,date);

            posts.add(postsList);
        }
        return posts;
    }

    public List<Users> getAllUserDetails(String username) throws SQLException {
        List<Users> user = new ArrayList<Users>();
        PreparedStatement preparedStatement = connection.prepareStatement("select * from users where username=?");
        preparedStatement.setString(1, username);
        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()) {
            String Fname = rs.getString("firstName");
            String Lname = rs.getString("lastName");
            String userName = rs.getString("username");
            // String date = rs.getString("dob"); 
            String Email = rs.getString("email");
            String Photo = rs.getString("photoUrl");
            Users viewPer = new Users(Fname, Lname, userName, Email, Photo);
            user.add(viewPer);
        }
        return user;
    }
}
