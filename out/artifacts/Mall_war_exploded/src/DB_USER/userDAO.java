package DB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class userDAO
{
    public user[] getUser(){
        String dbCmd="SELECT * FROM login INNER JOIN info ON login.id=info.id";
        try
        {
            DBHelper dbHelper=new DBHelper();
            Connection conn=dbHelper.getConnection();
            if(conn==null)
                return null;
            PreparedStatement preState=conn.prepareStatement(dbCmd);
            ResultSet rs=preState.executeQuery();
            rs.last();
            user[] users=new user[rs.getRow()];
            rs.first();
            for(int i=0;i<users.length;i++){
                //users[i].setId(rs.getInt("id"));
                users[i]=new user();
                users[i].setEmail(rs.getString("email"));
                users[i].setUserName(rs.getString("userName"));
                users[i].setPwd(rs.getString("pwd"));
                users[i].isAdmin(rs.getBoolean("isAdmin"));
                users[i].setFirstName(rs.getString("firstName"));
                users[i].setLastName(rs.getString("lastName"));
                users[i].setGender(rs.getString("gender"));
                users[i].setBirthday(rs.getString("birthday"));
                rs.next();
            }
            preState.close();
            rs.close();
            return users;
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }
    public user getUser(int id){
        user user=null;
        String dbCmd="SELECT * FROM login INNER JOIN info ON login.id=info.id WHERE login.id=?";
        try
        {
            DBHelper dbHelper=new DBHelper();
            Connection conn=dbHelper.getConnection();
            if(conn==null)
                return user;
            PreparedStatement preState=conn.prepareStatement(dbCmd);
            preState.setInt(1,id);
            ResultSet rs=preState.executeQuery();
            if(rs.next()){
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("userName"));
                user.setPwd(rs.getString("pwd"));
                user.isAdmin(rs.getBoolean("isAdmin"));
                user.setFirstName(rs.getString("firstName"));
                user.setLastName(rs.getString("lastName"));
                user.setGender(rs.getString("gender"));
                user.setBirthday(rs.getString("birthday"));
            }
            preState.close();
            rs.close();
            return user;
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return user;
    }
}
