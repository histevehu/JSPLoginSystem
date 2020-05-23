package PROCESSOR;

import DB.DBHelper;
import CONFIG._Config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class _Account
{
    public static _Config.USER_NAME_TYPE judgeUserNameType(String userName)
    {
        if (isPureNum(userName))
            return _Config.USER_NAME_TYPE.id;
        else if (isEmail(userName))
            return _Config.USER_NAME_TYPE.email;
        else if (isTrueUserName(userName))
            return _Config.USER_NAME_TYPE.userName;
        else
            return _Config.USER_NAME_TYPE.illegal;

    }

    public static boolean isPureNum(String str)
    {
        for (int i = str.length(); --i >= 0; )
        {
            if (!Character.isDigit(str.charAt(i)))
            {
                return false;
            }
        }
        return true;
    }

    public static boolean isEmail(String str)
    {
        int atpos = str.indexOf("@");
        int dotpos = str.lastIndexOf(".");
        if ((atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= str.length()) || !emailLegalCharCheck(str) || atpos != str.lastIndexOf("@"))

            return false;


        else
            return true;
    }

    public static boolean isTrueUserName(String str)
    {
        if ((isPureNum(str)) || str.trim() == "" || !legalCharCheck(str))
            return false;
        else
            return true;
    }

    public static boolean legalCharCheck(String str)
    {
        for (int i = str.length(); --i >= 0; )
        {
            if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-')))
            {
                return false;
            }
        }
        return true;
    }

    public static boolean emailLegalCharCheck(String str)
    {
        for (int i = str.length(); --i >= 0; )
        {
            if (!((str.charAt(i) >= 'a' && str.charAt(i) <= 'z') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') || (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '_') || (str.charAt(i) == '-') || (str.charAt(i) == '@') || (str.charAt(i) == '.')))
            {
                return false;
            }
        }
        return true;
    }

    public static boolean isUserExisted(String userName, _Config.USER_NAME_TYPE UNT)
    {
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            String dbCmd = "SELECT * from login WHERE " + UNT + " = ?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, userName);
            ResultSet rs = preStmt.executeQuery();
            if (rs.next())
            {
                preStmt.close();
                return true;
            } else
            {
                preStmt.close();
                return false;
            }

        } catch (SQLException e)
        {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean verifyPwd(String userName, _Config.USER_NAME_TYPE UNT, String pwd)
    {
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            String dbCmd = "SELECT * from login WHERE " + UNT + " = ?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, userName);
            ResultSet rs = preStmt.executeQuery();
            rs.next();
            if (rs.getString("pwd").equals(pwd))
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
        } catch (SQLException e)
        {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean isAdmin(String userName, _Config.USER_NAME_TYPE UNT)
    {
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            String dbCmd = "SELECT isAdmin from login WHERE " + UNT + " = ?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, userName);
            ResultSet rs = preStmt.executeQuery();
            if (rs.next())
            {
                return (rs.getBoolean("isAdmin") ? true : false);
            } else
            {
                return false;
            }


        } catch (Exception e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public static Object getLoginParameter(_Config.USER_NAME_TYPE input, String inParam, _Config.USER_NAME_TYPE output)
    {
        Object result=null;
        try
        {
            DBHelper dbHelper = new DBHelper();
            Connection conn = dbHelper.getConnection();
            String dbCmd = "SELECT * from login WHERE " + input.toString() + " = ?";
            PreparedStatement preStmt = conn.prepareStatement(dbCmd);
            preStmt.setString(1, inParam);
            ResultSet rs = preStmt.executeQuery();
            if (rs.next())
            {
                result = (output == _Config.USER_NAME_TYPE.id) ? rs.getInt(output.toString()) : rs.getString(output.toString());
            }
            preStmt.close();
            rs.close();
            return result;

        } catch (SQLException e)
        {
            e.printStackTrace();
            return null;
        }

    }
}
