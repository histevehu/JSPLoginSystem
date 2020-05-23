package DB.DAO;

import DB.DBHelper;
import DB.Entity.DimUser;
import DB.Entity.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDAO extends DAO<User> implements UserDAO_Interface
{
    public int getNum_AllUser()
    {
        String dbCmd = "SELECT COUNT(*) FROM login";
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            if (conn == null)
                return -1;
            PreparedStatement preState = conn.prepareStatement(dbCmd);
            ResultSet rs = preState.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return -2;
    }

    public User[] getAllUsers()
    {
        String dbCmd = "SELECT * FROM login INNER JOIN info ON login.id=info.id";
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            if (conn == null)
                return null;
            PreparedStatement preState = conn.prepareStatement(dbCmd);
            ResultSet rs = preState.executeQuery();
            rs.last();
            User[] Users = new User[rs.getRow()];
            rs.first();
            for (int i = 0; i < Users.length; i++)
            {
                Users[i] = new User();
                Users[i].setId(rs.getInt("id"));
                Users[i].setEmail(rs.getString("email"));
                Users[i].setUserName(rs.getString("userName"));
                Users[i].setPwd(rs.getString("pwd"));
                Users[i].isAdmin(rs.getBoolean("isAdmin"));
                Users[i].setFirstName(rs.getString("firstName"));
                Users[i].setLastName(rs.getString("lastName"));
                Users[i].setGender(rs.getString("gender"));
                Users[i].setBirthday(rs.getString("birthday"));
                rs.next();
            }
            preState.close();
            rs.close();
            return Users;
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public User[] getUsers(int startAt, int size)
    {
        String dbCmd = "SELECT * FROM login INNER JOIN info ON login.id=info.id LIMIT ?,?";
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            if (conn == null)
                return null;
            PreparedStatement preState = conn.prepareStatement(dbCmd);
            preState.setInt(1, startAt);
            preState.setInt(2, size);
            ResultSet rs = preState.executeQuery();
            rs.last();
            User[] Users = new User[rs.getRow()];
            rs.first();
            for (int i = 0; i < Users.length; i++)
            {
                Users[i] = new User();
                Users[i].setId(rs.getInt("id"));
                Users[i].setEmail(rs.getString("email"));
                Users[i].setUserName(rs.getString("userName"));
                Users[i].setPwd(rs.getString("pwd"));
                Users[i].isAdmin(rs.getBoolean("isAdmin"));
                Users[i].setFirstName(rs.getString("firstName"));
                Users[i].setLastName(rs.getString("lastName"));
                Users[i].setGender(rs.getString("gender"));
                Users[i].setBirthday(rs.getString("birthday"));
                rs.next();
            }
            preState.close();
            rs.close();
            return Users;
        } catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    public User getUser(int id)
    {
        User user = null;
        String dbCmd = "SELECT * FROM login INNER JOIN info ON login.id=info.id WHERE login.id=?";
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            if (conn == null)
                return user;
            PreparedStatement preState = conn.prepareStatement(dbCmd);
            preState.setInt(1, id);
            ResultSet rs = preState.executeQuery();
            if (rs.next())
            {
                user = new User();
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


    public User[] getDimUsers(DimUser dimUser)
    {
        String sql = "SELECT login.id,userName,email,pwd,isAdmin,firstName,lastName,gender,birthday FROM info INNER JOIN login ON login.id=info.id  WHERE userName LIKE ? AND firstName LIKE ? AND lastName LIKE ?";
        List<User> dimIDList = getForList(sql, dimUser.getUserName().trim().equals("") ? "%%" : "%" + dimUser.getUserName() + "%", dimUser.getFirstName().trim().equals("") ? "%%" : "%" + dimUser.getFirstName() + "%", dimUser.getLastName().trim().equals("") ? "%%" : "%" + dimUser.getLastName() + "%");
        User[] result = new User[dimIDList.size()];
        for (int i = 0; i < dimIDList.size(); i++)
        {
            result[i] = dimIDList.get(i);
        }
        return result;
    }

    public void delUser(int id)
    {
        String sql = "DELETE login,info FROM login LEFT JOIN info ON login.id = info.id WHERE login.id=?";
        update(sql, id);
    }

    public void modifyUser(User user)
    {
        String sql = "UPDATE login,info SET pwd=?,firstName=?,lastName=?,gender=?,birthday=? WHERE login.id=? AND info.id=?";
        update(sql, user.getPwd(), user.getFirstName(), user.getLastName(), user.getGender(), user.getBirthday(), user.getId(), user.getId());
    }

    public boolean isUserExisted(String type, String val)
    {
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            String dbCmd = "SELECT * FROM login WHERE "+type+"= ?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, String.valueOf(val));
            ResultSet rs = preStmt.executeQuery();
            if (rs.next())
            {
                preStmt.close();
                rs.close();
                return true;
            } else
            {
                preStmt.close();
                rs.close();
                return false;
            }
        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;

    }


}
